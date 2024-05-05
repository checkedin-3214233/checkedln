import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'checkin/checkin_info.dart';

Widget backButton(Icon icon, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.h,
      child: icon,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.w.h)),
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
      width: MediaQuery.of(Get.context!).size.width,
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
          !isBottom ? const Size.fromHeight(0) : const Size.fromHeight(50),
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
        Get.back();
      },
      child: Image.asset(
        "assets/images/back_btn.webp",
        height: 40.h,
        width: 40.w,
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

Widget nearByCheckIn() {
  return SizedBox(
    height: 96.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: (){
              Get.to(()=>CheckInfoScreen());
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
                            image: NetworkImage(
                                "https://www.adobe.com/content/dam/cc/us/en/creativecloud/photography/discover/concert-photography/thumbnail.jpeg"))),
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
                            "Arjit Singh Concert",
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
                            "500 Attendees",
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
                          Image.asset("assets/images/people.png"),
                          Text(
                            "10 Mutuals",
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: 10),
  ).marginSymmetric(vertical: 10.h);
}