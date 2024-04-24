import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'user_chat_screen.dart';

Widget chatUserTile(int i) {
  return InkWell(
    onTap: () => Get.to(() => UserChatScreen()),
    child: Container(
      padding: EdgeInsets.only(bottom: 20, top: i == 0 ? 20 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileAvatar(
                imageUrl:
                    "https://userallimages.s3.amazonaws.com/1713690633316-upload.txt",
                size: 48,
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff0FE16D),
                  ),
                ),
              ).marginOnly(right: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Last Message",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff797C7B),
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "2 min ago",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xff797C7B),
                ),
              ),
              Container(
                width: 22.w,
                alignment: Alignment.center,
                child: Text(
                  "3",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffF04A4C),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

AppBar userChatAppBar(String tittle) {
  return AppBar(
    backgroundColor: Color(0xffF3F3F3),
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileAvatar(
          imageUrl:
              "https://userallimages.s3.amazonaws.com/1713690633316-upload.txt",
          size: 48,
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff0FE16D),
            ),
          ),
        ).marginOnly(right: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Name",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff050506)),
            ),
            Text(
              "Active 2 min ago",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xff6A5C70),
              ),
            ),
          ],
        )
      ],
    ),
    leading: InkWell(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        "assets/images/back_white.png",
        height: 40.h,
        width: 40.w,
      ),
    ),
    actions: [
      Image.asset(
        "assets/images/menu_white.png",
        height: 40.h,
        width: 40.w,
      ).marginOnly(right: 10.w),
    ],
  );
}

Widget chatTextBox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F7F8), // Background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter text here', // Placeholder text
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.mic, color: Colors.grey), // Microphone icon
            SizedBox(width: 4.0),
            Icon(Icons.push_pin, color: Colors.grey), // Pin icon
          ],
        ),
      ),
    ),
  );
}
