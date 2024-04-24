import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:checkedln/views/chats/chat_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../profiles/profile_avatar.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: userChatAppBar("djk"),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets, child: chatTextBox()),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/chat_star.png"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text("1st Shared Moment:",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffF4E4FC))),
                  ],
                ),
                Text("Arijit Singh Concert, June 2024",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFAF1FD),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xff5227CD),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.w.h),
                    bottomRight: Radius.circular(20.w.h)),
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Color(0xffAD2EE5), width: 1.0))),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: i == 9
                      ? DateChip(
                          color: Color(0xffF8F7F8),
                          date: DateTime.now(),
                        )
                      : Column(
                          crossAxisAlignment: (i % 2 == 0)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            (i % 2 != 0)
                                ? Row(
                                    children: [
                                      ProfileAvatar(
                                        imageUrl:
                                            "https://userallimages.s3.amazonaws.com/1713690633316-upload.txt",
                                        size: 32,
                                        child: SizedBox.shrink(),
                                      ).marginOnly(right: 2.w),
                                      Text(
                                        "User Name",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff050506)),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            BubbleNormal(
                              tail: true,
                              text: 'bubble special tow with tail',
                              isSender: (i % 2 == 0) ? true : false,
                              color:
                                  Color((i % 2 == 0) ? 0xFFAD2EE5 : 0xffF7EFFA),
                              textStyle: TextStyle(
                                fontSize: 15.sp,
                                color: (i % 2 == 0)
                                    ? Colors.white
                                    : Color(0xff28222A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "09:25 AM",
                              style: TextStyle(
                                  color: Color(0xff85738C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ).marginOnly(
                                top: 1.h,
                                bottom: 1.h,
                                left: (i % 2 == 0) ? 0 : 18.w,
                                right: (i % 2 == 0) ? 18.w : 0),
                          ],
                        ),
                );
              },
              itemCount: 10,
            ),
          )
        ],
      )),
    );
  }
}
