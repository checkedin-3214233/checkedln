import 'package:checkedln/controller/auth_controller.dart';
import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../res/colors/colors.dart';
import '../../../global_index.dart';

Widget authButton(Color color, Text text, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
      alignment: Alignment.center,
      width: MediaQuery.of(ctx!).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(11.5.w.h),
      ),
      child: text,
    ),
  ).marginOnly(
    top: 16.h,
  );
}

Widget textTwoTittle(String tittle1, Text tittle2, Function() onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(tittle1,
          style: TextStyle(
              fontSize: 14.sp,
              color: getIt<ColorsFile>().textColor1,
              fontWeight: FontWeight.w400)),
      InkWell(onTap: onPressed, child: tittle2)
    ],
  );
}

AppBar appBar() {
  return AppBar(
    elevation: 0,
    leading: InkWell(
      onTap: () {
        ctx!.pop();
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SvgPicture.asset("assets/images/backGreay.svg",
            height: 20.h, width: 20.w),
      ),
    ),
  );
}

Widget authHeading(String heading) {
  return Text(
    heading,
    textAlign: TextAlign.start,
    style: TextStyle(
        fontSize: 28.sp,
        color: getIt<ColorsFile>().secondaryColor,
        fontWeight: FontWeight.w800),
  );
}

Widget authSubHeading(String heading) {
  return Text(
    heading,
    textAlign: TextAlign.start,
    style: TextStyle(
        fontSize: 16.sp,
        color: getIt<ColorsFile>().textColor1,
        fontWeight: FontWeight.w400),
  );
}

Widget phoneNumberField(bool isNumber) {
  AuthController authController = Get.find<AuthController>();
  return TextField(
    maxLength: isNumber ? 10 : 3,
    keyboardType: TextInputType.phone,
    controller: isNumber
        ? authController.phoneNumberController
        : authController.countryCodeController,
    decoration: InputDecoration(
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
      hintText: isNumber ? 'Enter Phone Number' : "+91",

      hintStyle: TextStyle(
        color: Color(0xFF28222A), // Text color
        fontWeight: FontWeight.w500, // Text weight
        fontSize: 16.0, // Text size
      ),
    ),
  ).marginOnly(right: 8.w);
}

Widget userName(TextEditingController controller, TextInputType type,
    String hintText, bool isEditable) {
  const gender = ["male", "female", "other"];
  return TextField(
    textInputAction: TextInputAction.next,
    onTap: () async {
      if (hintText == "Date of Birth*") {
        final DateTime? picked = await showDatePicker(
          context: ctx!,
          initialDate: DateTime.now(),
          firstDate: DateTime(150),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          controller.text = picked.toString().substring(0, 10);
        }
      }
      if (hintText == "Select Gender") {
        showDialog(
          context: ctx!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select an Option'),
              content: DropdownButton(
                hint: Text(controller.text),
                items: gender.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(option == "male"
                              ? Icons.male
                              : option == "female"
                                  ? Icons.female
                                  : Icons.error),
                          Text(option)
                        ]),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.text = newValue.toString();
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      }
    },
    readOnly: isEditable ||
        hintText == "Date of Birth*" ||
        hintText == "Select Gender",
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      suffixIcon: hintText == "Date of Birth*"
          ? Image.asset("assets/images/calender.webp")
          : hintText == "Select Gender"
              ? Image.asset("assets/images/drop_down.webp")
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
