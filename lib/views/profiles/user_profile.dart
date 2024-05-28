import 'dart:developer';

import 'package:checkedln/controller/user_profille_controller.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/profiles/profile_widget_helper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../checkin/past_checkin_sceen.dart';
import '../widget_helper.dart';
import 'my_post_screen.dart';

class UserProfile extends StatefulWidget {
  String? userId;
  UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());
  @override
  void initState() {
    super.initState();
    _userProfileController.getUserById(widget.userId!);
  }

  int currentImageCount = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: Obx(() => SingleChildScrollView(
                  child: _userProfileController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(mainAxisSize: MainAxisSize.max, children: [
                          _userProfileController.userProfileModel.value!.user!
                                  .userImages!.isEmpty
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 15.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          backButton(
                                              Icon(
                                                  Icons.arrow_back_ios_rounded),
                                              () {
                                            ctx!.pop();
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  height: 272,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/bgProfile.png"))),
                                )
                              : SizedBox.shrink(),
                          // widget.userModel!.userImages!.isNotEmpty
                          _userProfileController.userProfileModel.value!.user!
                                  .userImages!.isNotEmpty
                              ? GestureDetector(
                                  onHorizontalDragStart: (details) {
                                    if (details.localPosition.dx >
                                        MediaQuery.of(context).size.width / 2) {
                                      if (currentImageCount == 0) {
                                        currentImageCount =
                                            _userProfileController
                                                    .userProfileModel
                                                    .value!
                                                    .user!
                                                    .userImages!
                                                    .length -
                                                1;
                                      } else {
                                        currentImageCount--;
                                      }
                                    } else {
                                      if (currentImageCount ==
                                          _userProfileController
                                                  .userProfileModel
                                                  .value!
                                                  .user!
                                                  .userImages!
                                                  .length -
                                              1) {
                                        currentImageCount = 0;
                                      } else {
                                        currentImageCount++;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 15.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            backButton(
                                                Icon(Icons
                                                    .arrow_back_ios_rounded),
                                                () {
                                              ctx!.pop();
                                            }),
                                            shareButton(
                                                Icon(Icons.share_outlined), () {
                                              Share.share(
                                                  "https://checkedln-server.onrender.com" +
                                                      RoutesConstants
                                                          .userProfile +
                                                      "/${_userProfileController.userProfileModel.value!.user!.id!}");
                                            })
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            DotsIndicator(
                                              dotsCount: _userProfileController
                                                  .userProfileModel
                                                  .value!
                                                  .user!
                                                  .userImages!
                                                  .length,
                                              position: currentImageCount,
                                              decorator: DotsDecorator(
                                                size: Size(6.w, 6.h),
                                                color: Colors
                                                    .white, // Inactive color
                                                activeColor: Color(0xffAD2EE5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    height: 245.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                _userProfileController
                                                        .userProfileModel
                                                        .value!
                                                        .user!
                                                        .userImages![
                                                    currentImageCount]))),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: Offset(0.0, -40.0), //
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: ProfileAvatar(
                                          imageUrl: _userProfileController
                                                  .userProfileModel
                                                  .value!
                                                  .user!
                                                  .profileImageUrl!
                                                  .isEmpty
                                              ? "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg"
                                              : _userProfileController
                                                  .userProfileModel
                                                  .value!
                                                  .user!
                                                  .profileImageUrl!,
                                          size: 107,
                                          child: SizedBox.shrink(),
                                          borderColor: Colors.white,
                                        ),
                                      ),
                                      textColumn(
                                          _userProfileController
                                              .userProfileModel
                                              .value!
                                              .user!
                                              .buddies!
                                              .length
                                              .toString(),
                                          "Buddies"),
                                      textColumn("0", "Mutual Bonds"),
                                      textColumn("0", "Checkins"),
                                    ],
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0.0, -30.0), //

                                  child: Text(
                                    _userProfileController
                                        .userProfileModel.value!.user!.name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0.0, -25.0), //

                                  child: Text(
                                    _userProfileController.userProfileModel
                                        .value!.user!.userName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xff6A5C70)),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0.0, -15.0), //
                                  child: Text(
                                    _userProfileController
                                        .userProfileModel.value!.user!.bio!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: Color(0xff28222A)),
                                  ),
                                ),
                                _userProfileController.isCatchupLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : !_userProfileController.isBuddy()
                                        ? _userProfileController
                                                .userProfileModel
                                                .value!
                                                .isRequested!
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _userProfileController
                                                            .acceptCatchUp(
                                                                _userProfileController
                                                                    .userProfileModel
                                                                    .value!
                                                                    .user!
                                                                    .id!);
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.w,
                                                                vertical: 8.h),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xffAD2EE5),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .w
                                                                            .h)),
                                                        child: Text("Accept",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.sp,
                                                                color: Color(
                                                                    0xffAD2EE5))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _userProfileController
                                                            .rejectCatchUp(
                                                                _userProfileController
                                                                    .userProfileModel
                                                                    .value!
                                                                    .user!
                                                                    .id!);
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.w,
                                                                vertical: 8.h),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffEEECEE),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.w.h)),
                                                        child: Text("Reject",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.sp,
                                                                color: Color(
                                                                    0xff4A404F))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : _userProfileController
                                                    .userProfileModel
                                                    .value!
                                                    .isSent!
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Color(0xffAD2EE5),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8.w.h)),
                                                    child: Text("Requested",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14.sp,
                                                            color: Color(
                                                                0xffAD2EE5))),
                                                  )
                                                : GestureDetector(
                                                    onTap: () => _userProfileController
                                                        .catchupUser(
                                                            _userProfileController
                                                                .userProfileModel
                                                                .value!
                                                                .user!
                                                                .id!),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w,
                                                              vertical: 8.h),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffAD2EE5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.w.h)),
                                                      child: Text("Catch-up",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14.sp,
                                                              color: Color(
                                                                  0xffFFFFFF))),
                                                    ),
                                                  )
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 8.h),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            Color(0xffAD2EE5),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.w.h)),
                                                  child: Text("Remove",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.sp,
                                                          color: Color(
                                                              0xffAD2EE5))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    UserModel userModel = UserModel(
                                                        id: _userProfileController
                                                            .userProfileModel
                                                            .value!
                                                            .user!
                                                            .id!,
                                                        name: _userProfileController
                                                            .userProfileModel
                                                            .value!
                                                            .user!
                                                            .name!,
                                                        profileImageUrl:
                                                            _userProfileController
                                                                .userProfileModel
                                                                .value!
                                                                .user!
                                                                .profileImageUrl!,
                                                        userName:
                                                            _userProfileController
                                                                .userProfileModel
                                                                .value!
                                                                .user!
                                                                .userName!,
                                                        phone: _userProfileController
                                                            .userProfileModel
                                                            .value!
                                                            .user!
                                                            .phone!,
                                                        bio: _userProfileController
                                                            .userProfileModel
                                                            .value!
                                                            .user!
                                                            .bio!,
                                                        buddies: _userProfileController
                                                            .userProfileModel
                                                            .value!
                                                            .user!
                                                            .buddies!,
                                                        userImages: _userProfileController.userProfileModel.value!.user!.userImages!,
                                                        notificationToken: _userProfileController.userProfileModel.value!.user!.notificationToken,
                                                        gender: _userProfileController.userProfileModel.value!.user!.gender,
                                                        dateOfBirth: _userProfileController.userProfileModel.value!.user!.dateOfBirth,
                                                        createdAt: _userProfileController.userProfileModel.value!.user!.createdAt,
                                                        updatedAt: _userProfileController.userProfileModel.value!.user!.updatedAt,
                                                        v: _userProfileController.userProfileModel.value!.user!.v);
                                                    log("${RoutesConstants.userChatScreen}/${_userProfileController.userProfileModel.value!.user!.userName}/${_userProfileController.userProfileModel.value!.user!.id}/${_userProfileController.userProfileModel.value!.user!.profileImageUrl!.isEmpty ? "https://via.placeholder.com/150" : _userProfileController.userProfileModel.value!.user!.profileImageUrl}");
                                                    ctx!.push(
                                                        "${RoutesConstants.userChatScreen}/${_userProfileController.userProfileModel.value!.user!.userName}/${_userProfileController.userProfileModel.value!.user!.id}",
                                                        extra: _userProfileController
                                                                .userProfileModel
                                                                .value!
                                                                .user!
                                                                .profileImageUrl!
                                                                .isEmpty
                                                            ? "https://via.placeholder.com/150"
                                                            : _userProfileController
                                                                .userProfileModel
                                                                .value!
                                                                .user!
                                                                .profileImageUrl);
                                                    // ctx!.push(
                                                    //     "${RoutesConstants.userChatScreen}/${UserModel(id: _userProfileController.userProfileModel.value!.user!.id!, name: _userProfileController.userProfileModel.value!.user!.name!, profileImageUrl: _userProfileController.userProfileModel.value!.user!.profileImageUrl!, userName: _userProfileController.userProfileModel.value!.user!.userName!, phone: _userProfileController.userProfileModel.value!.user!.phone!, bio: _userProfileController.userProfileModel.value!.user!.bio!, buddies: _userProfileController.userProfileModel.value!.user!.buddies!, userImages: _userProfileController.userProfileModel.value!.user!.userImages!, notificationToken: _userProfileController.userProfileModel.value!.user!.notificationToken, gender: _userProfileController.userProfileModel.value!.user!.gender, dateOfBirth: _userProfileController.userProfileModel.value!.user!.dateOfBirth, createdAt: _userProfileController.userProfileModel.value!.user!.createdAt, updatedAt: _userProfileController.userProfileModel.value!.user!.updatedAt, v: _userProfileController.userProfileModel.value!.user!.v)}");
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffEEECEE),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8.w.h)),
                                                    child: Text("Message",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14.sp,
                                                            color: Color(
                                                                0xff4A404F))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                TabBar(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorColor: Color(0xff000000),
                                    indicatorWeight: 2,
                                    tabs: [
                                      tabContainer("Post"),
                                      tabContainer("Shared Moments")
                                    ]),
                                SizedBox(
                                    height: 500.h,
                                    child: TabBarView(
                                      children: [
                                        Container(),
                                        Container(),
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ]),
                ))),
      ),
    );
  }
}
