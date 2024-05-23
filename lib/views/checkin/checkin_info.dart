import 'package:checkedln/controller/checkin/get_checkin_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/models/checkIn/main_event_model.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

import 'checkin_widget_helper.dart';

class CheckInfoScreen extends StatefulWidget {
  String id;
  bool isDeep;
  CheckInfoScreen({super.key, required this.id, required this.isDeep});

  @override
  State<CheckInfoScreen> createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  @override
  Widget build(BuildContext context) {
    GetCheckInController _getCheckInController =
        Get.put(GetCheckInController(widget.id));

    return Scaffold(
        bottomNavigationBar: Obx(() => !_getCheckInController.isLoading.value &&
                _getCheckInController.eventModel!.value.status != "going" &&
                widget.isDeep
            ? InkWell(
                onTap: () async {
                  if (widget.isDeep) {
                    _getCheckInController.eventModel!.value = MainEventModel(
                        event: _getCheckInController.eventModel!.value.event,
                        status: "going");
                    _getCheckInController.update();
                  }
                },
                child: Container(
                  height: 62.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  alignment: Alignment.center,
                  child: Text(
                    widget.isDeep
                        ? "Join Event"
                        : _getCheckInController.eventModel!.value.status !=
                                "requested"
                            ? "Request Entry"
                            : "Pending",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w.h),
                      color: Color(
                          _getCheckInController.eventModel!.value.status !=
                                  "requested"
                              ? 0xffBD57EA
                              : 0xffDDD8DF)),
                ),
              )
            : SizedBox.shrink()),
        appBar: AppBar(
          actions: [
            Image.asset("assets/images/share_bg.png").marginOnly(right: 10.w)
          ],
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset("assets/images/back_btn.webp")),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => _getCheckInController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _getCheckInController.eventModel!.value.isNull
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.w.h),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        _getCheckInController
                                                            .eventModel!
                                                            .value
                                                            .event!
                                                            .bannerImages!))),
                                            height: 66.h,
                                            width: 66.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _getCheckInController
                                                        .eventModel!
                                                        .value
                                                        .event!
                                                        .checkInName!,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16.sp),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/attending.png",
                                                    width: 20.w,
                                                    height: 20.h,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Text(
                                                    "${_getCheckInController.eventModel!.value.event!.attendies!.length!} Attending",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color:
                                                            Color(0xff4A404F),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _getCheckInController
                                                            .eventModel!
                                                            .value
                                                            .event!
                                                            .price ==
                                                        0
                                                    ? ""
                                                    : "Price",
                                                style: TextStyle(
                                                    color: Color(0xFF85738C),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp),
                                              ),
                                              Text(
                                                _getCheckInController
                                                            .eventModel!
                                                            .value
                                                            .event!
                                                            .price ==
                                                        0
                                                    ? ""
                                                    : " \$ 200",
                                                style: TextStyle(
                                                    color: Color(0xFF28222A),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xFFDDD8DF),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Venue",
                                              style: TextStyle(
                                                  color: Color(0xFF85738C),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              _getCheckInController
                                                  .eventModel!
                                                  .value
                                                  .event!
                                                  .location!
                                                  .address!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp),
                                            )
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Schedule",
                                            style: TextStyle(
                                                color: Color(0xFF85738C),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp),
                                          ),
                                          Text(
                                            DateFormat('EEEE').format(
                                                _getCheckInController
                                                    .eventModel!
                                                    .value
                                                    .event!
                                                    .startDateTime!
                                                    .toLocal()),
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp),
                                          ),
                                          Text(
                                            DateFormat('MMM dd, yyyy').format(
                                                _getCheckInController
                                                    .eventModel!
                                                    .value
                                                    .event!
                                                    .startDateTime!
                                                    .toLocal()),
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xFFDDD8DF),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  twoTile(
                                      "20 Mutuals",
                                      Image.asset(
                                          "assets/images/attending.png"),
                                      () {},
                                      EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w)),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  twoTile(
                                      "Event Gallery",
                                      Image.asset(
                                        "assets/images/gallery.png",
                                        height: 15,
                                        width: 15,
                                      ),
                                      () {},
                                      EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w))
                                ],
                              ),
                              padding: EdgeInsets.all(16.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.w.h),
                                  color: Color(0xFFF0EFF0)),
                            ).paddingSymmetric(vertical: 5.h),
                            _getCheckInController.eventModel!.value.status ==
                                    "going"
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFDDD8DF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.search,
                                              color: Colors.grey),
                                          SizedBox(
                                              width:
                                                  8.0), // Add spacing between icon and text field
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                border: InputBorder
                                                    .none, // Hide the default border
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).paddingSymmetric(vertical: 10.h)
                                : SizedBox.shrink(),
                            _getCheckInController.eventModel!.value.status ==
                                    "going"
                                ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ProfileAvatar(
                                                      imageUrl:
                                                          _getCheckInController
                                                              .eventModel!
                                                              .value
                                                              .event!
                                                              .attendies![i]
                                                              .profileImageUrl!,
                                                      size: 40,
                                                      child: SizedBox.shrink(),
                                                      borderColor:
                                                          Colors.white),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _getCheckInController
                                                            .eventModel!
                                                            .value
                                                            .event!
                                                            .attendies![i]
                                                            .name!,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF050506),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      i == 1 || i == 2
                                                          ? Text(
                                                              "2 Mututals",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6A5C70),
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )
                                                          : SizedBox.shrink(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  _getCheckInController
                                                              .eventModel!
                                                              .value
                                                              .event!
                                                              .attendies![i]
                                                              .id ==
                                                          getIt<CacheManager>()
                                                              .getUserId()
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(4
                                                                          .w
                                                                          .h),
                                                              color: Color(
                                                                  0xFFE2CFFB)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 2.h,
                                                                  horizontal:
                                                                      6.w),
                                                          child: Text(
                                                            "Host",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF4111C1),
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )
                                                      : SizedBox.shrink()
                                                ],
                                              ),
                                              i == 0 || i == 1 || i == 2
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.w.h),
                                                          color: Color(
                                                              0xFFAD2EE5)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h,
                                                              horizontal: 16.w),
                                                      child: Text(
                                                        "Catch-up",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14.sp),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.w.h),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFFAD2EE5))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h,
                                                              horizontal: 16.w),
                                                      child: Text(
                                                        "Unfollow",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFAD2EE5),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14.sp),
                                                      ),
                                                    )
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, i) {
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h));
                                        },
                                        itemCount: _getCheckInController
                                            .eventModel!
                                            .value
                                            .event!
                                            .attendies!
                                            .length)
                                    .marginSymmetric(vertical: 5.h)
                                : SizedBox.shrink()
                          ],
                        ).marginSymmetric(horizontal: 10.w),
            ),
          ),
        ));
  }
}
