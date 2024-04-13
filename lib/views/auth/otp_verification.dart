import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controller/auth_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import 'auth_helper_screen.dart';
import 'get_started.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  ColorsFile colorsFile = getIt<ColorsFile>();
  AuthController authController = Get.find<AuthController>();
  final defaultPinTheme = PinTheme(
    width: 53.w,
    height: 50.h,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color(0xffF5F4F6),
      border: Border.all(color: Color(0xffF5F4F6)),
      borderRadius: BorderRadius.circular(11.w.h),
    ),
  );

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
              authHeading("Verify OTP"),
              authSubHeading(
                  "Enter the 6-digit code sent to your registered phone number +91********10"),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme,
                submittedPinTheme: defaultPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) async =>
                    {Get.find<AuthController>().verifyOtp(pin)},
              ).marginOnly(top: 16.h, bottom: 8.h),
              textTwoTittle(
                      "Didn't received the OTP? ",
                      Text(
                        "RESEND",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: getIt<ColorsFile>().textColor6,
                            fontWeight: FontWeight.w700),
                      ),
                      () {})
                  .marginOnly(top: 8.h, bottom: 8.h),
              Obx(
                () => authController.isOtpVerification.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : authButton(
                        getIt<ColorsFile>().primaryColor,
                        Text(
                          "Verify",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colorsFile.whiteColor, fontSize: 16.sp),
                        ),
                        () {},
                      ),
              )
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
