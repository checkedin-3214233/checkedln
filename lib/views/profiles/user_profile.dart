import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/profiles/profile_widget_helper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../checkin/past_checkin_sceen.dart';
import '../widget_helper.dart';
import 'my_post_screen.dart';

class UserProfile extends StatefulWidget {
  UserModel? userModel;
   UserProfile({super.key,required this.userModel});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int currentImageCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.max, children: [
        widget.userModel!.userImages!.isEmpty
            ? Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  backButton(
                      Icon(Icons.arrow_back_ios_rounded),
                          () {}),
                  backButton(Icon(Icons.settings), () {}),
                ],
              ),
            ],
          ),
          height: 272,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/images/bgProfile.png"))),
        )
            : SizedBox.shrink(),
        widget.userModel!.userImages!.isNotEmpty
            ? Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10.w, vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  backButton(
                      Icon(Icons.arrow_back_ios_rounded),
                          () {}),
                  backButton(Icon(Icons.settings), () {}),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(6.0),
                    width: 30.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEBE9EC),
                    ),
                    child:
                    Image.asset("assets/images/edit.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DotsIndicator(
                    dotsCount: widget
                        .userModel!.userImages!.length,
                    position:
                        currentImageCount,
                    decorator: DotsDecorator(
                      size: Size(6.w, 6.h),
                      color: Colors.white, // Inactive color
                      activeColor: Color(0xffAD2EE5),
                    ),
                  )
                ],
              )
            ],
          ),
          height: 272,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget
                      .userModel!.userImages![

                      currentImageCount]))),
        )
            : SizedBox.shrink(),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0.0, -40.0), //
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: ProfileAvatar(
                        imageUrl: widget.userModel!
                            .profileImageUrl!.isEmpty
                            ? "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg"
                            : widget
                            .userModel!.profileImageUrl!,
                        size: 107,
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEBE9EC),
                          ),
                          child:
                          Image.asset("assets/images/edit.png"),
                        ),
                        borderColor: Colors.white,
                      ),
                    ),
                    textColumn(
                        widget
                            .userModel!.buddies!.length
                            .toString(),
                        "Buddies"),
                    textColumn("0", "Checkins"),
                    shareButton(
                        Icon(Icons.share_outlined), () => null)
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, -30.0), //

                child: Text(
                  widget.userModel!.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                  textAlign: TextAlign.start,
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, -25.0), //

                child: Text(
                  widget.userModel!.userName!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xff6A5C70)),
                  textAlign: TextAlign.start,
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, -5.0), //
                child: Text(
                  widget.userModel!.bio!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Color(0xff28222A)),
                ),
              ),



            ],
          ),
        )
      ]),)),
    );
  }
}
