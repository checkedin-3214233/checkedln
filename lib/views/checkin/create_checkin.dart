import 'dart:io';

import 'package:checkedln/controller/checkin/check_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/checkin/create_checkin_controller.dart';
import '../widget_helper.dart';
import 'checkin_widget_helper.dart';

class CreateCheckIn extends StatefulWidget {
  const CreateCheckIn({super.key});

  @override
  State<CreateCheckIn> createState() => _CreateCheckInState();
}

class _CreateCheckInState extends State<CreateCheckIn> {
  CreateCheckInController _checkInController =
      Get.find<CreateCheckInController>();
  String? _selectedItem;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Obx(() => _checkInController.isCreatingEvent.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () async {
                    if (_checkInController.isEditing.value) {
                      await _checkInController.editEvent();
                    } else {
                      await _checkInController.createEvent();
                    }
                  },
                  child: Container(
                    height: 62.h,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    alignment: Alignment.center,
                    child: Text(
                      _checkInController.isEditing.isTrue ? "Edit" : "Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w.h),
                        color: Color(0xffBD57EA)),
                  ),
                )),
      appBar: mainAppBar("Check-ins", [], SizedBox.shrink(), false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _checkInController.isEditing.value
                  ? SizedBox.shrink()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F4F6),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('Select check-in type',
                              style: TextStyle(
                                  color: Color(0XFFA294A8),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400)),
                          value: _selectedItem,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36.0,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue!;
                            });
                            _checkInController.typeController.text =
                                newValue!.toLowerCase();
                          },
                          items:
                              <String>['Public', 'Private'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Icon(
                                    value == 'Public'
                                        ? Icons.public
                                        : Icons.lock,
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
              Obx(() => InkWell(
                    onTap: () async {
                      XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        var imagePath = await _checkInController
                            .uploadImage(File(image.path));
                        _checkInController.bannerImage.value = imagePath;
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 201.h,
                      child: _checkInController.bannerImage.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/gallery_svg.svg"),
                                Text(
                                  "Add Check-in images",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: Color(0xffBFB6C3)),
                                )
                              ],
                            )
                          : null,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F4F6),
                        image: _checkInController.bannerImage.isNotEmpty
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    _checkInController.bannerImage.value))
                            : null,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: userName(_checkInController.startDateTime,
                        TextInputType.datetime, "Start Date", true),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: userName(_checkInController.endDateTime,
                        TextInputType.datetime, "End Date", true),
                  ),
                ],
              ).marginSymmetric(vertical: 5.h),
              Row(
                children: [
                  Expanded(
                    child: userName(_checkInController.startTime,
                        TextInputType.datetime, "Start Time", true),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: userName(_checkInController.endTime,
                        TextInputType.datetime, "End Time", true),
                  ),
                ],
              ).marginSymmetric(vertical: 5.h),
              userName(_checkInController.checkInNameController,
                      TextInputType.name, "Event Name", false)
                  .marginSymmetric(vertical: 5.h),
              userName(_checkInController.location, TextInputType.name,
                      "Event Venue", true)
                  .marginSymmetric(vertical: 5.h),
              userName(_checkInController.priceController, TextInputType.number,
                      "Price (optional)", false)
                  .marginSymmetric(vertical: 5.h),
              userName(_checkInController.aboutCheckIn, TextInputType.name,
                      "Write about Check-in", false)
                  .marginSymmetric(vertical: 5.h),
            ],
          ).marginSymmetric(horizontal: 16.w),
        ),
      ),
    );
  }
}
