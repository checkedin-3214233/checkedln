import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:checkedln/controller/chat_controller.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/views/chats/chat_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/injection/dependency_injection.dart';
import '../../data/local/cache_manager.dart';
import '../profiles/profile_avatar.dart';

class UserChatScreen extends StatefulWidget {
  UserModel? userModel;
  UserChatScreen({super.key, required this.userModel});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  ChatController _chatController = Get.find<ChatController>();
  CacheManager cacheManager = getIt<CacheManager>();

  @override
  void initState() {
    _chatController.getMessages(widget.userModel!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: userChatAppBar(widget.userModel!),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: chatTextBox(widget.userModel!.id!)),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/chat_star.png"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text("1st Shared Moment:",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffF4E4FC))),
                  ],
                ),
                Text("Arijit Singh Concert, June 2024",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFAF1FD),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xff5227CD),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.w.h),
                    bottomRight: Radius.circular(20.w.h)),
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Color(0xffAD2EE5), width: 1.0))),
          ),
          Expanded(
            child: Obx(() => _chatController.isMessageLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    controller: _chatController.scrollController,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: _chatController
                                    .messageList[i].value.messageType ==
                                "date"
                            ? DateChip(
                                color: Color(0xffF8F7F8),
                                date: _chatController
                                    .messageList[i].value.createdAt,
                              )
                            : Column(
                                crossAxisAlignment: (cacheManager.getUserId() ==
                                        _chatController
                                            .messageList[i].value.senderId)
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  (cacheManager.getUserId() !=
                                          _chatController
                                              .messageList[i].value.senderId)
                                      ? Row(
                                          children: [
                                            ProfileAvatar(
                                              imageUrl: widget
                                                  .userModel!.profileImageUrl!,
                                              size: 32,
                                              child: SizedBox.shrink(),
                                            ).marginOnly(right: 2.w),
                                            Text(
                                              widget.userModel!.userName!,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff050506)),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  BubbleNormal(
                                    tail: true,
                                    text: _chatController
                                        .messageList[i].value.message!,
                                    isSender: (cacheManager.getUserId() ==
                                            _chatController
                                                .messageList[i].value.senderId)
                                        ? true
                                        : false,
                                    color: Color((cacheManager.getUserId() ==
                                            _chatController
                                                .messageList[i].value.senderId)
                                        ? 0xFFAD2EE5
                                        : 0xffF7EFFA),
                                    textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: (cacheManager.getUserId() ==
                                              _chatController.messageList[i]
                                                  .value.senderId)
                                          ? Colors.white
                                          : Color(0xff28222A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('hh:mm a')
                                        .format(_chatController
                                            .messageList[i].value.createdAt!
                                            .toLocal())
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff85738C),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ).marginOnly(
                                      top: 1.h,
                                      bottom: 1.h,
                                      left: (cacheManager.getUserId() ==
                                              _chatController.messageList[i]
                                                  .value.senderId)
                                          ? 0
                                          : 18.w,
                                      right: (cacheManager.getUserId() ==
                                              _chatController.messageList[i]
                                                  .value.senderId)
                                          ? 18.w
                                          : 0),
                                ],
                              ),
                      );
                    },
                    itemCount: _chatController.messageList.length,
                  )),
          )
        ],
      )),
    );
  }
}
