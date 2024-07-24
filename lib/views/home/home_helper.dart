import 'dart:developer';
import 'dart:io';

import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/controller/story_controller.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/views/chats/chat_screen.dart';
import 'package:checkedln/views/checkin/checkin_screen.dart';
import 'package:checkedln/views/home/story_view.dart';
import 'package:checkedln/views/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';

import '../../controller/user_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../services/Permission/permission_phone.dart';
import '../../services/upload_image.dart';
import '../dialog/dialog_helper.dart';
import '../notification/notification_screen.dart';
import '../profiles/profile_avatar.dart';
import '../search/search_screen.dart';

Widget bottomItem(int index) {
  HomeController _homeController = Get.find<HomeController>();
  return Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              if (index == 1) {
                ctx!.push(RoutesConstants.chat);
              } else if (index == 2) {
                ctx!.push(RoutesConstants.post);
              } else if (index == 3) {
                ctx!.push(RoutesConstants.allCheckin);
              } else {
                _homeController.currentBottomIndex.value = index;
              }
            },
            icon: SvgPicture.asset(
              _homeController.currentBottomIndex.value == index
                  ? _homeController.bottomNavigationJson["items"]![index]
                          ["selectedIcon"]
                      .toString()
                  : _homeController.bottomNavigationJson["items"]![index]
                          ["icon"]
                      .toString(),
              width: index == 2 ? 50.w : 21.w,
              height: index == 2 ? 50.h : 21.h,
            ),
          ),
          _homeController.currentBottomIndex.value == index
              ? SvgPicture.asset("assets/images/selectedBottom.svg")
              : SizedBox.shrink()
        ],
      ));
}

AppBar appBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: SvgPicture.asset("assets/images/logo.svg"),
    actions: [
      Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: InkWell(
              onTap: () {
                ctx!.push(RoutesConstants.search);
              },
              child: SvgPicture.asset("assets/images/search.svg"))),
      Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: GestureDetector(
              onTap: () {
                ctx!.push(RoutesConstants.notification);
              },
              child: SvgPicture.asset("assets/images/notifiction.svg")))
    ],
  );
}

Widget storyView(StoryController storyController) {
  return SizedBox(
    height: 72.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return i == 0
              ? GestureDetector(
                  onTap: () async {},
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10.w),
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Color(0xffEBE9EC),
                                  border: Border.all(
                                      color: Color(0xff9f2fe5), width: 2.w),
                                  image: DecorationImage(
                                      image: NetworkImage(Get.find<
                                                  UserController>()
                                              .userModel
                                              .value!
                                              .profileImageUrl!
                                              .isEmpty
                                          ? Get.find<UserController>()
                                                      .userModel
                                                      .value!
                                                      .gender ==
                                                  "male"
                                              ? "https://userallimages.s3.amazonaws.com/male.png"
                                              : "https://userallimages.s3.amazonaws.com/female.png"
                                          : Get.find<UserController>()
                                              .userModel
                                              .value!
                                              .profileImageUrl!),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  UploadImage uploadImage = UploadImage();
                                  List<XFile>? image =
                                      await ImagePicker().pickMultiImage();
                                  List<String> list = [];
                                  if (image.isEmpty) {
                                    return;
                                  }
                                  for (var i = 0; i < image.length; i++) {
                                    log(i.toString() +
                                        "Image" +
                                        image[i].path.toString());
                                    String url = await uploadImage
                                        .uploadImage(File(image[i].path));
                                    list.add(url);
                                  }
                                  if (list.isEmpty) {
                                    return;
                                  }

                                  log("Images" + list.toString());

                                  await Get.find<StoryController>()
                                      .createStroy(list);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: Icon(Icons.add, color: Colors.white),
                                  decoration: BoxDecoration(
                                    color: Color(0xffEBE9EC),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Your Status",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : storyController.stories[i - 1].userId!.id !=
                      getIt<CacheManager>().getUserId()
                  ? InkWell(
                      onTap: () {
                        List<String?> list = storyController
                            .stories[i - 1].userStories!
                            .map((e) => e.imageUrl)
                            .toList();
                        log("Story1" +
                            storyController.stories[i - 1].userStories!
                                .toString());
                        log("Story2" + list.toString());
                        ctx!.push(RoutesConstants.userStroies, extra: list);
                      },
                      child: SizedBox(
                        width: 56.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileAvatar(
                              imageUrl: storyController
                                  .stories[i - 1].userId!.profileImageUrl!,
                              size: 56,
                              child: SizedBox.shrink(),
                              borderColor: Color(0xff9f2fe5),
                            ),
                            Text(
                              storyController.stories[i - 1].userId!.name!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000)),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink();
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: storyController.stories.length + 1),
  );
}

Widget suggestion() {
  final HomeController _homeController = Get.find<HomeController>();

  return SizedBox(
    height: 180.h,
    child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              ctx!.push(
                  "${RoutesConstants.userProfile}/${_homeController.suggestedUsers[i].id!}");
            },
            child: Container(
              width: 140.w,
              height: 100.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileAvatar(
                      imageUrl:
                          _homeController.suggestedUsers[i].profileImageUrl!,
                      size: 64,
                      child: SizedBox.shrink(),
                      borderColor: Color(0xffEDEDED)),
                  Text(
                    _homeController.suggestedUsers[i].name!,
                    style: TextStyle(
                        color: Color(0xff050506),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp),
                  ),
                  Text(
                    _homeController.suggestedUsers[i].userName!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xff4A404F)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w.h),
                        color: Color(0xFFAD2EE5)),
                    child: Text(
                      "Catch-up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w.h),
                  color: Color(0xFFEDEDED)),
              padding: EdgeInsets.all(15.w.h),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 5.w));
        },
        itemCount: _homeController.suggestedUsers.length),
  ).marginSymmetric(vertical: 10.h);
}
