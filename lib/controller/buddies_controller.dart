import 'package:get/get.dart';

import '../models/user/user_profile_model.dart';
import '../services/user/userServices.dart';
import 'package:dio/dio.dart' as dio;

class BuddiesController extends GetxController {
  RxList<User> buddies = <User>[].obs;
  RxBool isLoading = false.obs;
  UserServices _userServices = UserServices();

  getBuddies(String userId) async {
    isLoading.value = true;
    try {
      dio.Response response = await _userServices.getBuddies(userId);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["success"]) {
        List list = response.data["buddies"];
        print(list);
        buddies.clear();
        for (int i = 0; i < list.length; i++) {
          User userProfileModel = User.fromJson(list[i]);
          buddies.add(userProfileModel);
        }
      }
      print(buddies);
    } catch (e) {}

    isLoading.value = false;
  }
}
