import 'package:checkedln/controller/post_controller.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import 'profile_widget_helper.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  PostController _postController = Get.find<PostController>();
  UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _postController.myPost.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F4F6),
                    borderRadius: BorderRadius.circular(16.w.h),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ProfileAvatar(
                                  imageUrl: _userController
                                      .userModel.value!.profileImageUrl!,
                                  size: 24,
                                  child: SizedBox.shrink(),borderColor: Colors.white,),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                _userController.userModel.value!.name!,
                                style: TextStyle(
                                    color: Color(0xff050506),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_vert))
                        ],
                      ),
                      Text(
                        _postController.myPost[i].description!,
                        style: TextStyle(
                            color: Color(0xff28222A),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 183.h,
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w.h),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    _postController.myPost[i].images[0]))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: twoTile("Like",
                                Image.asset("assets/images/like.png"), () {}),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: twoTile("Share",
                                Image.asset("assets/images/share.png"), () {}),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
