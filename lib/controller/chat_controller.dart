import 'dart:async';
import 'dart:developer';

import 'package:checkedln/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../data/injection/dependency_injection.dart';
import '../data/local/cache_manager.dart';
import '../models/message/messageModel.dart';
import '../models/userChat/userChatModel.dart';
import '../services/socket_services.dart';

class ChatController extends GetxController {
  var isChatLoading = false.obs;
  var isMessageLoading = false.obs;
  TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  static StreamController<List<dynamic>> _userStreamController =
      StreamController<List<dynamic>>.broadcast();

  Stream<List<dynamic>> get userStream => _userStreamController.stream;
  var userList = [].obs;
  var messageList = [].obs;
  ChatServices _chatServices = ChatServices();
  getChats() async {
    isChatLoading.value = true;
    dio.Response response = await _chatServices.getChatList();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<UserChatModel> users = [];
      for (var user in response.data["allUsers"]) {
        users.add(UserChatModel.fromJson(user));
      }
      for (var user in users) {
        userList.add(user.obs);
      }
    }
    _userStreamController.add(List.from(userList));

    getIt<SocketServices>().connect();

    isChatLoading.value = false;
  }

  backUserChat(int i) {
    userList[i].value = UserChatModel(
        users: userList[i].value.users,
        lastMessage: userList[i].value.lastMessage,
        totalUnreadMessage: 0,
        lastSeen: userList[i].value.lastMessage.createdAt,
        id: userList[i].value.id);

    update();
    _userStreamController.add(List.from(userList));
  }

  receiveChats() {
    getIt<SocketServices>().socket!.on("newMessage", (data) {
      print(data);
      MessageModel messageModel = MessageModel.fromJson(data);
      if (messageModel.senderId != getIt<CacheManager>().getUserId()) {
        messageList.insert(0, messageModel.obs);
        update();
        for (int i = 0; i < userList.length; i++) {
          if (userList[i].value.users!.id == messageModel.senderId) {
            userList[i].value = UserChatModel(
                users: userList[i].value.users,
                lastMessage: messageModel,
                totalUnreadMessage: userList[i].value.totalUnreadMessage + 1,
                lastSeen: messageModel.createdAt,
                id: userList[i].value.id);

            userList.insert(0, userList.removeAt(i));
            update();
            _userStreamController.add(List.from(userList));
          }
        }
      }
    });
  }

  getMessages(String reciverUserId) async {
    isMessageLoading.value = true;

    messageList.clear();
    dio.Response response = await _chatServices.getMessages(reciverUserId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List messages = response.data;
      for (int i = 0; i < messages.length; i++) {
        MessageModel messageModel = MessageModel.fromJson(messages[i]);
        print("${i}${messageModel.message}");
        if (messageList.isNotEmpty) {
          compareDates(
              DateTime.parse(messageModel.createdAt!.toLocal().toString()));
        }

        messageList.insert(0, MessageModel.fromJson(messages[i]).obs);
      }
    }

    isMessageLoading.value = false;
  }

  void scrollToItem(int index) {
    if (!scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut);
    } else {
      scrollController.animateTo(
        index *
            70, // You may need to adjust this value based on your item height
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  sendMessage(String reciverUserId, String message, String type) async {
    messageController.clear();

    dio.Response response =
        await _chatServices.sendMessage(reciverUserId, message, type);
    if (response.statusCode == 200 || response.statusCode == 201) {
      MessageModel messageModel =
          MessageModel.fromJson(response.data["message"]);
      messageList.insert(0, messageModel.obs);

      update();

      log(messageList.toString());
      for (int i = 0; i < userList.length; i++) {
        if (userList[i].value.users!.id == reciverUserId) {
          userList[i].value = UserChatModel(
              users: userList[i].value.users,
              lastMessage: messageModel,
              totalUnreadMessage: 0,
              lastSeen: messageModel.createdAt,
              id: userList[i].value.id);

          update();
          _userStreamController.add(List.from(userList));
        }
      }
      update();
      return response.data;
    }
  }

  compareDates(DateTime newDate) {
    DateTime now = newDate;
    DateTime createdAt = messageList.first.value.createdAt;

    String messageDate = createdAt.toLocal().toString();

    DateTime date = DateTime.parse(messageDate);
    DateTime date1OnlyDate = DateTime(now.year, now.month, now.day);
    DateTime date2OnlyDate = DateTime(date.year, date.month, date.day);

    if (date1OnlyDate.isBefore(date2OnlyDate)) {
      print('date1 is before date2');
    } else if (date1OnlyDate.isAfter(date2OnlyDate)) {
      print('date1 is after date2');
      messageList.insert(
          0,
          MessageModel(
            createdAt: now,
            messageType: "date",
            id: '',
            senderId: '',
            receiverId: '',
            message: '',
            updatedAt: null,
            v: null,
          ).obs);
    } else {
      print('date1 is the same as date2');
    }
  }
}
