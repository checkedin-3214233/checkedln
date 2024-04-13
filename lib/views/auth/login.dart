import 'package:checkedln/views/auth/authentication_screen.dart';
import 'package:checkedln/views/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import 'auth_helper_screen.dart';
import 'otp_verification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ColorsFile colorsFile = getIt<ColorsFile>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
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
              authHeading("Login"),
              authSubHeading("Welcome Back! 👋"),
              Row(children: [
                Expanded(flex: 2, child: phoneNumberField(false)),
                Expanded(flex: 8, child: phoneNumberField(true))
              ]).marginOnly(top: 16.h, bottom: 8.h),
              Obx(() => authController.isSendingOtp.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : authButton(
                      getIt<ColorsFile>().primaryColor,
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorsFile.whiteColor, fontSize: 16.sp),
                      ),
                      () async {
                        await authController.checkUser(true);
                      },
                    )),
              textTwoTittle(
                  "Don’t have an account? ",
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: getIt<ColorsFile>().textColor2,
                        fontWeight: FontWeight.w700),
                  ), () {
                Get.to(() => SignUp());
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
