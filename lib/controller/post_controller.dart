import 'dart:developer';
import 'dart:io';

import 'package:checkedln/models/post/post_model.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/services/post/post_services.dart';
import 'package:checkedln/services/user/userServices.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../res/snakbar.dart';
import '../services/upload_image.dart';

class PostController extends GetxController {
  var localImagesList = [].obs;
  var isCreatingPost = false.obs;
  var userIds = [].obs;
  var users = <UserModel>[].obs;
  var showDropdown = false.obs;
  var myPost = [].obs;
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController friendsController = TextEditingController();
  PostServices _postServices = PostServices();
  pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    for (var i = 0; i < images.length; i++) {
      localImagesList.add(images[i].path);
      update();
    }
  }

  addElements(UserModel user) {
    for (var i = 0; i < userIds.length; i++) {
      if (user.userName == userIds[i].userName) {
        users.clear();
        update();
        return;
      }
    }
    userIds.add(user);
    users.clear();
    update();
  }

  validatePost() {
    if (localImagesList.isEmpty) {
      showSnakBar(
        "Please select atleast one  images",
      );
      return false;
    }

    if (locationController.text.isEmpty) {
      Get.rawSnackbar(message: "Please enter location");
      return false;
    }

    return true;
  }

  createPost() async {
    isCreatingPost.value = true;
    if (!validatePost()) return;
    List ids = [];
    List images = [];
    for (int i = 0; i < userIds.length; i++) {
      ids.add(userIds[i].id);
    }
    for (int i = 0; i < localImagesList.length; i++) {
      images.add(await uploadImage(localImagesList[i]));
    }
    dio.Response response = await _postServices.createPost(
        images, ids, locationController.text, descriptionController.text);
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      List list = response.data["post"]["images"];
      myPost.add(PostModel(
          images: list.asMap().entries.map((e) => e.value.toString()).toList(),
          friends: [],
          location: response.data["post"]["location"],
          description: response.data["post"]["description"],
          id: "1",
          likes: []));
      Get.rawSnackbar(message: "Post created successfully");
      Navigator.pop(Get.overlayContext!);
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    isCreatingPost.value = false;
  }

  Future<String> uploadImage(String path) async {
    UploadImage uploadImage = UploadImage();
    return await uploadImage.uploadImage(File(path));
  }

  searchUser() async {
    if (friendsController.text.isEmpty || friendsController.text.length < 3) {
      return;
    }
    dio.Response response =
        await UserServices().searchUser(friendsController.text);
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

  getPost() async {
    dio.Response response = await _postServices.getPost();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List list = response.data["post"];
      for (var i = 0; i < list.length; i++) {
        PostModel postModel = PostModel.fromJson(list[i]);
        myPost.add(postModel);
        update();
      }
    }
  }
}
