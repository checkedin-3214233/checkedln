import 'package:checkedln/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget textColumn(String count, String name) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        count,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
      ),
      Text(name, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600))
    ],
  );
}

Widget shareButton(Icon icon, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.h,
      child: icon,
      decoration: BoxDecoration(
          color: Color(0xffEBE9EC),
          borderRadius: BorderRadius.circular(10.w.h)),
    ),
  );
}

Widget tabContainer(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xff28222A), fontWeight: FontWeight.w600, fontSize: 16.sp),
  );
}

Widget twoTile(String title, Widget widget, Function() onPressed) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(ctx!).size.width,
    padding: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
        color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(16.w.h)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
        SizedBox(
          width: 10.w,
        ),
        Text(title,
            style: TextStyle(
                color: Color(0xff050506),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
