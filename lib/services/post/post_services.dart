import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class PostServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _post = dotenv.env['POST']!;
  createPost(
      List images, List userIds, String location, String description) async {
    var data = {
      "images": images,
      "friends": userIds,
      "location": location,
      "description": description
    };
    try {
      Response response = await dioNetwork.postData(_post, data: data);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());

      return null;
    }
  }
  getPost()async{
    try {
      Response response = await dioNetwork.getData(_post);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());

      return null;
    }
  }
}
