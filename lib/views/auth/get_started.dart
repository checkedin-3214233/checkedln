import 'dart:io';

import 'package:checkedln/controller/auth_controller.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
                InkWell(
                  onTap: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      var imagePath =
                          await _authController.uploadImage(File(image.path));
                      _authController.profileImageUrl.value = imagePath;
                      _authController.userImages[0] = imagePath;
                    }
                  },
                  child: Obx(
                    () => _authController.profileImageUrl.isEmpty
                        ? Image.asset(
                            "assets/images/add_profile_pic.webp",
                          ).marginOnly(bottom: 8.h)
                        : _authController.isImageUploading.value
                            ? CircularProgressIndicator()
                            : Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.w.h),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(_authController
                                            .profileImageUrl.value))),
                              ).marginOnly(bottom: 8.h),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 5,
                          child: userName(_authController.firstName,
                                  TextInputType.name, "First Name*", false)
                              .marginOnly(right: 3.w)),
                      Expanded(
                          flex: 5,
                          child: userName(_authController.lastName,
                                  TextInputType.name, "Last Name*", false)
                              .marginOnly(left: 3.w))
                    ]),
                userName(_authController.userName, TextInputType.name,
                    "User Name*", false),
                userName(_authController.dateOfBirth, TextInputType.text,
                    "Date of Birth*", false),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F4F6),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Your Gender',
                          style: TextStyle(
                              color: Color(0XFFA294A8),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400)),
                      value: _authController.selectedGender,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 36.0,
                      elevation: 16,
                      onChanged: (String? newValue) {
                        setState(() {
                          _authController.selectedGender = newValue!;
                          _authController.gender.text = newValue.toLowerCase();
                        });
                      },
                      items: <String>['Male', 'Female', "Other"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                value == 'Male'
                                    ? Icons.male
                                    : value == 'Female'
                                        ? Icons.female
                                        : Icons.error,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 8.0),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                userName(_authController.bio, TextInputType.text, "Bio", false),
                Obx(() => _authController.isCreatingAccount.value
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
                          bool check = _authController.validateGetStarted();
                          if (check) {
                            ctx!.push(RoutesConstants.authHelper);
                          }
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
