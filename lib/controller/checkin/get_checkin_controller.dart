import 'package:checkedln/global_index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../models/checkIn/main_event_model.dart';
import '../../models/user/userModel.dart';
import '../../services/checkIn/check_in_services.dart';

class GetCheckInController extends GetxController {
  var isLoading = false.obs;
  Rx<MainEventModel>? eventModel;
  CheckInServices _checkInServices = CheckInServices();
  GetCheckInController() {}
  getEventId(String id) async {
    isLoading.value = true;
    dio.Response response = await _checkInServices.getEventById(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      MainEventModel eventModel = MainEventModel.fromJson(response.data);
      this.eventModel = eventModel.obs;
      update();
    }
    isLoading.value = false;
  }

  getMutuals(List<UserModel> list1, List<dynamic> list2) {
    List<String> newList = [];
    List<String> newList2 = [];
    for (var element in list1) {
      newList.add(element.id!);
    }
    for (var element in list2) {
      newList2.add(element);
    }
    Set<String> set1 = newList.toSet();
    Set<String> set2 = newList2.toSet();

    // Find common elements
    Set<String> commonElements = set1.intersection(set2);

    // Convert the set back to a list if needed
    List<String> commonList = commonElements.toList();

    print('Common elements: $commonList');
    return commonList.length;
  }

  getList(List<UserModel> list) {}

  joinEvent(String id) async {
    dio.Response response = await _checkInServices.joinEvent(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        content: Text(response.data["message"]),
      );

      ScaffoldMessenger.of(ctx!).showSnackBar(snackBar);
      return true;
    }
    return false;
  }
}
