import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/views/profiles/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import 'home_helper.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController _homeController = Get.put(HomeController());
  UserController _userController = Get.put(UserController());

@override
  void initState() {
    // TODO: implement initState
  _userController.getUser();

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
      body: Obx(() => _homeController.currentBottomIndex.value == 0
          ? HomeScreen()
          : _homeController.currentBottomIndex.value == 4
              ? MyProfileScreen()
              : SizedBox.shrink()),
    );
  }
}
