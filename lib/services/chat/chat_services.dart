import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class ChatServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _messages = dotenv.env['MESSAGES']!;
  final String _sendMessages = dotenv.env['SEND_MESSAGE']!;

  Future<dynamic> getChatList() async {
    try {
      Response response = await dioNetwork.getData(_messages);
      print("KGF" + response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getMessages(String reciverUserId) async {
    try {
      Response response = await dioNetwork.getData(_messages + reciverUserId);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  sendMessage(String reciverUserId, String message, String type) async {
    Map<String, String> data = {"message": message, "type": type};

    try {
      Response response = await dioNetwork
          .postData(_messages + _sendMessages + reciverUserId, data: data);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
