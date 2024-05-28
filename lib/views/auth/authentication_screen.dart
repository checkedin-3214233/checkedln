import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/views/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/auth_controller.dart';
import '../../res/colors/colors.dart';
import 'auth_helper_screen.dart';
import 'login.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  ColorsFile colorsFile = getIt<ColorsFile>();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              "assets/images/auth_public.webp",
              width: 390.w,
              height: 412.h,
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Missed Connections?\nNot Anymore.",
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: colorsFile.secondaryColor,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "It's easy to find those awesome people you met!",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: colorsFile.textColor1,
                      fontWeight: FontWeight.w400),
                ),
                authButton(
                  getIt<ColorsFile>().primaryColor,
                  Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorsFile.whiteColor, fontSize: 16.sp),
                  ),
                  () {
                    ctx!.push(RoutesConstants.signUp);
                  },
                ),
                authButton(
                  colorsFile.greyColorButton,
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorsFile.textColor5, fontSize: 16.sp),
                  ),
                  () {
                    ctx!.push(RoutesConstants.login);
                  },
                ),
              ],
            ),
          )
        ],
      ).marginSymmetric(horizontal: 16.w, vertical: 5.h)),
    );
  }
}
