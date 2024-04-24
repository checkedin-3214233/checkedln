import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class UserServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _user = dotenv.env['USER']!;
  final String _update = dotenv.env['UPDATE_USER']!;

  Future<dynamic> getUser() async {
    log(_user + _update);
    try {
      Response response = await dioNetwork.getData(
        _user,
      );
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> updateUser(
      String userName,
      String name,
      String profileImageUrl,
      DateTime dateOfBirth,
      String gender,
      String bio) async {
    Map<String, String> data = {
      "name": name,
      "userName": userName,
      "profileImageUrl": profileImageUrl,
      "dateOfBirth": dateOfBirth.toUtc().toString(),
      "gender": gender,
      "bio": bio
    };

    log(data.toString());

    try {
      Response response =
          await dioNetwork.postData(_user + _update, data: data);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
