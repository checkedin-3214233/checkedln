import 'dart:developer';

import 'package:checkedln/controller/checkin/get_checkin_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/models/checkIn/main_event_model.dart';
import 'package:checkedln/res/snakbar.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/home_controller.dart';
import '../../controller/user_controller.dart';
import '../../res/colors/routes/route_constant.dart';
import 'checkin_widget_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckInfoScreen extends StatefulWidget {
  final String id;
  final bool isDeep;
  final String shareId;
  const CheckInfoScreen(
      {super.key,
      required this.id,
      required this.isDeep,
      required this.shareId});

  @override
  State<CheckInfoScreen> createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  final GetCheckInController _getCheckInController =
      Get.put(GetCheckInController());
  final UserController _userController = Get.put(UserController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _userController.getUser();
    _getCheckInController.getEventId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => !_getCheckInController.isLoading.value &&
                _getCheckInController.eventModel!.value.status != "going" &&
                !(_getCheckInController.eventModel!.value.event!.createdBy ==
                    getIt<CacheManager>().getUserId())
            ? GestureDetector(
                onTap: () async {
                  if (widget.isDeep &&
                      await _getCheckInController.joinEvent(
                          widget.shareId, true)) {
                    _getCheckInController.eventModel!.value = MainEventModel(
                        event: _getCheckInController.eventModel!.value.event,
                        status: "going");
                    _getCheckInController.update();
                  } else if (_getCheckInController
                          .eventModel!.value.event!.status ==
                      "active") {
                    bool isGoing = await _getCheckInController.joinEvent(
                        _getCheckInController.eventModel!.value.event!.id!,
                        false);
                    if (isGoing) {
                      _getCheckInController.eventModel!.value = MainEventModel(
                          event: _getCheckInController.eventModel!.value.event,
                          status: "going");
                      _getCheckInController.update();
                    }
                  } else if (_getCheckInController.eventModel!.value.status !=
                          "requested" &&
                      _getCheckInController.eventModel!.value.event!.status ==
                          "active") {
                    _getCheckInController.requestEntry(
                        _getCheckInController.eventModel!.value.event!.id!);
                  }
                },
                child: Container(
                  height: 62.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w.h),
                      color: Color(_getCheckInController
                                  .eventModel!.value.event!.status ==
                              "inactive"
                          ? 0xffDDD8DF
                          : _getCheckInController.eventModel!.value.status !=
                                  "requested"
                              ? 0xffBD57EA
                              : 0xffBD57EA)),
                  child: Text(
                    widget.isDeep ||
                            _getCheckInController
                                    .eventModel!.value.event!.status ==
                                "active"
                        ? "Join Event"
                        : _getCheckInController
                                    .eventModel!.value.event!.status ==
                                "inactive"
                            ? "Registration Closed"
                            : "Pending",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              )
            : const SizedBox.shrink()),
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  Share.share(
                      'Check Out This Event\n${_getCheckInController.eventModel!.value.event!.checkInName} || ${(_getCheckInController.eventModel!.value.event!.startDateTime!.day)}-${(_getCheckInController.eventModel!.value.event!.startDateTime!.month)}-${(_getCheckInController.eventModel!.value.event!.startDateTime!.year)} || ${(_getCheckInController.eventModel!.value.event!.startDateTime!.hour)}-${(_getCheckInController.eventModel!.value.event!.startDateTime!.minute)}\nin Checkdln \n||  https://checkedln-server.onrender.com${RoutesConstants.checkin}/${widget.id}/${widget.shareId}/${false} ||');
                },
                child: SvgPicture.asset("assets/images/shareWvent.svg")
                    .marginOnly(right: 10.w))
          ],
          leading: InkWell(
              onTap: () {
                ctx!.pop();
              },
              child: SvgPicture.asset(
                "assets/images/backGreay.svg",
                height: 2,
                width: 2,
              ).marginOnly(left: 10.w, top: 10.h, bottom: 10.h)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => _getCheckInController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _getCheckInController.eventModel!.value.isNull
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.w.h),
                                  color: Color(0xFFF0EFF0)),
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
                                                  SvgPicture.asset(
                                                    "assets/images/peoplelive.svg",
                                                    width: 10.w,
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Text(
                                                    " ${(_getCheckInController.eventModel!.value.event!.startDateTime!.toLocal().compareTo(DateTime.now()) < 0 && _getCheckInController.eventModel!.value.event!.endDateTime!.toLocal().compareTo(DateTime.now()) > 0) ? "${_getCheckInController.eventModel!.value.event!.checkedIn!.length} are there in the event" : _getCheckInController.eventModel!.value.event!.startDateTime!.toLocal().compareTo(DateTime.now()) < 0 ? "${_getCheckInController.eventModel!.value.event!.attendies!.length} Attended" : "${_getCheckInController.eventModel!.value.event!.attendies!.length} Attendees"}",
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
                                  const Divider(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Venue",
                                              style: TextStyle(
                                                  color: Color(0xFF85738C),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                String googleUrl =
                                                    'https://www.google.com/maps/search/?api=1&query=${_getCheckInController.eventModel!.value.event!.location!.coordinates!.coordinates![1]},${_getCheckInController.eventModel!.value.event!.location!.coordinates!.coordinates![0]}';
                                                if (await canLaunchUrl(
                                                    Uri.parse(googleUrl))) {
                                                  await launchUrl(
                                                      Uri.parse(googleUrl));
                                                } else {
                                                  showSnakBar(
                                                      'Could not open the map.');
                                                  throw 'Could not open the map.';
                                                }
                                              },
                                              child: Text(
                                                _getCheckInController
                                                    .eventModel!
                                                    .value
                                                    .event!
                                                    .location!
                                                    .address!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Color.fromARGB(
                                                        255, 20, 60, 162),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp),
                                              ),
                                            )
                                          ],
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
                                  const Divider(
                                    thickness: 1,
                                    color: Color(0xFFDDD8DF),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  twoTile(
                                      "${_getCheckInController.getMutuals(_getCheckInController.eventModel!.value.event!.attendies!, _userController.userModel.value!.buddies!)} Mutuals",
                                      SvgPicture.asset(
                                          "assets/images/peoplelive.svg"),
                                      () {},
                                      EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w)),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  twoTile(
                                      "Event Gallery",
                                      SvgPicture.asset(
                                        "assets/images/eventGallery.svg",
                                        height: 15,
                                        width: 15,
                                      ), () {
                                    ctx!.push(RoutesConstants.eventGallery,
                                        extra: _getCheckInController
                                            .eventModel!.value.event!.images);
                                  },
                                      EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w))
                                ],
                              ),
                            ).paddingSymmetric(vertical: 5.h),
                            _getCheckInController.eventModel!.value.status ==
                                        "going" ||
                                    (_getCheckInController.eventModel!.value
                                            .event!.createdBy ==
                                        getIt<CacheManager>().getUserId())
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFDDD8DF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const Padding(
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
                                : const SizedBox.shrink(),
                            _getCheckInController.eventModel!.value.status == "going" ||
                                    (_getCheckInController.eventModel!.value
                                            .event!.createdBy ==
                                        getIt<CacheManager>().getUserId())
                                ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return Obx(() => checkInUser(
                                              (_getCheckInController
                                                          .eventModel!
                                                          .value
                                                          .event!
                                                          .startDateTime!
                                                          .toLocal()
                                                          .compareTo(
                                                              DateTime.now()) <
                                                      0 &&
                                                  _getCheckInController
                                                          .eventModel!
                                                          .value
                                                          .event!
                                                          .endDateTime!
                                                          .toLocal()
                                                          .compareTo(
                                                              DateTime.now()) >
                                                      0),
                                              i));
                                        },
                                        separatorBuilder: (context, i) {
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h));
                                        },
                                        itemCount: (_getCheckInController
                                                        .eventModel!
                                                        .value
                                                        .event!
                                                        .startDateTime!
                                                        .toLocal()
                                                        .compareTo(
                                                            DateTime.now()) <
                                                    0 &&
                                                _getCheckInController.eventModel!.value.event!.endDateTime!.toLocal().compareTo(DateTime.now()) >
                                                    0)
                                            ? _getCheckInController.eventModel!
                                                .value.event!.checkedIn!.length
                                            : _getCheckInController
                                                        .eventModel!
                                                        .value
                                                        .event!
                                                        .startDateTime!
                                                        .toLocal()
                                                        .compareTo(DateTime.now()) <
                                                    0
                                                ? _getCheckInController.eventModel!.value.event!.attendies!.length
                                                : 1)
                                    .marginSymmetric(vertical: 5.h)
                                : SizedBox.shrink(),
                            ((_getCheckInController.eventModel!.value.status ==
                                            "going" ||
                                        (_getCheckInController.eventModel!.value
                                                .event!.createdBy ==
                                            getIt<CacheManager>()
                                                .getUserId())) &&
                                    (!(_getCheckInController.eventModel!.value
                                                    .event!.startDateTime!
                                                    .toLocal()
                                                    .compareTo(DateTime.now()) <
                                                0 &&
                                            _getCheckInController.eventModel!
                                                    .value.event!.endDateTime!
                                                    .toLocal()
                                                    .compareTo(DateTime.now()) >
                                                0) &&
                                        !(_getCheckInController.eventModel!
                                                .value.event!.endDateTime!
                                                .toLocal()
                                                .compareTo(DateTime.now()) <
                                            0)))
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      SvgPicture.asset(
                                          "assets/images/viewUsers.svg"),
                                      Text(
                                        "Go to location to see all list of all attendees",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff6A5C70)),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    ],
                                  )
                                : _getCheckInController.eventModel!.value.event!.endDateTime!.toLocal().compareTo(DateTime.now()) < 0
                                    ? SizedBox.shrink()
                                    : SizedBox.shrink()
                          ],
                        ).marginSymmetric(horizontal: 10.w),
            ),
          ),
        ));
  }
}
