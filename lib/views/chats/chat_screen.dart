import 'package:checkedln/views/chats/chat_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../widget_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s) {
        Get.find<HomeController>().currentBottomIndex.value = 0;
        return;
      },
      child: Scaffold(
        appBar: mainAppBar("My Chats"),
        body: SafeArea(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) {
                  return chatUserTile(i);
                }).marginSymmetric(horizontal: 10.w)),
      ),
    );
  }
}
