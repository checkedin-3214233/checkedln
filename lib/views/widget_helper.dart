import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

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
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      alignment: Alignment.center,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(11.5.w.h),
      ),
      child: text,
    ),
  ).marginOnly(
    top: 20.h,
  );
}

AppBar mainAppBar(String tittle) {
  return AppBar(
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
    actions: [
      Image.asset(
        "assets/images/search.png",
        height: 40.h,
        width: 40.w,
      ).marginOnly(right: 10.w),
    ],
  );
}
