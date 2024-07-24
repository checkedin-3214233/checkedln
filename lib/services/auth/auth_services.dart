import 'dart:developer';

import 'package:checkedln/services/notiication/one_signal_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/injection/dependency_injection.dart';
import '../../data/local/cache_manager.dart';
import '../../data/networks/dio_networks.dart';

class AuthServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _auth = dotenv.env['AUTH']!;
  final String _register = dotenv.env['REGISTER']!;
  final String _checkUser = dotenv.env['CHECK_USER']!;
  final String _login = dotenv.env['LOGIN']!;
  final String _sendOtp = dotenv.env['SEND_OTP']!;
  final String _verifyOtp = dotenv.env['VERIFY_OTP']!;

  Future<dynamic> checkUser(String number) async {
    log(_auth + _checkUser);
    Map<String, String> data = {"number": number};
    try {
      Response response =
          await dioNetwork.postData(_auth + _checkUser, data: data);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> sendOtp(String number) async {
    Map<String, String> data = {"number": number};
    try {
      Response response =
          await dioNetwork.postData(_auth + _sendOtp, data: data);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> verifyOtp(String number, String otp) async {
    Map<String, String> data = {"number": number, "otp": otp};
    try {
      Response response =
          await dioNetwork.postData(_auth + _verifyOtp, data: data);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> loginUser(String number) async {
    await getIt<OneSignalServices>().setNotificationToken();
    Map<String, String> data = {
      "phone": number,
      "notificationToken": getIt<CacheManager>().getNotificationSubscriptionId()
    };
    try {
      Response response = await dioNetwork.postData(_auth + _login, data: data);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> signup(
      String number,
      String userName,
      String name,
      String profileImageUrl,
      DateTime dateOfBirth,
      String gender,
      List<String> images,
      String bio) async {
    await getIt<OneSignalServices>().setNotificationToken();

    Map<String, dynamic> data = {
      "name": name,
      "userName": userName,
      "phone": number,
      "profileImageUrl": profileImageUrl,
      "notificationToken":
          getIt<CacheManager>().getNotificationSubscriptionId(),
      "dateOfBirth": dateOfBirth.toUtc().toString(),
      "gender": gender,
      "userImages": images,
      "bio": bio
    };

    log(data.toString());

    try {
      Response response =
          await dioNetwork.postData(_auth + _register, data: data);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
