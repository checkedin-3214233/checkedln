import 'package:checkedln/controller/settings_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget threeTile(SvgPicture leading, String title, Function() onTap) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: title != "Logout" ? Color(0xff050506) : Color(0xffFF1717)),
    ),
    leading: leading,
    trailing: title != "Logout"
        ? SvgPicture.asset("assets/images/next_new.svg")
        : SizedBox.shrink(),
    onTap: onTap,
  );
}
