import 'dart:io';

import 'package:checkedln/controller/home_controller.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/post_controller.dart';
import '../widget_helper.dart';
import 'post_widget_helper.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostController _postController = Get.find<PostController>();
  String? selected;
  @override
  void initState() {
    // TODO: implement initState
    _postController.pickMultipleImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (s) {
          Get.find<HomeController>().currentBottomIndex.value = 0;
          return;
        },
        child: Scaffold(
          bottomNavigationBar: Obx(() => _postController.isCreatingPost.value
              ? Container(
                  height: 62.h,
                  child: Center(child: CircularProgressIndicator()),
                )
              : InkWell(
                  onTap: () => _postController.createPost(),
                  child: Container(
                    height: 62.h,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    alignment: Alignment.center,
                    child: Text(
                      "Post",
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
          appBar: mainAppBar("Post", [], SizedBox.shrink(), false),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: 130.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _postController.localImagesList.length + 1,
                        itemBuilder: (context, i) {
                          return i == 0
                              ? InkWell(
                                  onTap: () =>
                                      _postController.pickMultipleImages(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      dashPattern: [10, 10],
                                      color: Color(0xffBFB6C3),
                                      padding: EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/add.png",
                                            height: 124.h,
                                            width: 124.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.file(
                                      File(_postController
                                          .localImagesList[i - 1]),
                                      height: 124.h,
                                      width: 124.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                        }),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  userName(_postController.locationController,
                      TextInputType.text, "Location", false),
                  // userName(_postController.friendsController, TextInputType.text,
                  //     "Add Friends", false),
                  _postController.userIds.isEmpty
                      ? SizedBox.shrink()
                      : SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _postController.userIds.length,
                              itemBuilder: ((context, index) {
                                return SizedBox(
                                  height: 30.h,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF5F4F6),
                                            borderRadius:
                                                BorderRadius.circular(15.w)),
                                        child: Text(_postController
                                            .userIds[index].userName!),
                                      ),
                                      Positioned(
                                        bottom: 11,
                                        right: -4,
                                        child: IconButton(
                                            onPressed: () {
                                              _postController.userIds
                                                  .removeAt(index);
                                            },
                                            icon:
                                                Icon(Icons.close, size: 12.sp)),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  addFriendsHelper(_postController.friendsController,
                      TextInputType.text, "Add Friends", false),
                  userName(
                      _postController.descriptionController,
                      TextInputType.text,
                      "Write something.. (Optional)",
                      false),
                ],
              ).marginSymmetric(horizontal: 10.w),
            )),
          ),
        ));
  }
}
