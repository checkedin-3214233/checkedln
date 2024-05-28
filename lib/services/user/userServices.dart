import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class UserServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _user = dotenv.env['USER']!;
  final String _update = dotenv.env['UPDATE_USER']!;
  final String _search = dotenv.env['SEARCH_USER']!;
  final String _getUserById = dotenv.env['GET_USER_BYID']!;
  final String _catchUpUser = dotenv.env['CATCH_UP_USER']!;
  final String _acceptCatchUp = dotenv.env['ACCEPT_CATCH_UP']!;
  final String _rejectCatchUp = dotenv.env['REJECT_CATCH_UP']!;

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

  searchUser(String name) async {
    var data = {"userName": name};
    try {
      Response response =
          await dioNetwork.postData(_user + _search, data: data);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getUserById(String id) async {
    try {
      Response response = await dioNetwork.getData(_user + _getUserById + id);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  catchUpUser(String id) async {
    try {
      Response response = await dioNetwork.getData(_user + _catchUpUser + id);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  acceptCatchUp(String id) async {
    try {
      Response response = await dioNetwork.getData(_user + _acceptCatchUp + id);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  rejectCatchUp(String id) async {
    try {
      Response response = await dioNetwork.getData(_user + _rejectCatchUp + id);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
