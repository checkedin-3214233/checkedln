import 'dart:io';

import 'package:checkedln/res/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/auth_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import 'auth_helper_screen.dart';

class MakeYourProfilePop extends StatefulWidget {
  const MakeYourProfilePop({super.key});

  @override
  State<MakeYourProfilePop> createState() => _MakeYourProfilePopState();
}

class _MakeYourProfilePopState extends State<MakeYourProfilePop> {
  ColorsFile colorsFile = getIt<ColorsFile>();
  AuthController _authController = Get.find<AuthController>();

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
              authHeading("Make Your Profile Pop"),
              authSubHeading(
                  "Help others find you! A few more pics go a long way."),
              Obx(() => GridView.builder(
                  shrinkWrap: true,
                  itemCount: _authController.userImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(4.0), // Margin around each item
                      decoration: BoxDecoration(
                        color: Color(0xFFEBE9EC), // Color of the rounded square
                        borderRadius: BorderRadius.circular(
                            12.0), // Radius of the rounded corners
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            if (index == 0 &&
                                _authController.userImages[0].isNotEmpty) {
                              showSnakBar("Profile Image Can't be changed");
                            } else {
                              XFile? image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                _authController.userImages[index] = "loading";
                                var imagePath = await _authController
                                    .uploadImage(File(image.path));

                                _authController.userImages[index] = imagePath;
                              }
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: _authController.userImages[index] ==
                                    "loading"
                                ? Center(child: CircularProgressIndicator())
                                : _authController.userImages[index].isNotEmpty
                                    ? Image.network(
                                        _authController.userImages[index],
                                        fit: BoxFit.cover,
                                        width: 114.w,
                                        height: 111.h,
                                      )
                                    : Image.asset(
                                        "assets/images/add_circle.webp",
                                        fit: BoxFit.cover,
                                        width: 32.w,
                                        height: 32.h,
                                      ),
                          ),
                        ),
                      ),
                    );
                  })),
              textTwoTittle(
                  "+ ",
                  Text(
                    "Add more",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: getIt<ColorsFile>().textColor5,
                        fontWeight: FontWeight.w600),
                  ), () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  _authController.userImages.add(image.path);
                }
              }).marginOnly(top: 16.h),
            ],
          ),
          Obx(() => _authController.isCreatingAccount.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : authButton(
                  getIt<ColorsFile>().primaryColor,
                  Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorsFile.whiteColor, fontSize: 16.sp),
                  ),
                  () async {
                    await _authController.signup();
                  },
                )),
        ],
      ).marginSymmetric(vertical: 16.h, horizontal: 16.w)),
    );
  }
}
