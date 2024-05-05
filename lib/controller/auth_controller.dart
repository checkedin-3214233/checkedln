import 'dart:developer';
import 'dart:io';

import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/services/auth/auth_services.dart';
import 'package:checkedln/services/upload_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/injection/dependency_injection.dart';
import '../services/firebase_auth_service.dart';
import '../views/auth/get_started.dart';
import '../views/home/home.dart';

class AuthController extends GetxController {
  FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController =
      TextEditingController(text: "+91");
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController gender = TextEditingController(text: "Your Gender");
  TextEditingController bio = TextEditingController();
  UploadImage _uploadImage = UploadImage();
  var selectedGender;
  var profileImageUrl = "".obs;
  var userImages = <String>["", "", "", "", "", ""].obs;
  var isImageUploading = false.obs;

  final AuthServices _authServices = AuthServices();
  var verificationId = "".obs;
  var isOtpSent = false.obs;
  var isSendingOtp = false.obs;
  var isCreatingAccount = false.obs;
  var isOtpVerification = false.obs;
  var isLoginScreen = true.obs;
  CacheManager cacheManager = getIt<CacheManager>();
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

  Future<String> uploadImage(File file) async {
    isImageUploading.value = true;
    try {
      String path = await _uploadImage.uploadImage(file);
      isImageUploading.value = false;
      return path;
    } catch (e) {
      isImageUploading.value = false;

      return "";
    }
  }

  verifyOtp(String otp) async {
    isOtpVerification.value = true;
    bool isVerified =
        await _firebaseAuthServices.veryfyotp(verificationId.value, otp);
    if (isVerified) {
      Get.rawSnackbar(message: "OTP verification Successfull");
      if (isLoginScreen.value) {
        await login();
      } else {
        Get.to(() => GetStarted());
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
            await validatePhoneNumber();
          } else {
            Get.rawSnackbar(message: response.data['message']);
          }
        } else {
          if (!response.data['isUserExists']) {
            await validatePhoneNumber();
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
        await cacheManager.setLoggedIn();
        await cacheManager.setUserId(response.data["user"]["userId"]);
        await cacheManager.setToken(response.data["user"]["accessToken"],
            response.data["user"]["refreshToken"]);
        Get.rawSnackbar(message: response.data['message']);

        Get.offAll(() => const Home());
      } else {
        Get.rawSnackbar(message: "Some error occurred at our end");
      }
    } catch (e) {
      Get.rawSnackbar(message: "Some error occurred at our end $e");
    }
  }

  signup() async {
    isCreatingAccount.value = true;
    List<String> images =[];
    for(int i=0;i<userImages.length;i++){
      if(userImages[i].isNotEmpty){
        images.add(userImages[i]);

      }
    }
    print(images);
    log("${countryCodeController.text}${phoneNumberController.text}");
    try {
      dio.Response response = await _authServices.signup(
          "${countryCodeController.text}${phoneNumberController.text}",
          userName.text,
          "${firstName.text} ${lastName.text}",
          profileImageUrl.value,
          DateTime.parse(dateOfBirth.text),
          gender.text,
          images,
          bio.text);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.rawSnackbar(message: response.data['message']);
        await cacheManager.setLoggedIn();
        await cacheManager.setUserId(response.data["user"]["userId"]);

        await cacheManager.setToken(response.data["user"]["accessToken"],
            response.data["user"]["refreshToken"]);
        Get.offAll(() => Home());
      } else {
        Get.rawSnackbar(message: response.data['message']);
      }
    } catch (e) {
      Get.rawSnackbar(message: "Some error occurred at our end $e");
    }
    isCreatingAccount.value = false;
  }

  bool validateGetStarted() {
    if (firstName.text.isEmpty) {
      Get.rawSnackbar(message: "First Name is required");
      return false;
    }
    if (lastName.text.isEmpty) {
      Get.rawSnackbar(message: "Last Name is required");
      return false;
    }
    if (userName.text.isEmpty) {
      Get.rawSnackbar(message: "User Name is required");

      return false;
    }
  if (userName.text.length < 6) {
    Get.rawSnackbar(message: 'Username must be at least 6 characters');

    return false;

    }  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(userName.text)) {
    Get.rawSnackbar(message:  'Username can only contain letters, numbers, and underscores');

    return false;

    }
    if (dateOfBirth.text.isEmpty) {
      Get.rawSnackbar(message: "Date of Birth is required");
      return false;
    }
    if (gender.text == "Your Gender") {
      Get.rawSnackbar(message: "Gender is required");
      return false;
    }

    return true;
  }
}
