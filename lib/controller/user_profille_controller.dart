import 'package:checkedln/controller/user_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:go_router/go_router.dart';
import '../models/user/user_profile_model.dart';
import '../services/user/userServices.dart';

class UserProfileController extends GetxController {
  UserServices _userServices = UserServices();
  var userProfileModel = Rxn<UserProfileModel>();
  var isLoading = false.obs;
  var isCatchupLoading = false.obs;
  getUserById(String id) async {
    // Get user by id
    isLoading.value = true;
    dio.Response response = await _userServices.getUserById(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      userProfileModel.value = UserProfileModel.fromJson(response.data);
      update();
    } else {
      ctx!.pop();
    }
    isLoading.value = false;
  }

  isBuddy() {
    String userId = getIt<CacheManager>().getUserId();
    return userProfileModel.value!.user!.buddies!.contains(userId);
  }

  catchupUser(String id) async {
    isCatchupLoading.value = true;
    dio.Response response = await _userServices.catchUpUser(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        content: Text(response.data["message"]),
      );

      ScaffoldMessenger.of(ctx!).showSnackBar(snackBar);
      userProfileModel.value = UserProfileModel(
          success: userProfileModel.value!.success,
          message: userProfileModel.value!.message,
          user: userProfileModel.value!.user,
          isRequested: userProfileModel.value!.isRequested,
          isSent: true);

      update();
    }
    isCatchupLoading.value = false;
  }

  acceptCatchUp(String id) async {
    isCatchupLoading.value = true;
    dio.Response response = await _userServices.acceptCatchUp(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        content: Text(response.data["message"]),
      );

      ScaffoldMessenger.of(ctx!).showSnackBar(snackBar);
      Get.find<UserController>().getUser();

      List<String> buddies = userProfileModel.value!.user!.buddies!;
      buddies.add(getIt<CacheManager>().getUserId());
      userProfileModel.value = UserProfileModel(
          success: userProfileModel.value!.success,
          message: userProfileModel.value!.message,
          user: User(
              id: userProfileModel.value!.user!.id,
              name: userProfileModel.value!.user!.name,
              userName: userProfileModel.value!.user!.userName,
              phone: userProfileModel.value!.user!.phone,
              profileImageUrl: userProfileModel.value!.user!.profileImageUrl,
              notificationToken:
                  userProfileModel.value!.user!.notificationToken,
              dateOfBirth: userProfileModel.value!.user!.dateOfBirth,
              gender: userProfileModel.value!.user!.gender,
              userImages: userProfileModel.value!.user!.userImages,
              bio: userProfileModel.value!.user!.bio,
              buddies: buddies,
              createdAt: userProfileModel.value!.user!.createdAt,
              updatedAt: userProfileModel.value!.user!.updatedAt,
              v: userProfileModel.value!.user!.v),
          isRequested: false,
          isSent: false);
      update();
    }
    isCatchupLoading.value = false;
  }

  rejectCatchUp(String id) async {
    isCatchupLoading.value = true;
    dio.Response response = await _userServices.rejectCatchUp(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        content: Text(response.data["message"]),
      );

      ScaffoldMessenger.of(ctx!).showSnackBar(snackBar);
      userProfileModel.value = UserProfileModel(
          success: userProfileModel.value!.success,
          message: userProfileModel.value!.message,
          user: userProfileModel.value!.user,
          isRequested: false,
          isSent: false);
      update();
    }
    isCatchupLoading.value = false;
  }
}
