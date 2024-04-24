import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textColumn(String count, String name) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(count,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w800),), Text(name,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600))],
  );
}
Widget shareButton(Icon icon,Function() onPressed){
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.h,
      child: icon,
      decoration: BoxDecoration(color: Color(0xffEBE9EC),borderRadius: BorderRadius.circular(10.w.h)),
    ),
  );
}
Widget tabContainer(String text){
  return Text(text,style: TextStyle(color: Color(0xff28222A),fontWeight: FontWeight.w600,fontSize: 16.sp),);
}