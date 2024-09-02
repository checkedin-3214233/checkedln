import 'dart:developer';

import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../controller/checkin/check_in_controller.dart';
import '../controller/user_controller.dart';
import '../res/colors/routes/route_constant.dart';
import 'checkin/checkin_info.dart';

Widget backButton(Icon icon, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.h,
      child: icon,
    ),
  );
}

Widget backButtonGreay(Icon icon, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.h,
      child: icon,
      decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(10.w.h)),
    ),
  );
}

Widget button(Color color, Text text, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      alignment: Alignment.center,
      width: MediaQuery.of(ctx!).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.5.w.h),
      ),
      child: text,
    ),
  ).marginOnly(
    top: 20.h,
  );
}

AppBar mainAppBar(
    String tittle, List<Widget>? actions, Widget bottom, bool isBottom) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize:
          !isBottom ? const Size.fromHeight(0) : const Size.fromHeight(100),
      child: bottom,
    ),
    elevation: 0,
    title: Text(
      tittle,
      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.sp),
    ),
    centerTitle: true,
    leading: InkWell(
      onTap: () {
        ctx!.pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SvgPicture.asset(
          "assets/images/backGreay.svg",
          height: 10.h,
          width: 10.w,
        ).marginSymmetric(horizontal: 5.w, vertical: 5.h),
      ),
    ),
    actions: actions,
  );
}

Widget postButton(Widget child, Function() onPressed, Color color) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      alignment: Alignment.center,
      width: MediaQuery.of(ctx!).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.5.w.h),
      ),
      child: child,
    ),
  ).marginOnly(
    top: 12.h,
  );
}

Widget liveCheckIn() {
  CheckInController _checkInController = Get.find<CheckInController>();
  UserController _userController = Get.find<UserController>();
  return SizedBox(
    height: 110.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Container(
            width: MediaQuery.of(ctx!).size.width,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ctx!.push(
                      "${RoutesConstants.checkin}/${_checkInController.liveEvents[i].id!}/${"m"}/${false}",
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Container(
                        height: 100.h,
                        width: MediaQuery.of(ctx!).size.width * 0.8,
                        margin: EdgeInsets.only(left: 50.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w.h),
                          gradient: LinearGradient(
                            begin:
                                Alignment.topLeft, // Adjust alignment as needed
                            end: Alignment
                                .bottomRight, // Adjust alignment as needed
                            colors: [
                              Color(0xFF8360E5),
                              Color(0xFF723BCC),
                            ],
                            stops: [
                              0.0059,
                              0.9852
                            ], // Adjust stops to match the provided values
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(ctx!).size.width * 0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      _checkInController
                                          .liveEvents[i].checkInName!,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFFFFFF)
                                                      .withOpacity(0.32),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.w.h)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 10.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _checkInController.getMutuals(_checkInController.liveEvents[i].attendies!, _userController.userModel.value!.buddies!)<1?SizedBox.shrink(): SvgPicture.asset(
                                                      "assets/images/mutual.svg"),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text(
                                                    "Live",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffFFFFFF),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "${_checkInController.getMutuals(_checkInController.liveEvents[i].attendies!, _userController.userModel.value!.buddies!)} Mutuals",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            ctx!.push(
                                              "${RoutesConstants.checkin}/${_checkInController.liveEvents[i].id!}/${"m"}/${false}",
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(6.w.h),
                                            child: SvgPicture.asset(
                                                "assets/images/next.svg"),
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.w.h)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset(MediaQuery.of(ctx!).size.width * 0.05, 0),
                        child: ProfileAvatar(
                            imageUrl:
                                _checkInController.liveEvents[i].bannerImages!,
                            size: 56,
                            child: SizedBox.shrink(),
                            borderColor: Color(0xff8360E5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: _checkInController.liveEvents.length),
  );
}

Widget nearByCheckIn() {
  CheckInController _checkInController = Get.find<CheckInController>();
  final UserController _userController = Get.put(UserController());

  return Obx(() => _checkInController.isNearByEventsLoading.value
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SizedBox(
          height: 96.h,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    log(_checkInController.nearByEvents[i].id!);

                    ctx!.push(
                      "${RoutesConstants.checkin}/${_checkInController.nearByEvents[i].id!}/${"m"}/${false}",
                    );
                  },
                  child: Container(
                    width: 250.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w.h),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_checkInController
                                      .nearByEvents[i].bannerImages!))),
                          height: 80.h,
                          width: 80.w,
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _checkInController
                                      .nearByEvents[i].checkInName!,
                                  style: TextStyle(
                                      color: Color(0xff050506),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/attending.png",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                Text(
                                  "${_checkInController.nearByEvents[i].attendies!.length!} Attendees",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff4A404F),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _checkInController.getMutuals(_checkInController.nearByEvents[i].attendies!, _userController.userModel.value!.buddies!)<1? SizedBox.shrink(): Image.asset(_checkInController.getMutuals(_checkInController.nearByEvents[i].attendies!, _userController.userModel.value!.buddies!)==1?"assets/images/mutual_one.png":"assets/images/people.png"),
                                Text(
                                  "${_checkInController.getMutuals(_checkInController.nearByEvents[i].attendies!, _userController.userModel.value!.buddies!)} Mutuals",
                                  style: TextStyle(
                                      color: Color(0xff4A404F),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w.h),
                        color: Color(0xFFEBEBEB)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
              },
              itemCount: _checkInController.nearByEvents.length),
        ).marginSymmetric(vertical: 10.h));
}
