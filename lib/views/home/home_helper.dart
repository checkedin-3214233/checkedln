import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/views/chats/chat_screen.dart';
import 'package:checkedln/views/checkin/checkin_screen.dart';
import 'package:checkedln/views/post/post_screen.dart';
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
              if(index==1){
                Get.to(()=>ChatScreen());
              }else if(index ==2){
                Get.to(()=>PostScreen());
              }else if(index==3){
                Get.to(()=>CheckInScreen());
              }
            },
            icon: Image.asset(_homeController.currentBottomIndex.value == index
                ? _homeController.bottomNavigationJson["items"]![index]
                        ["selectedIcon"]
                    .toString()
                : _homeController.bottomNavigationJson["items"]![index]["icon"]
                    .toString(),width: 50,height: 50,),
          ),
          _homeController.currentBottomIndex.value == index? Image.asset("assets/images/selectedBottom.png"):SizedBox.shrink()
        ],
      ));
}
