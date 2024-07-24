import 'dart:convert';
import 'dart:developer';

import 'package:checkedln/controller/notification_controller.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../checkin/checkin_info.dart';
import '../widget_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotifiacationController _notifiacationController =
      Get.find<NotifiacationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar("Notifications", [], SizedBox.shrink(), false),
      body: SafeArea(
          child: Obx(() => ListView.builder(
              itemCount: _notifiacationController.notificationList.length,
              itemBuilder: (context, i) {
                Map<String, dynamic> data = json.decode(_notifiacationController
                    .notificationList[i].notificationData!);
                log("Krish" + data.toString());
                return ListTile(
                  subtitle: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _notifiacationController.acceptInvite(
                              _notifiacationController
                                  .notificationList[i].fromUser!.id!,
                              data["event"]["_id"]);
                        },
                        child: Container(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: Color(0xffAD2EE5),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        child: Text(
                          "Decline",
                          style: TextStyle(
                              color: Color(0xff6A5C70),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff6A5C70)),
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      // ctx!.push(CheckInInfo(
                      //   eventId: data["event"]["_id"],
                      //   checkInId: data["event"]["checkInId"],
                      // ));
                    },
                    child: Image.network(
                      data["event"]["bannerImages"],
                      height: 42.h,
                      width: 42.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileAvatar(
                        imageUrl: _notifiacationController.notificationList[i]
                                .fromUser!.profileImageUrl!.isNotEmpty
                            ? _notifiacationController
                                .notificationList[i].fromUser!.profileImageUrl!
                            : "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                        size: 42,
                        borderColor: Colors.transparent,
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                "${_notifiacationController.notificationList[i].fromUser!.name} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Color(0xff050506))),
                        TextSpan(
                            text:
                                "wants to join your event ${data["event"]["checkInName"]} ${formatDateDifference(_notifiacationController.notificationList[i].createdAt!)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF85738C),
                                fontSize: 16.sp)),
                      ],
                    ),
                  ),
                );
              }))),
    );
  }
}

String formatDateDifference(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}min';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}d';
  } else {
    final months = now.month - date.month + (12 * (now.year - date.year));
    return '${months}mon';
  }
}
