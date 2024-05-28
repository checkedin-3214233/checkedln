import 'package:checkedln/global.dart';
import 'package:checkedln/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/auth_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import '../../res/colors/routes/route_constant.dart';
import 'auth_helper_screen.dart';
import 'otp_verification.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    ColorsFile colorsFile = getIt<ColorsFile>();

    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              authHeading("Sign up"),
              authSubHeading("Get Started! 👋"),
              Row(children: [
                Expanded(flex: 2, child: phoneNumberField(false)),
                Expanded(flex: 8, child: phoneNumberField(true))
              ]).marginOnly(top: 16.h, bottom: 8.h),
              Obx(() => _authController.isSendingOtp.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : authButton(
                      getIt<ColorsFile>().primaryColor,
                      Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorsFile.whiteColor, fontSize: 16.sp),
                      ),
                      () async {
                        await _authController.checkUser(false);
                      },
                    )),
              textTwoTittle(
                  "Already have an account? ",
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: getIt<ColorsFile>().textColor2,
                        fontWeight: FontWeight.w700),
                  ), () {
                ctx!.push(RoutesConstants.login);
              }).marginOnly(top: 16.h),
            ],
          ),
          textTwoTittle(
              "Having Issues? ",
              Text(
                "Contact Us",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: getIt<ColorsFile>().textColor3,
                    fontWeight: FontWeight.w600),
              ),
              () {})
        ],
      ).marginSymmetric(vertical: 16.h, horizontal: 16.w)),
    );
  }
}
