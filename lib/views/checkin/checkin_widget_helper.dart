import 'dart:developer';

import 'package:checkedln/global.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/res/snakbar.dart';
import 'package:checkedln/views/checkin/select_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/checkin/check_in_controller.dart';
import '../../controller/checkin/create_checkin_controller.dart';
import '../../controller/checkin/get_checkin_controller.dart';
import '../../controller/user_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../data/local/cache_manager.dart';
import '../../res/colors/colors.dart';
import 'package:intl/intl.dart';

import '../dialog/dialog_helper.dart';
import '../profiles/profile_avatar.dart'; // Import the intl package for date formatting

Widget tabContainer(String text) {
  return SizedBox(
    height: 30.h,
    child: Text(
      text,
      style: TextStyle(
          color: Color(0xff2E083F),
          fontWeight: FontWeight.w600,
          fontSize: 14.sp),
    ),
  );
}

Widget checkInButton(Widget child, Function() onPressed, Color color) {
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

Widget checkIn(int count, bool isUpcoming) {
  CheckInController _checkInController = Get.find<CheckInController>();

  return InkWell(
    onTap: () {
      if (isUpcoming) {
        print(
            "${RoutesConstants.checkin}/${_checkInController.upcomingEvents[count].id!}/${"m"}/${false}");

        ctx!.push(
          "${RoutesConstants.checkin}/${_checkInController.upcomingEvents[count].id!}/${"m"}/${false}",
        );
      } else {
        ctx!.push(
          "${RoutesConstants.checkin}/${_checkInController.pastEvent[count].id!}/${"m"}/${false}",
        );
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDDD8DF)),
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              chips(
                  Text(
                    capitalizeFirstLetterOfEachWord(isUpcoming
                        ? _checkInController.upcomingEvents[count].type!
                        : _checkInController.pastEvent[count].type!),
                    style: TextStyle(
                        color: capitalizeFirstLetterOfEachWord(isUpcoming
                                    ? _checkInController
                                        .upcomingEvents[count].type!
                                    : _checkInController
                                        .pastEvent[count].type!) ==
                                "Private"
                            ? Color(0xffF04A4C)
                            : Color(0xff287EE4),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  capitalizeFirstLetterOfEachWord(isUpcoming
                              ? _checkInController.upcomingEvents[count].type!
                              : _checkInController.pastEvent[count].type!) ==
                          "Private"
                      ? Color(0xffFDECEC)
                      : Color(0xffE7F1FC)),
              isUpcoming &&
                      _checkInController.upcomingEvents[count].createdBy ==
                          getIt<CacheManager>().getUserId()
                  ? chips(
                      Text(
                        "Self",
                        style: TextStyle(
                            color: Color(0xffAD2EE5),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Color(0xffFAF1FD))
                  : SizedBox.shrink()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 66.w,
                    height: 66.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.sp),
                        image: DecorationImage(
                            image: NetworkImage(isUpcoming
                                ? _checkInController
                                    .upcomingEvents[count].bannerImages!
                                : _checkInController
                                    .pastEvent[count].bannerImages!))),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUpcoming
                            ? _checkInController
                                .upcomingEvents[count].checkInName!
                            : _checkInController.pastEvent[count].checkInName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                              width: 12.w,
                              height: 12.h,
                              "assets/images/peoplelive.svg"),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${isUpcoming ? _checkInController.upcomingEvents[count].attendies!.length : _checkInController.pastEvent[count].attendies!.length} ${isUpcoming ? "Attending" : "Attended"}",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4A404F)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              isUpcoming &&
                      _checkInController.upcomingEvents[count].createdBy ==
                          getIt<CacheManager>().getUserId()
                  ? GestureDetector(
                      onTap: () {
                        _showModalBottomSheet(ctx!, count,
                            _checkInController.upcomingEvents[count].id!, () {
                          CreateCheckInController _createCheckInController =
                              Get.find<CreateCheckInController>();
                          _createCheckInController.editEventFild(
                              _checkInController.upcomingEvents[count]);
                          ctx!.push(RoutesConstants.createCheckin);
                        });
                      },
                      child: SvgPicture.asset("assets/images/menuWhite.svg"))
                  : SizedBox.shrink()
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Venue",
            style: TextStyle(
                color: Color(0xff85738C),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp),
          ),
          Text(
            isUpcoming
                ? _checkInController.upcomingEvents[count].location!.address!
                : _checkInController.pastEvent[count].location!.address!,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 20, 60, 162),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                        color: Color(0xff85738C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                  Text(
                    DateFormat('EEE').format(isUpcoming
                        ? _checkInController
                            .upcomingEvents[count].startDateTime!
                            .toLocal()
                        : _checkInController.pastEvent[count].startDateTime!
                            .toLocal()),
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(isUpcoming
                        ? _checkInController
                            .upcomingEvents[count].startDateTime!
                            .toLocal()
                        : _checkInController.pastEvent[count].startDateTime!
                            .toLocal()),
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                        color: Color(0xff85738C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                  Text(
                    "${DateFormat('h:mm a').format(isUpcoming ? _checkInController.upcomingEvents[count].startDateTime!.toLocal() : _checkInController.pastEvent[count].startDateTime!.toLocal())} Onwards",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              isUpcoming
                  ? Expanded(
                      child: checkInButton(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/invite.svg"),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Invite",
                                style: TextStyle(
                                    color: Color(0xff500E6D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ), () async {
                        DialogHelper.showLoading("Creating Link....");
                        bool isCurrentUser = _checkInController
                                .upcomingEvents[count].createdBy ==
                            getIt<CacheManager>().getUserId();
                        print(isCurrentUser);
                        if (!isCurrentUser) {
                          Share.share(
                              'check out this new event in Checkdln https://checkedln-server.onrender.com${RoutesConstants.checkin}/${_checkInController.upcomingEvents[count].id}/${_checkInController.upcomingEvents[count].checkInName}/${false}');
                        } else {
                          String url = await _checkInController.getSharebleLink(
                              _checkInController.upcomingEvents[count].id!);
                          print(url);
                          Share.share('Join My new event in Checkdln $url');
                        }
                        DialogHelper.hideLoading();
                      }, Color((0xffF8F7F8))),
                    )
                  : Expanded(
                      child: checkInButton(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/eventGallery.svg",
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                    color: Color(0xff500E6D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          () {},
                          Color((0xffF8F7F8))),
                    ),
              isUpcoming
                  ? Expanded(
                      child: checkInButton(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/upload.svg"),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Upload Photos",
                                style: TextStyle(
                                    color: Color(0xff500E6D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          () {},
                          Color((0xffF8F7F8))),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ],
      ),
    ),
  );
}

String capitalizeFirstLetterOfEachWord(String input) {
  // Split the string into words
  List<String> words = input.split(' ');

  // Capitalize the first letter of each word
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) return word; // Handle empty strings
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();

  // Join the words back into a single string
  return capitalizedWords.join(' ');
}

Widget switchButton(int count, String id, Function()? editEvent) {
  CheckInController _checkInController = Get.find<CheckInController>();
  log("message");
  return _checkInController.upcomingEvents[count].createdBy ==
          getIt<CacheManager>().getUserId()
      ? Transform.scale(
          scale: 0.8,
          child: Switch(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value:
                  _checkInController.upcomingEvents[count].status == "active",
              onChanged: (val) async {
                DialogHelper.showLoading("Changing status....");
                _checkInController.upcomingEvents[count] = _checkInController
                    .upcomingEvents[count]
                    .copyWith(status: val ? "active" : "inactive");

                bool isTrue = await _checkInController.changeEventStatus(
                    val ? "active" : "inactive",
                    _checkInController.upcomingEvents[count].id!);
                DialogHelper.hideLoading();
                Navigator.pop(ctx!);
                _showModalBottomSheet(ctx!, count, id, editEvent!);
                if (!isTrue) {
                  _checkInController.upcomingEvents[count] = _checkInController
                      .upcomingEvents[count]
                      .copyWith(status: val ? "inactive" : "active");
                  DialogHelper.showErroDialog(
                      description: "Unable to change status");
                } else {
                  showSnakBar("Status changed successfully");
                }
              }),
        )
      : SizedBox.shrink();
}

Widget chips(Text text, Color chipsColor) {
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: chipsColor, borderRadius: BorderRadius.circular(15.sp)),
      child: text);
}

void _showModalBottomSheet(
    BuildContext context, int count, String id, Function() editEvent) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(ctx!).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.sp),
              topRight: Radius.circular(24.sp)),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                color: Color(0xff1E1E1E),
                height: 2.h,
                width: 40.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                trailing: switchButton(count, id, editEvent),
                title: Text(
                  'Is check-in Active?',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                onTap: () {},
              ),
              Container(
                color: Color(0xffEEECEE),
                height: 1.h,
              ),
              ListTile(
                  leading: SvgPicture.asset("assets/images/editEvent.svg"),
                  title: Text(
                    'Edit',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  onTap: editEvent),
              ListTile(
                leading: SvgPicture.asset("assets/images/delete.svg"),
                title: Text(
                  'Delete Check-in',
                  style: TextStyle(
                      color: Color(0xffED1C1F),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  bool result =
                      await Get.find<CheckInController>().deleteEvent(id);
                  if (result) {
                    Get.find<CheckInController>()
                        .upcomingEvents
                        .removeAt(count);
                    Get.find<CheckInController>().update();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget checkIn2() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.sp), color: Color(0xffF0EFF0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 66.w,
              height: 66.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.sp),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.adobe.com/content/dam/cc/us/en/creativecloud/photography/discover/concert-photography/thumbnail.jpeg"))),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Arjit Singh Concert",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                ),
                Row(
                  children: [
                    Image.asset(
                        width: 15.w,
                        height: 15.h,
                        "assets/images/attending.png"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "100 Attending",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4A404F)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 1.0.h, // Height of the line
          color: Color(0xFFDDD8DF), // Color of the line
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "Venue",
          style: TextStyle(
              color: Color(0xff85738C),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp),
        ),
        Text(
          "KOrba",
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontSize: 14.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: TextStyle(
                      color: Color(0xff85738C),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
                Text(
                  DateFormat('EEEE').format(DateTime.now()),
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(DateTime.now()),
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                      color: Color(0xff85738C),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
                Text(
                  "${DateFormat('h:mm a').format(DateTime.now())} Onwards",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 1.0.h, // Height of the line
          color: Color(0xFFDDD8DF), // Color of the line
        ),
        // isUpcoming?   checkInButton(
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset("assets/images/inviteIcon.png"),
        //         Text(
        //           "Invite People",
        //           style: TextStyle(
        //               color: Color(0xff28222A),
        //               fontSize: 14.sp,
        //               fontWeight: FontWeight.w600),
        //         )
        //       ],
        //     ),
        //         () {},
        //     Color((0xffFFFFFF))):checkInButton(
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset("assets/images/gallery.png",height: 14.h,),
        //         Text(
        //           "Event Gallery",
        //           style: TextStyle(
        //               color: Color(0xff28222A),
        //               fontSize: 14.sp,
        //               fontWeight: FontWeight.w600),
        //         )
        //       ],
        //     ),
        //         () {},
        //     Color((0xffFFFFFF))),
        checkInButton(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/upload.png"),
                Text(
                  "Upload Photos",
                  style: TextStyle(
                      color: Color(0xff28222A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            () {},
            Color((0xffFFFFFF)))
      ],
    ),
  );
}

String _formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour =
      timeOfDay.hour.toString().padLeft(2, '0'); // Ensure two digits for hour
  final minute = timeOfDay.minute
      .toString()
      .padLeft(2, '0'); // Ensure two digits for minute
  return '$hour:$minute'; // Format as "HH:mm"
}

Widget userName(TextEditingController controller, TextInputType type,
    String hintText, bool isEditable) {
  const gender = ["male", "female", "other"];
  return TextField(
    maxLines: hintText == "Write about Check-in" ? 3 : null,
    textInputAction: TextInputAction.next,
    onTap: () async {
      if (hintText == "Event Venue") {
        ctx!.push(RoutesConstants.selectLocation, extra: controller);
      }
      if (hintText == "Start Date" || hintText == "End Date") {
        final DateTime? picked = await showDatePicker(
          context: ctx!,
          barrierDismissible: false,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        );
        if (picked != null) {
          controller.text = picked.toString().substring(0, 10);
        }
      }
      if (hintText == "Start Time" || hintText == "End Time") {
        final TimeOfDay? picked =
            await showTimePicker(context: ctx!, initialTime: TimeOfDay.now());
        if (picked != null) {
          controller.text = _formatTimeOfDay(picked);
        }
      }
    },
    readOnly: isEditable ||
        hintText == "Date of Birth*" ||
        hintText == "Select Gender",
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      suffixIcon: (hintText == "Start Date" || hintText == "End Date")
          ? Image.asset("assets/images/calender.webp")
          : (hintText == "Start Time" || hintText == "End Time")
              ? Image.asset("assets/images/time.png")
              : hintText == "Select Gender"
                  ? Image.asset("assets/images/drop_down.webp")
                  : hintText == "Event Venue"
                      ? Image.asset("assets/images/venue.png")
                      : null,
      filled: true,
      fillColor: Color(0xFFF5F4F6), // Background color
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD189F0)), // Border color
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF5F4F6)),
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: getIt<ColorsFile>().textColor4, // Text color
        fontWeight: FontWeight.w500, // Text weight
        fontSize: 12.0.sp, // Text size
      ),
    ),
  ).marginSymmetric(vertical: 3.h);
}

Widget twoTile(String title, Widget widget, Function() onPressed,
    EdgeInsetsGeometry padding) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(ctx!).size.width,
      padding: padding,
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(16.w.h)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          SizedBox(
            width: 2.w,
          ),
          Text(title,
              style: TextStyle(
                  color: Color(0xff28222A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

Widget checkInUser(bool isLive, int i) {
  final GetCheckInController _getCheckInController =
      Get.find<GetCheckInController>();
  final UserController _userController = Get.find<UserController>();
  log("KGF${isLive}");
  return InkWell(
    onTap: () {
      if ((isLive
              ? _getCheckInController.eventModel!.value.event!.checkedIn![i].id
              : _getCheckInController
                  .eventModel!.value.event!.attendies![i].id) ==
          getIt<CacheManager>().getUserId()) {
        ctx!.push(RoutesConstants.myProfile);
      } else {
        ctx!.push(
            "${RoutesConstants.userProfile}/${isLive ? _getCheckInController.eventModel!.value.event!.checkedIn![i].id : _getCheckInController.eventModel!.value.event!.attendies![i].id}");
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ProfileAvatar(
                imageUrl: isLive
                    ? _getCheckInController
                        .eventModel!.value.event!.checkedIn![i].profileImageUrl!
                    : _getCheckInController.eventModel!.value.event!
                        .attendies![i].profileImageUrl!,
                size: 40,
                child: const SizedBox.shrink(),
                borderColor: Colors.white),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLive
                      ? _getCheckInController
                          .eventModel!.value.event!.checkedIn![i].name!
                      : _getCheckInController
                          .eventModel!.value.event!.attendies![i].name!,
                  style: TextStyle(
                      color: const Color(0xFF050506),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                // i == 1 || i == 2
                //     ? Text(
                //         "2 Mututals",
                //         style: TextStyle(
                //             color: const Color(
                //                 0xFF6A5C70),
                //             fontSize:
                //                 12.sp,
                //             fontWeight:
                //                 FontWeight
                //                     .w600),
                //       )
                //     : SizedBox.shrink(),
              ],
            ),
            SizedBox(
              width: 4.w,
            ),
            _getCheckInController.eventModel!.value.event!.createdBy ==
                    (isLive
                        ? _getCheckInController
                            .eventModel!.value.event!.checkedIn![i].id
                        : _getCheckInController
                            .eventModel!.value.event!.attendies![i].id)
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w.h),
                        color: Color(0xFFE2CFFB)),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                    child: Text(
                      "Host",
                      style: TextStyle(
                          color: Color(0xFF4111C1),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
        (isLive
                    ? _getCheckInController
                        .eventModel!.value.event!.checkedIn![i].id
                    : _getCheckInController
                        .eventModel!.value.event!.attendies![i].id) ==
                getIt<CacheManager>().getUserId()
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w.h),
                    border: Border.all(color: Color(0xFFAD2EE5))),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Text(
                  "You",
                  style: TextStyle(
                      color: Color(0xFFAD2EE5),
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
              )
            : !_userController.userModel.value!.buddies!.contains(isLive
                    ? _getCheckInController
                        .eventModel!.value.event!.checkedIn![i].id
                    : _getCheckInController
                        .eventModel!.value.event!.attendies![i].id)
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w.h),
                          color: Color(0xFFAD2EE5)),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      child: Text(
                        "Catch-up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w.h),
                        border: Border.all(color: Color(0xFFAD2EE5))),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Text(
                      "Unfollow",
                      style: TextStyle(
                          color: Color(0xFFAD2EE5),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    ),
                  )
      ],
    ),
  );
}
