import 'dart:developer';

import 'package:checkedln/services/auth/auth_services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_auth_service.dart';
import '../views/auth/otp_verification.dart';

class AuthController extends GetxController {
  FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController =
      TextEditingController(text: "+91");
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();

  final AuthServices _authServices = AuthServices();
  var verificationId = "".obs;
  var isOtpSent = false.obs;
  var isSendingOtp = false.obs;
  var isOtpVerification = false.obs;
  var isLoginScreen = true.obs;
  validatePhoneNumber() async {
    isSendingOtp.value = true;
    if (phoneNumberController.text.length == 10 &&
        countryCodeController.text.isNotEmpty) {
      try {
        await _firebaseAuthServices.sendOtp(
            "${countryCodeController.text}${phoneNumberController.text}");
      } catch (e) {
        Get.rawSnackbar(message: "Some error occurred at our end $e");
      }
    } else {
      Get.rawSnackbar(message: "Invalid Phone Number");
    }
    isSendingOtp.value = false;
  }

  verifyOtp(String otp) async {
    isOtpVerification.value = true;
    bool isVerified =
        await _firebaseAuthServices.veryfyotp(verificationId.value, otp);
    if (isVerified) {
      Get.rawSnackbar(message: "OTP verification Successfull");
      if (isLoginScreen.value) {
        login();
      }
    }
    isOtpVerification.value = false;
  }

  checkUser(bool isLogin) async {
    isLoginScreen.value = isLogin;
    isSendingOtp.value = true;
    log("${countryCodeController.text}${phoneNumberController.text}");
    try {
      dio.Response response = await _authServices.checkUser(
          "${countryCodeController.text}${phoneNumberController.text}");
      if (response.statusCode == 200) {
        if (isLogin) {
          if (response.data['isUserExists']) {
            validatePhoneNumber();
          } else {
            Get.rawSnackbar(message: response.data['message']);
          }
        } else {
          if (!response.data['isUserExists']) {
          } else {
            Get.rawSnackbar(message: response.data['message']);
          }
        }
      } else {
        Get.rawSnackbar(message: "Some error occurred at our end");
      }
    } catch (e) {
      Get.rawSnackbar(message: "Some error occurred at our end $e");
    }
    isSendingOtp.value = false;
  }

  login() async {
    log("${countryCodeController.text}${phoneNumberController.text}");
    try {
      dio.Response response = await _authServices.loginUser(
          "${countryCodeController.text}${phoneNumberController.text}");
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        Get.rawSnackbar(message: "Some error occurred at our end");
      }
    } catch (e) {
      Get.rawSnackbar(message: "Some error occurred at our end $e");
    }
  }

  // signup() async {
  //   log("${countryCodeController.text}${phoneNumberController.text}");
  //   try {
  //     dio.Response response = await _authServices
  //         .signup("${countryCodeController.text}${phoneNumberController.text}");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //     } else {
  //       Get.rawSnackbar(message: "Some error occurred at our end");
  //     }
  //   } catch (e) {
  //     Get.rawSnackbar(message: "Some error occurred at our end $e");
  //   }
  // }
}
