import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:checkedln/views/profiles/profile_widget_helper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../controller/user_controller.dart';
import '../checkin/past_checkin_sceen.dart';
import '../widget_helper.dart';
import 'edit_profile_screen.dart';
import 'my_post_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  UserController _userController = Get.find<UserController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s) {
        Get.find<HomeController>().currentBottomIndex.value = 0;
        return;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Obx(
              () => _userController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(mainAxisSize: MainAxisSize.max, children: [
                      _userController.userModel.value!.userImages!.isEmpty
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
                      _userController.userModel.value!.userImages!.isNotEmpty
                          ? GestureDetector(
                              onHorizontalDragStart: (details) {
                                if (details.localPosition.dx >
                                    MediaQuery.of(context).size.width / 2) {
                                  if (_userController.currentImageCount.value ==
                                      0) {
                                    _userController.currentImageCount.value =
                                        _userController.userModel.value!
                                                .userImages!.length -
                                            1;
                                  } else {
                                    _userController.currentImageCount.value--;
                                  }
                                } else {
                                  if (_userController.currentImageCount.value ==
                                      _userController.userModel.value!
                                              .userImages!.length -
                                          1) {
                                    _userController.currentImageCount.value = 0;
                                  } else {
                                    _userController.currentImageCount.value++;
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                          child: Image.asset(
                                              "assets/images/edit.png"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DotsIndicator(
                                          dotsCount: _userController.userModel
                                              .value!.userImages!.length,
                                          position: _userController
                                              .currentImageCount.value,
                                          decorator: DotsDecorator(
                                            size: Size(6.w, 6.h),
                                            color:
                                                Colors.white, // Inactive color
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
                                        image: NetworkImage(_userController
                                                .userModel.value!.userImages![
                                            _userController
                                                .currentImageCount.value]))),
                              ),
                            )
                          : SizedBox.shrink(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: Offset(0.0, -40.0), //
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: ProfileAvatar(
                                      imageUrl: _userController.userModel.value!
                                              .profileImageUrl!.isEmpty
                                          ? "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg"
                                          : _userController.userModel.value!
                                              .profileImageUrl!,
                                      size: 107,
                                      child: Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffEBE9EC),
                                        ),
                                        child: Image.asset(
                                            "assets/images/edit.png"),
                                      ),
                                      borderColor: Colors.white,
                                    ),
                                  ),
                                  textColumn(
                                      _userController
                                          .userModel.value!.buddies!.length
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
                                _userController.userModel.value!.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, -25.0), //

                              child: Text(
                                _userController.userModel.value!.userName!,
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
                                _userController.userModel.value!.bio!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Color(0xff28222A)),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, -10.0), //
                              child: button(
                                  Color(0xffEBE9EC),
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff4A404F)),
                                  ), () {
                                Get.to(() => EditProfileScreen());
                              }),
                            ),
                            TabBar(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: Color(0xff000000),
                                indicatorWeight: 2,
                                tabs: [
                                  tabContainer("Post"),
                                  tabContainer("My Checkins")
                                ]),
                            SizedBox(
                                height: 500.h,
                                child: TabBarView(
                                  children: [
                                    MyPostScreen(),
                                    PastCheckInScreen(),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ]),
            )),
          ),
        ),
      ),
    );
  }
}
