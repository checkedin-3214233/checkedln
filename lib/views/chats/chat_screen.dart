import 'package:checkedln/controller/chat_controller.dart';
import 'package:checkedln/global_index.dart';
import 'package:checkedln/views/chats/chat_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/home_controller.dart';
import '../../data/injection/dependency_injection.dart';
import '../../services/socket_services.dart';
import '../widget_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController _chatController = Get.find<ChatController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s) {
        Get.find<HomeController>().currentBottomIndex.value = 0;
        ctx!.pop();
        return;
      },
      child: Scaffold(
        appBar: mainAppBar(
            "My Chats",
            [
              Image.asset(
                "assets/images/search.png",
                height: 40.h,
                width: 40.w,
              ).marginOnly(right: 10.w),
            ],
            SizedBox.shrink(),
            false),
        body: SafeArea(
            child: Obx(() => _chatController.isChatLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder(
                    stream: getIt<SocketServices>().onlineUserStream,
                    builder: (context, snapshot) {
                      print(snapshot.data);

                      if (snapshot.hasData) {
                        List<dynamic> onlineUsers =
                            snapshot.data as List<dynamic>;
                        return ListView.builder(
                            itemCount: _chatController.userList.length,
                            itemBuilder: (context, i) {
                              return chatUserTile(i, onlineUsers);
                            }).marginSymmetric(horizontal: 10.w);
                      } else {
                        return ListView.builder(
                            itemCount: _chatController.userList.length,
                            itemBuilder: (context, i) {
                              return chatUserTile(i, []);
                            }).marginSymmetric(horizontal: 10.w);
                      }
                    }))),
      ),
    );
  }
}
