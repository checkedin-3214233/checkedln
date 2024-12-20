import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/app_exceptions.dart';

class CacheManager {
  static SharedPreferences? _instance;
  final String _accessToken = "accessToken"; // New field
  final String _refreshToken = "refreshToken"; // New field
  final String _loggedInString = "loggedIn";
  final String _userId = "userId";
  final String _notificationSubscriptionId = "notificationSubscriptionId";
  Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
    setMapMyIndia();

  }
  setMapMyIndia()async{
   await MapmyIndiaAccountManager.setMapSDKKey(dotenv.env["MAP_MY_INDIA_ACCESS_TOKEN_KEY"]!);
   await MapmyIndiaAccountManager.setRestAPIKey(dotenv.env["MAP_MY_INDIA_REST_API_KEY"]!);
   await MapmyIndiaAccountManager.setAtlasClientId(dotenv.env["MAP_MY_INDIA_ATLAS_CLIENT_ID"]!);
   await MapmyIndiaAccountManager.setAtlasClientSecret(dotenv.env["MAP_MY_INDIA_ATLAS_CLIENT_SECRET"]!);
  }

  Future<void> setUserId(String token) async {
    await _instance!.setString(_userId, token);
  }

  Future<void> setNotificationSubscription(String value) async {
    await _instance!.setString(_notificationSubscriptionId, value);
  }

  Future<void> setLoggedIn([bool state = true]) async {
    print(state);
    await _instance!.setBool(_loggedInString, state);
    getLoggedIn();
  }

  Future<void> setToken(String accessToken, String refreshToken) async {
    await _instance!.setString(_accessToken, accessToken);
    await _instance!.setString(_refreshToken, refreshToken);
    getAccessToken();
  }

  String getUserId() {
    String? userId = _instance!.getString(_userId);
    if (userId != null) {
      return userId;
    } else {
      throw CacheExceptions(000, message: "Access token not found");
    }
  }

  String getAccessToken() {
    String? token = _instance!.getString(_accessToken);
    if (token != null) {
      return token;
    } else {
      throw CacheExceptions(000, message: "Access token not found");
    }
  }

  String getNotificationSubscriptionId() {
    String? id = _instance!.getString(_notificationSubscriptionId);
    log("Notification Token $id");
    return id!;
  }

  bool? getLoggedIn() {
    bool login = _instance!.getBool(_loggedInString) ?? false;

    return login;
  }

  String getRefreshToken() {
    String? token = _instance!.getString(_refreshToken);
    if (token != null) {
      return token;
    } else {
      throw CacheExceptions(000, message: "Refresh token not found");
    }
  }
}
