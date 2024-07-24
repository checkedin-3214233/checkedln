import 'dart:developer';

import 'package:checkedln/controller/chat_controller.dart';
import 'package:checkedln/controller/checkin/check_in_controller.dart';
import 'package:checkedln/controller/notification_controller.dart';
import 'package:checkedln/controller/post_controller.dart';
import 'package:checkedln/controller/story_controller.dart';
import 'package:checkedln/controller/user_controller.dart';
import 'package:checkedln/services/location/location_service.dart';
import 'package:checkedln/services/user/contactServices.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:permission_handler/permission_handler.dart';
import '../data/injection/dependency_injection.dart';
import '../data/local/cache_manager.dart';
import '../models/user/userModel.dart';
import '../services/Permission/permission_phone.dart';

class HomeController extends GetxController {
  var currentBottomIndex = 0.obs;
  var suggestedUsers = <UserModel>[].obs;
  var loading = false.obs;
  var bottomNavigationJson = {
    "items": [
      {
        "icon": "assets/images/home.svg",
        "selectedIcon": "assets/images/homeSelected.svg",
        "title": "Home"
      },
      {
        "icon": "assets/images/chat.svg",
        "selectedIcon": "assets/images/chat.svg",
        "title": "Chat"
      },
      {
        "icon": "assets/images/addPost.svg",
        "selectedIcon": "assets/images/addPost.svg",
        "title": "Add Post"
      },
      {
        "icon": "assets/images/checkIn.svg",
        "selectedIcon": "assets/images/checkIn.svg",
        "title": "Check In"
      },
      {
        "icon": "assets/images/profile.svg",
        "selectedIcon": "assets/images/profileSelected.svg",
        "title": "Profile"
      }
    ]
  };
  HomeController() {
    getLocation();
  }
  getEveryData(
      CheckInController _checkInController,
      UserController _userController,
      ChatController _chatController,
      PostController _postController,
      NotifiacationController _notifiacationController,
      StoryController _storyController) async {
    loading.value = true;

    await Future.wait([
      getContacts(),
      _checkInController.getFriendsCheckIn(),
      _userController.getUser(),
      _chatController.getChats(),
      // _postController.getPost();
      _checkInController.getPastEvent(),
      _notifiacationController.getNotification(),
      _storyController.getStroies(),
    ]).then((value) => null).whenComplete(() => loading.value = false);
    log("message5");
    loading.value = false;
  }

  getLocation() async {
    await getIt<LocationService>().checkLocation();
    await getIt<LocationService>().getLocation();
  }

  getSuggestedUser() async {
    List list = await getContacts();
    print("Suggested" + list.toString());
  }

  Future getContacts() async {
    // Get all contacts (fully fetched)
    if (getIt<PermissionPhone>().permissionStatus == PermissionStatus.granted) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      List phones = [];
      for (var contact in contacts) {
        for (var phone in contact.phones) {
          phones.add(phone.number.removeAllWhitespace.toString());
        }
      }
      log("Suggested" + phones.toString());
      dio.Response response = await ContactsServices().getSuggestedUser(phones);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List list = response.data["users"];
        log("Suggested" + list.toString());
        for (int i = 0; i < list.length; i++) {
          UserModel user = UserModel.fromJson(list[i]);
          if (user.id != getIt<CacheManager>().getUserId()) {
            suggestedUsers.add(UserModel.fromJson(list[i]));
          }
        }
      }
    }
  }
}
