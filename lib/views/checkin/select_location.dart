import 'dart:developer';

import 'package:checkedln/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../controller/checkin/create_checkin_controller.dart';
import '../widget_helper.dart';
import 'checkin_widget_helper.dart';

class SelectLocation extends StatefulWidget {
  TextEditingController controller;
  SelectLocation({super.key, required this.controller});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  CreateCheckInController _checkInController =
      Get.find<CreateCheckInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: mainAppBar("Select Location", [], SizedBox.shrink(), false),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (val) async {
                await _checkInController.searchAddress();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                hintText: 'Search',
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey), // Search icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xFFDDD8DF), // Border color in hex
                    width: 1.0, // Border width
                  ),
                  //ional border radius
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Color(0xffDDD8DF), // Bo
                      // rder color for focused state
                      width: 1.0,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDDD8DF), // Border color for focused state
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ).paddingSymmetric(horizontal: 16.w, vertical: 12.h),
            Obx(() => Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: _checkInController.address.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            log(_checkInController.address[i]
                                .toJson()
                                .toString());
                            _checkInController.location.text =
                                _checkInController.address[i].formattedAddress!;
                            log(_checkInController.address[i].latitude!
                                .toString());
                            log(_checkInController.address[i].longitude!
                                .toString());
                            _checkInController.latitude.value =
                                _checkInController.address[i].latitude!;
                            _checkInController.longitude.value =
                                _checkInController.address[i].longitude!;
                            _checkInController.update();
                            ;
                            ctx!.pop();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _checkInController.address[i].formattedAddress!,
                                textAlign: TextAlign.start,
                              ).paddingSymmetric(horizontal: 16.w),
                              Divider(
                                thickness: 1,
                                color: Color(0xFF000000).withOpacity(0.1),
                              )
                            ],
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
