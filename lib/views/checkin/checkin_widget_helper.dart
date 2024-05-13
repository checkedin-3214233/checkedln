import 'package:checkedln/views/checkin/select_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/checkin/check_in_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

Widget tabContainer(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xff28222A), fontWeight: FontWeight.w600, fontSize: 14.sp),
  );
}

Widget checkInButton(Widget child, Function() onPressed, Color color) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      alignment: Alignment.center,
      width: MediaQuery.of(Get.context!).size.width,
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
                      : _checkInController
                      .pastEvent[count].checkInName!,
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
                      "${isUpcoming
                          ? _checkInController
                          .upcomingEvents[count].attendies!.length
                          : _checkInController
                          .pastEvent[count].attendies!.length} Attending",
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
          isUpcoming
              ? _checkInController
              .upcomingEvents[count].location!
              : _checkInController
              .pastEvent[count].location!,
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
                  DateFormat('EEEE').format(isUpcoming
                      ? _checkInController
                      .upcomingEvents[count].startDateTime!
                      : _checkInController
                      .pastEvent[count].startDateTime!),
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(isUpcoming
                      ? _checkInController
                      .upcomingEvents[count].startDateTime!
                      : _checkInController
                      .pastEvent[count].startDateTime!),
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
                  "${DateFormat('h:mm a').format(isUpcoming
                      ? _checkInController
                      .upcomingEvents[count].startDateTime!
                      : _checkInController
                      .pastEvent[count].startDateTime!)} Onwards",
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
     isUpcoming?   checkInButton(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/inviteIcon.png"),
                Text(
                  "Invite People",
                  style: TextStyle(
                      color: Color(0xff28222A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            () {},
            Color((0xffFFFFFF))):checkInButton(
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset("assets/images/gallery.png",height: 14.h,),
             Text(
               "Event Gallery",
               style: TextStyle(
                   color: Color(0xff28222A),
                   fontSize: 14.sp,
                   fontWeight: FontWeight.w600),
             )
           ],
         ),
             () {},
         Color((0xffFFFFFF))),
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

Widget checkIn2(){
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
                      image: NetworkImage("https://www.adobe.com/content/dam/cc/us/en/creativecloud/photography/discover/concert-photography/thumbnail.jpeg"))),
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
  final hour = timeOfDay.hour.toString().padLeft(2, '0'); // Ensure two digits for hour
  final minute = timeOfDay.minute.toString().padLeft(2, '0'); // Ensure two digits for minute
  return '$hour:$minute'; // Format as "HH:mm"
}
Widget userName(TextEditingController controller, TextInputType type,
    String hintText, bool isEditable) {
  const gender = ["male", "female", "other"];
  return TextField(
    maxLines: hintText == "Write about Check-in" ? 3 : null,
    textInputAction: TextInputAction.next,
    onTap: () async {
      if(hintText=="Event Venue"){
        Get.to(()=>SelectLocation(controller: controller,));
      }
      if (hintText == "Start Date" || hintText == "End Date") {
        final DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        );
        if (picked != null) {
          controller.text = picked.toString().substring(0, 10);
        }

      }
      if (hintText == "Start Time" || hintText == "End Time") {
        final TimeOfDay? picked = await showTimePicker(
            context: Get.context!, initialTime: TimeOfDay.now());
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

Widget twoTile(String title, Widget widget, Function() onPressed,EdgeInsetsGeometry padding) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(Get.context!).size.width,
    padding: padding,
    decoration: BoxDecoration(
        color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(16.w.h)),
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
  );
}
