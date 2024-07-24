import 'dart:developer';

import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/controller/post_controller.dart';
import 'package:checkedln/controller/story_controller.dart';
import 'package:checkedln/views/profiles/my_profile_screen.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../controller/checkin/check_in_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/user_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../services/socket_services.dart';
import 'home_helper.dart';
import 'home_loading.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CheckInController _checkInController = Get.put(CheckInController());

  final HomeController _homeController = Get.put(HomeController());
  final UserController _userController = Get.put(UserController());
  final ChatController _chatController = Get.put(ChatController());
  final PostController _postController = Get.put(PostController());
  final StoryController _storyController = Get.put(StoryController());

  final NotifiacationController _notifiacationController =
      Get.put(NotifiacationController());
  @override
  void initState() {
    // TODO: implement initState
    _homeController.getEveryData(
        _checkInController,
        _userController,
        _chatController,
        _postController,
        _notifiacationController,
        _storyController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 66.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0;
                i < _homeController.bottomNavigationJson["items"]!.length;
                i++)
              bottomItem(i)
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2), // Move the shadow up slightly
              blurRadius: 32,
              spreadRadius: 0,
              color: Color(0x00000012), // Color with opacity
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      body: Obx(() => _homeController.loading.value
          ? HomeLoading()
          : _homeController.currentBottomIndex.value == 0
              ? HomeScreen()
              : _homeController.currentBottomIndex.value == 4
                  ? MyProfileScreen()
                  : SizedBox.shrink()),
    );
  }
}
