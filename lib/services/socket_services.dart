import 'dart:async';

import 'package:checkedln/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServices {
  IO.Socket? socket;
  static StreamController<List<dynamic>> _onlineUserStreamController =
      StreamController<List<dynamic>>.broadcast();

  static List<dynamic> _onlineUserData = [];
  Stream<List<dynamic>> get onlineUserStream =>
      _onlineUserStreamController.stream;
  void connect() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    //final wsUrl = Uri.parse('wss://chatapp-env.eba-qhffm2xc.ap-south-1.elasticbeanstalk.com/');

    socket = IO.io("https://checkedln-server.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'query': {"userId": instance.getString("userId")}
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
    socket!.on('getOnlineUsers', (data) {
      _onlineUserData = data; // Add message to list
      _onlineUserStreamController.add(List.from(_onlineUserData));
      print(_onlineUserStreamController);
    });
    Get.find<ChatController>().receiveChats();
  }
}
