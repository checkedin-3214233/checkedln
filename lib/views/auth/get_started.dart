import 'package:checkedln/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import 'auth_helper_screen.dart';
import 'login.dart';
import 'make_your_profile_pop.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  ColorsFile colorsFile = getIt<ColorsFile>();
  AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authHeading("Get Started"),
                authSubHeading("Turn events into lasting friendships!"),
                Text(
                  "Profile Picture",
                  style:
                      TextStyle(color: colorsFile.textColor4, fontSize: 16.sp),
                ).marginOnly(top: 16.h, bottom: 8.h),
                Image.asset(
                  "assets/images/add_profile_pic.webp",
                ).marginOnly(bottom: 8.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 5,
                          child: userName(TextEditingController(),
                                  TextInputType.name, "First Name*")
                              .marginOnly(right: 3.w)),
                      Expanded(
                          flex: 5,
                          child: userName(TextEditingController(),
                                  TextInputType.name, "Last Name*")
                              .marginOnly(left: 3.w))
                    ]),
                userName(
                    TextEditingController(), TextInputType.name, "User Name*"),
                userName(TextEditingController(), TextInputType.text,
                    "Date of Birth*"),
                userName(TextEditingController(), TextInputType.text,
                    "Select Gender"),
                userName(TextEditingController(), TextInputType.text, "Bio"),
                authButton(
                  getIt<ColorsFile>().primaryColor,
                  Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorsFile.whiteColor, fontSize: 16.sp),
                  ),
                  () {
                    Get.to(() => MakeYourProfilePop());
                  },
                ),
                textTwoTittle(
                    "Already have an account? ",
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: getIt<ColorsFile>().textColor2,
                          fontWeight: FontWeight.w700),
                    ), () {
                  Get.to(() => Login());
                }).marginOnly(top: 16.h),
              ],
            ),
          ],
        ).marginSymmetric(vertical: 16.h, horizontal: 16.w),
      )),
    );
  }
}
