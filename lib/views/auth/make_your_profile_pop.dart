import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            index == 0
                                ? "assets/images/profile_pic.webp"
                                : "assets/images/add_circle.webp",
                            fit: BoxFit.cover,
                            width: index == 0 ? 114.w : 32.w,
                            height: index == 0 ? 111.h : 32.h,
                          ),
                        ),
                      ),
                    );
                  }),
              textTwoTittle(
                      "+ ",
                      Text(
                        "Add more",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: getIt<ColorsFile>().textColor5,
                            fontWeight: FontWeight.w600),
                      ),
                      () {})
                  .marginOnly(top: 16.h),
            ],
          ),
          authButton(
            getIt<ColorsFile>().primaryColor,
            Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(color: colorsFile.whiteColor, fontSize: 16.sp),
            ),
            () {},
          ),
        ],
      ).marginSymmetric(vertical: 16.h, horizontal: 16.w)),
    );
  }
}
