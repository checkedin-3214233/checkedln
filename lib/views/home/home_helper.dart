import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/views/chats/chat_screen.dart';
import 'package:checkedln/views/checkin/checkin_screen.dart';
import 'package:checkedln/views/home/story_view.dart';
import 'package:checkedln/views/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../notification/notification_screen.dart';
import '../profiles/profile_avatar.dart';
import '../search/search_screen.dart';

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
              if (index == 1) {
                Get.to(() => ChatScreen());
              } else if (index == 2) {
                Get.to(() => PostScreen());
              } else if (index == 3) {
                Get.to(() => CheckInScreen());
              }
            },
            icon: Image.asset(
              _homeController.currentBottomIndex.value == index
                  ? _homeController.bottomNavigationJson["items"]![index]
                          ["selectedIcon"]
                      .toString()
                  : _homeController.bottomNavigationJson["items"]![index]
                          ["icon"]
                      .toString(),
              width: 50,
              height: 50,
            ),
          ),
          _homeController.currentBottomIndex.value == index
              ? Image.asset("assets/images/selectedBottom.png")
              : SizedBox.shrink()
        ],
      ));
}

AppBar appBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Image.asset("assets/images/logo.png"),
    actions: [
      Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: InkWell(
              onTap: () {
                Get.to(() => SearchScreen());
              },
              child: Image.asset("assets/images/search.png"))),
      Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: InkWell(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Image.asset("assets/images/notifiction.png")))
    ],
  );
}

Widget storyView() {
  return SizedBox(
    height: 72.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return i == 0
              ? Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          width: 56,
                          height: 56,
                          child: Image.asset(
                            "assets/images/addhome.png",
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffEBE9EC),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          "Your Status",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000)),
                        )
                      ],
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    Get.to(() => MoreStories());
                  },
                  child: SizedBox(
                    width: 56.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileAvatar(
                          imageUrl:
                              'https://www.shutterstock.com/image-photo/excited-happy-young-indian-man-260nw-2118627149.jpg',
                          size: 56,
                          child: SizedBox.shrink(),
                          borderColor: Color(0xff9f2fe5),
                        ),
                        Text(
                          "Krish Gupta",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000)),
                        )
                      ],
                    ),
                  ),
                );
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: 10),
  );
}

Widget suggestion() {
  return SizedBox(
    height: 180.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Container(
            width: 140.w,
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileAvatar(
                    imageUrl:
                        "https://www.shutterstock.com/image-photo/excited-happy-young-indian-man-260nw-2118627149.jpg",
                    size: 64,
                    child: SizedBox.shrink(),
                    borderColor: Color(0xffEDEDED)),
                Text(
                  "Rohit Singh",
                  style: TextStyle(
                      color: Color(0xff050506),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                Text(
                  "rohit90",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Color(0xff4A404F)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w.h),
                      color: Color(0xFFAD2EE5)),
                  child: Text(
                    "Catch-up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w.h),
                color: Color(0xFFEDEDED)),
            padding: EdgeInsets.all(15.w.h),
          );
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: 10),
  ).marginSymmetric(vertical: 10.h);
}
