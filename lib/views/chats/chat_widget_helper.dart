import 'package:checkedln/controller/chat_controller.dart';
import 'package:checkedln/global_index.dart';
import 'package:checkedln/models/userChat/userChatModel.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/injection/dependency_injection.dart';
import '../../models/user/userModel.dart';
import '../../res/colors/routes/route_constant.dart';
import '../../services/socket_services.dart';
import 'user_chat_screen.dart';

Widget chatUserTile(int i, List<dynamic> onlineUsers) {
  ChatController _chatController = Get.find<ChatController>();
  return StreamBuilder(
      stream: _chatController.userStream,
      builder: (context, snapshot) {
        return InkWell(
          onTap: () {
            _chatController.backUserChat(i);
            ctx!.push(
                "${RoutesConstants.userChatScreen}/${_chatController.userList[i].value.users!.userName}/${_chatController.userList[i].value.users!.id}",
                extra: _chatController
                        .userList[i].value.users!.profileImageUrl.isEmpty
                    ? "https://via.placeholder.com/150"
                    : _chatController.userList[i].value.users!.profileImageUrl);
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 20, top: i == 0 ? 20 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                      imageUrl: _chatController
                              .userList[i].value.users!.profileImageUrl ??
                          "",
                      size: 48,
                      child: onlineUsers.contains(
                              _chatController.userList[i].value.users!.id)
                          ? Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff0FE16D),
                              ),
                            )
                          : SizedBox.shrink(),
                      borderColor: Colors.white,
                    ).marginOnly(right: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _chatController.userList[i].value.users!.userName ??
                              "",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _chatController
                                  .userList[i].value.lastMessage!.message ??
                              "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff797C7B),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('hh:mm a')
                          .format(_chatController.userList[i].value.lastSeen!
                              .toLocal())
                          .toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff797C7B),
                      ),
                    ),
                    _chatController.userList[i].value.totalUnreadMessage == 0
                        ? SizedBox.shrink()
                        : Container(
                            width: 22.w,
                            alignment: Alignment.center,
                            child: Text(
                              _chatController
                                      .userList[i].value.totalUnreadMessage
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            height: 22.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffF04A4C),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

AppBar userChatAppBar(String userId, String userName, String profileImageUrl) {
  return AppBar(
    backgroundColor: Color(0xffF3F3F3),
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileAvatar(
          imageUrl: profileImageUrl ?? "https://via.placeholder.com/150",
          size: 48,
          child: StreamBuilder(
              stream: getIt<SocketServices>().onlineUserStream,
              builder: (context, snapshot) {
                print(snapshot.data);

                if (snapshot.hasData) {
                  List<dynamic> onlineUsers = snapshot.data as List<dynamic>;
                  return onlineUsers.contains(userId)
                      ? Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff0FE16D),
                          ),
                        )
                      : SizedBox.shrink();
                }
                return SizedBox.shrink();
              }),
          borderColor: Colors.white,
        ).marginOnly(right: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName ?? "",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff050506)),
            ),
            StreamBuilder(
                stream: getIt<SocketServices>().onlineUserStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> onlineUsers = snapshot.data as List<dynamic>;
                    return onlineUsers.contains(userId)
                        ? Text(
                            "Active Now",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6A5C70),
                            ),
                          )
                        : SizedBox.shrink();
                  }
                  return SizedBox.shrink();
                }),
          ],
        )
      ],
    ),
    leading: InkWell(
      onTap: () {
        ctx!.pop();
      },
      child: Image.asset(
        "assets/images/back_white.png",
        height: 40.h,
        width: 40.w,
      ),
    ),
    actions: [
      Image.asset(
        "assets/images/menu_white.png",
        height: 40.h,
        width: 40.w,
      ).marginOnly(right: 10.w),
    ],
  );
}

Widget chatTextBox(String reciverId) {
  ChatController _chatController = Get.find<ChatController>();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F7F8), // Background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _chatController.messageController,
                onFieldSubmitted: (value) async {
                  await _chatController.sendMessage(reciverId, value, "chat");
                },
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter text here', // Placeholder text
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.mic, color: Colors.grey), // Microphone icon
            SizedBox(width: 4.0),
            Icon(Icons.push_pin, color: Colors.grey), // Pin icon
          ],
        ),
      ),
    ),
  );
}
