import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/checkin/check_in_controller.dart';
import 'home_helper.dart';
import 'story_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CheckInController _checkInController= Get.find<CheckInController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            storyView(),
            Divider(
              thickness: 1,
              color: Color(0xffEBE9EC),
            ),
            Text(
              "Nearby Check-ins",
              textAlign: TextAlign.start,
              style: TextStyle(

                  color: Color(0xff050506),
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp),
            ),
            nearByCheckIn(),
            Text(
              "Suggestions",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff050506),
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp),
            ),
            suggestion(),
            Text(
              "Popular Check-ins",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff050506),
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp),
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return Container(
                    height: 150.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            ProfileAvatar(
                                imageUrl:
                                    "https://www.shutterstock.com/image-photo/excited-happy-young-indian-man-260nw-2118627149.jpg",
                                size: 24,
                                child: SizedBox.shrink(),
                                borderColor: Color(0xffEBEBEB)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("Tushar Shah",
                                style: TextStyle(
                                    color: Color(0xff050506),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "2 min ago",
                              style: TextStyle(
                                  color: Color(0xff85738C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/venuenew.png"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "ShivSoul Festival 2024",
                              style: TextStyle(
                                  color: Color(0xff9219C7),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/attending.png"),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Attendees",
                              style: TextStyle(
                                  color: Color(0xff6A5C70),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "500",
                              style: TextStyle(
                                  color: Color(0xff28222A),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.w.h)),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Image.asset("assets/images/like.png"),
                              SizedBox(width: 5.w),
                              Text(
                                "Interested",
                                style: TextStyle(
                                    color: Color(0xff4A404F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(12.w.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w.h),
                        color: Color(0xFFEBEBEB)),
                  );
                },
                separatorBuilder: (context, i) {
                  return Padding(padding: EdgeInsets.symmetric(vertical: 5.h));
                },
                itemCount: 10)
          ],
        ).marginSymmetric(horizontal: 10.w),
      )),
    );
  }
}
