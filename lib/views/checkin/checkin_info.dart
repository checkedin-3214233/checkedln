import 'package:checkedln/controller/checkin/get_checkin_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/models/checkIn/main_event_model.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            ? InkWell(
                onTap: () async {
                  if (widget.isDeep &&
                      await _getCheckInController.joinEvent(widget.shareId)) {
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w.h),
                      color: Color(
                          _getCheckInController.eventModel!.value.status !=
                                  "requested"
                              ? 0xffBD57EA
                              : 0xffDDD8DF)),
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
                ),
              )
            : const SizedBox.shrink()),
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  Share.share(
                      'check out this new event in Checkdln https://checkedln-server.onrender.com${RoutesConstants.checkin}/${widget.id}/${widget.shareId}/${false}');
                },
                child: Image.asset("assets/images/share_bg.png")
                    .marginOnly(right: 10.w))
          ],
          leading: InkWell(
              onTap: () {
                ctx!.pop();
              },
              child: Image.asset("assets/images/back_btn.webp")),
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
                                                    color: Color(0xFF000000),
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
                            _getCheckInController.eventModel!.value.status ==
                                        "going" ||
                                    (_getCheckInController.eventModel!.value
                                            .event!.createdBy ==
                                        getIt<CacheManager>().getUserId())
                                ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return InkWell(
                                            onTap: () {
                                              if (_getCheckInController
                                                      .eventModel!
                                                      .value
                                                      .event!
                                                      .attendies![i]
                                                      .id ==
                                                  getIt<CacheManager>()
                                                      .getUserId()) {
                                                ctx!.push(
                                                    RoutesConstants.myProfile);
                                              } else {
                                                ctx!.push(
                                                    "${RoutesConstants.userProfile}/${_getCheckInController.eventModel!.value.event!.attendies![i].id}");
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        child: const SizedBox
                                                            .shrink(),
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
                                                              color: const Color(
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
                                                                    color: const Color(
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
                                                                .createdBy ==
                                                            _getCheckInController
                                                                .eventModel!
                                                                .value
                                                                .event!
                                                                .attendies![i]
                                                                .id
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
                                                                    vertical:
                                                                        2.h,
                                                                    horizontal:
                                                                        6.w),
                                                            child: Text(
                                                              "Host",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF4111C1),
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : SizedBox.shrink()
                                                  ],
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
                                                                    .circular(
                                                                        8.w.h),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFAD2EE5))),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    16.w),
                                                        child: Text(
                                                          "You",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFAD2EE5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14.sp),
                                                        ),
                                                      )
                                                    : !_userController.userModel
                                                            .value!.buddies!
                                                            .contains(
                                                                _getCheckInController
                                                                    .eventModel!
                                                                    .value
                                                                    .event!
                                                                    .attendies![
                                                                        i]
                                                                    .id)
                                                        ? GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(8
                                                                              .w
                                                                              .h),
                                                                  color: Color(
                                                                      0xFFAD2EE5)),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.h,
                                                                      horizontal:
                                                                          16.w),
                                                              child: Text(
                                                                "Catch-up",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .w
                                                                            .h),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xFFAD2EE5))),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        8.h,
                                                                    horizontal:
                                                                        16.w),
                                                            child: Text(
                                                              "Unfollow",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFAD2EE5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                          )
                                              ],
                                            ),
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
