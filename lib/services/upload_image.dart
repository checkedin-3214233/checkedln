import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UploadImage {
  Dio dio = Dio();
  Future<String> uploadImage(File file) async {
    String url = "${dotenv.env['BASE_URL']}${dotenv.env['UPLOAD']}";
    print(url);
    try {
      // Create FormData and add the file to be uploaded
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path, filename: 'upload.txt'),

      });

      // Send FormData with post request using Dio
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            // Replace with your headers if needed

            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Handle the response
      log('Krih Response status: ${response.statusCode}');
      log('Krish Response data: ${response.data}');
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["isSuccess"]) {
        return response.data["data"];
      }
      return "";

      // You can add more logic here based on the response
    } catch (e) {
      print('Error uploading file: $e');
      // Handle error accordingly
      return "";
    }
  }
}
