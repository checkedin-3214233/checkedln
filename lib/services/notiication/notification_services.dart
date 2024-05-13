import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../../data/networks/dio_networks.dart';

class NotificatioServices {
  DioNetwork dioNetwork = DioNetwork();

  final String _notification = dotenv.env['NOTIFICATION']!;
  final String _all = dotenv.env["NOTIFICATION_ALL"]!;
  getAllNotification() async {
    try {
      Response response = await dioNetwork.getData(_notification + _all);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
