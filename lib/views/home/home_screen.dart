import 'dart:developer';

import 'package:checkedln/controller/notification_controller.dart';
import 'package:checkedln/controller/post_controller.dart';
import 'package:checkedln/controller/story_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global_index.dart';
import 'package:checkedln/services/Permission/permission_phone.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/widget_helper.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/chat_controller.dart';
import '../../controller/checkin/check_in_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/user_controller.dart';
import '../../res/colors/routes/route_constant.dart';
import 'home_helper.dart';
import 'story_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CheckInController _checkInController = Get.find<CheckInController>();
  final HomeController _homeController = Get.find<HomeController>();
  final UserController _userController = Get.find<UserController>();
  final PostController _postController = Get.find<PostController>();
  final StoryController _storyController = Get.find<StoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: CustomMaterialIndicator(
        onRefresh: () async {
          log("message");

          _homeController.getLocation();
          _homeController.getEveryData(
              _checkInController,
              _userController,
              Get.find<ChatController>(),
              _postController,
              Get.find<NotifiacationController>(),
              _storyController);
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 30,
          );
        },
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => storyView(_storyController)),
                Divider(
                  thickness: 1,
                  color: Color(0xffEBE9EC),
                ),
                Obx(() => _checkInController.liveEvents.isEmpty
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          SvgPicture.asset("assets/images/liveLogo.svg"),
                          Text(
                            "Live Check-ins",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(0xff050506),
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                Obx(() => _checkInController.liveEvents.isEmpty
                    ? SizedBox.shrink()
                    : liveCheckIn()),
                Text(
                  "Nearby Check-ins",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xff050506),
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp),
                ),
                nearByCheckIn(),
                Obx(() => _homeController.suggestedUsers.isEmpty ||
                        _userController.userModel.value!.buddies!.length > 3
                    ? SizedBox.shrink()
                    : Text(
                        "Suggestions",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xff050506),
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp),
                      )),
                Obx(() => _homeController.suggestedUsers.isEmpty ||
                        _userController.userModel.value!.buddies!.length > 3
                    ? SizedBox.shrink()
                    : suggestion()),
                Obx(() => _checkInController.popularEvents.isEmpty ||
                        _checkInController.friendsCheckIn.isNotEmpty
                    ? SizedBox.shrink()
                    : Text(
                        "Popular Check-ins",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xff050506),
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp),
                      )),
                Obx(() => _checkInController.popularEvents.isEmpty ||
                        _checkInController.friendsCheckIn.isNotEmpty
                    ? SizedBox.shrink()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              ctx!.push(
                                "${RoutesConstants.checkin}/${_checkInController.popularEvents[i].id!}/${"m"}/${false}",
                              );
                            },
                            child: Container(
                              height: 150.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      ProfileAvatar(
                                          imageUrl:
                                              "https://www.shutterstock.com/image-photo/excited-happy-young-indian-man-260nw-2118627149.jpg",
                                          size: 24,
                                          child: SizedBox.shrink(),
                                          borderColor: Color(0xffEBEBEB)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text("Tushar Shah",
                                          style: TextStyle(
                                              color: Color(0xff050506),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "2 min ago",
                                        style: TextStyle(
                                            color: Color(0xff85738C),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/liveEvent.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          _checkInController.popularEvents[i]
                                              .location!.address!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff9219C7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/peoplelive.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "Attendees",
                                        style: TextStyle(
                                            color: Color(0xff6A5C70),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        _checkInController
                                            .popularEvents[i].attendies!.length!
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xff28222A),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp),
                                      )
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: _checkInController
                                                .popularEvents[i].interested!
                                                .contains(getIt<CacheManager>()
                                                    .getUserId())
                                            ? Color(0xff9219C7)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.w.h)),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/like.png"),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "Interested",
                                          style: TextStyle(
                                              color: Color(0xff4A404F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(12.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w.h),
                                  color: Color(0xFFEBEBEB)),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h));
                        },
                        itemCount: _checkInController.popularEvents.length)),
                Obx(() => _checkInController.friendsCheckIn.isEmpty
                    ? SizedBox.shrink()
                    : Text(
                        "Friends Check-ins",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xff050506),
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp),
                      )),
                Obx(() => _checkInController.friendsCheckIn.isEmpty
                    ? SizedBox.shrink()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              ctx!.push(
                                "${RoutesConstants.checkin}/${_checkInController.friendsCheckIn[i].event!.id!}/${"m"}/${false}",
                              );
                            },
                            child: Container(
                              height: 150.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      ProfileAvatar(
                                          imageUrl: _checkInController
                                              .friendsCheckIn[i]
                                              .buddy!
                                              .profileImageUrl!,
                                          size: 24,
                                          child: SizedBox.shrink(),
                                          borderColor: Color(0xffEBEBEB)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                          _checkInController
                                              .friendsCheckIn[i].buddy!.name!,
                                          style: TextStyle(
                                              color: Color(0xff050506),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "${formatDateDifference(_checkInController.friendsCheckIn[i].event!.createdAt!)} ago",
                                        style: TextStyle(
                                            color: Color(0xff85738C),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/people.png"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        formatNumber(_checkInController
                                            .friendsCheckIn[i]
                                            .event!
                                            .attendies!
                                            .length!),
                                        style: TextStyle(
                                            color: Color(0xff2E083F),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffE3B6F6),
                                            borderRadius:
                                                BorderRadius.circular(5.w.h)),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 6.w),
                                        child: Text(
                                          "${_checkInController.getMutuals(_checkInController.friendsCheckIn[i].event!.attendies!, _userController.userModel.value!.buddies!)} Mutuals",
                                          style: TextStyle(
                                              color: Color(0xff2E083F),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/liveEvent.svg"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          _checkInController.friendsCheckIn[i]
                                              .event!.location!.address!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff9219C7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            ctx!.push(
                                                "${RoutesConstants.userChatScreen}/${_checkInController.friendsCheckIn[i].buddy!.userName}/${_checkInController.friendsCheckIn[i].buddy!.id}",
                                                extra: _checkInController
                                                        .friendsCheckIn[i]
                                                        .buddy!
                                                        .profileImageUrl!
                                                        .isEmpty
                                                    ? "https://via.placeholder.com/150"
                                                    : _checkInController
                                                        .friendsCheckIn[i]
                                                        .buddy!
                                                        .profileImageUrl);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.w.h)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/chatdark.svg"),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "Chat",
                                                  style: TextStyle(
                                                      color: Color(0xff4A404F),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      16.w.h)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/images/interested.svg"),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "Interested",
                                                style: TextStyle(
                                                    color: Color(0xff4A404F),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(12.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w.h),
                                  color: Color(0xFFEBEBEB)),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h));
                        },
                        itemCount: _checkInController.friendsCheckIn.length))
              ],
            ).marginSymmetric(horizontal: 10.w),
          ],
        ),
      )),
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

String formatNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M+';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll('.0', '')}k+';
  } else {
    return '$number+';
  }
}
