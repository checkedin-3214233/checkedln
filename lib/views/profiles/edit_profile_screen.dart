import 'dart:io';

import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/profiles/profile_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/user_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';
import '../auth/auth_helper_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: shareButton(
                    Icon(Icons.arrow_back_ios_new_sharp), () => Get.back()),
                title: Text(
                  "Edit Profile",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
                ),
                centerTitle: true,
              ),
              Obx(() => _userController.isImageUploading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () async {
                        XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          var imagePath = await _userController
                              .uploadImage(File(image.path));
                          _userController.profileUrl.value = imagePath;
                        }
                      },
                      child: Container(
                        child: ProfileAvatar(
                          imageUrl: _userController.profileUrl.value.isEmpty
                              ? _userController.userModel.value!.gender ==
                                      "male"
                                  ? "https://userallimages.s3.amazonaws.com/male.png"
                                  : "https://userallimages.s3.amazonaws.com/female.png"
                              : _userController.profileUrl.value,
                          size: 107,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffEBE9EC),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          borderColor: Colors.white,
                        ),
                      ),
                    )),
              SizedBox(
                height: 15,
              ),
              Text(
                "Edit Profile Picture",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Color(0xffA294A8)),
              ),
              SizedBox(
                height: 15,
              ),
              userName(_userController.firstName, TextInputType.text,
                  "First Name", true),
              userName(_userController.lastName, TextInputType.text,
                  "Last Name", true),
              userName(_userController.userName, TextInputType.text,
                  "User Name", true),
              userName(_userController.dateOfBirth, TextInputType.text,
                  "Date of Birth*", false),
              userName(_userController.gender, TextInputType.text,
                  "Select Gender", false),
              userName(_userController.bio, TextInputType.text, "Bio", false),
              Obx(() => _userController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : authButton(
                      getIt<ColorsFile>().primaryColor,
                      Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: getIt<ColorsFile>().whiteColor,
                            fontSize: 16.sp),
                      ),
                      () async {
                        await _userController.updateUser();
                      },
                    ))
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
