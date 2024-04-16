import 'package:checkedln/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget bottomItem(int index) {
  HomeController _homeController = Get.find<HomeController>();
  return Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              _homeController.currentBottomIndex.value = index;
            },
            icon: Image.asset(_homeController.currentBottomIndex.value == index
                ? _homeController.bottomNavigationJson["items"]![index]
                        ["selectedIcon"]
                    .toString()
                : _homeController.bottomNavigationJson["items"]![index]["icon"]
                    .toString()),
          ),
          Image.asset("assets/images/selectedBottom.png")
        ],
      ));
}
