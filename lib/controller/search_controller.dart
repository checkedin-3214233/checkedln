import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../models/user/userModel.dart';
import '../services/user/userServices.dart';

class MainSearchController extends GetxController{
  TextEditingController searchEditingController = TextEditingController();
  var users = <UserModel>[].obs;

  searchUser() async {
    if (searchEditingController.text.isEmpty || searchEditingController.text.length < 3) {
      return;
    }
    dio.Response response =
    await UserServices().searchUser(searchEditingController.text);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var usersList = response.data["users"];
      print("krish" + usersList.toString());
      users.clear();
      for (int i = 0; i < usersList.length; i++) {
        UserModel userModel = UserModel.fromJson(usersList[i]);
        users.add(userModel);
        update();
      }
      update();
      print("krish1" + users.toString());
    }
  }

}