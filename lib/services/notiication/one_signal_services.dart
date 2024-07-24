
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../data/injection/dependency_injection.dart';
import '../../data/local/cache_manager.dart';


class OneSignalServices {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  BuildContext? _context;
  set context(BuildContext? context) {
    _context = context;
  }
  OneSignalServices(){
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    log("Notification me aa gya");
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.consentRequired(true);
    OneSignal.consentGiven(true);
    OneSignal.initialize("7208b978-7c71-46e4-8cd8-c05b6473ee81");

    OneSignal.Notifications.requestPermission(true);

    OneSignal.User.pushSubscription.addObserver((state) {
      print("OneSignal Krish ${OneSignal.User.pushSubscription.optedIn}");
      print("OneSignal Krish ${OneSignal.User.pushSubscription.id}");
      print("OneSignal Krish ${OneSignal.User.pushSubscription.token}");
      print("OnSignal Krish ${state.current.jsonRepresentation()}");
    });

    hasPermission();

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: ${event.notification.additionalData}');
    });
  }


  Future<void> setUserLogin() async {
    String userId = getIt<CacheManager>().getUserId();
    await OneSignal.login(userId);
    await OneSignal.User.pushSubscription.optIn();
  }

  Future<void> hasPermission() async {
    OneSignal.Notifications.addPermissionObserver((state) {
      if (kDebugMode) {
        print("Has permission $state");
      }

    });
















































  }

  Future<void> setNotificationToken() async {
    print("Krish Notification Token${OneSignal.User.pushSubscription.id.toString()}");
    await getIt<CacheManager>().setNotificationSubscription(
        OneSignal.User.pushSubscription.id.toString());

    OneSignal.User.pushSubscription.addObserver((state) {
      print("OneSignal Krish ${OneSignal.User.pushSubscription.optedIn}");
      print("OneSignal Krish ${OneSignal.User.pushSubscription.id}");
      print("OneSignal Krish ${OneSignal.User.pushSubscription.token}");
      print("OnSignal Krish ${state.current.jsonRepresentation()}");
    });
  }

  void handlePromptForPushPermission() {
    if (kDebugMode) {
      print("Prompting for Permission");
    }
    OneSignal.Notifications.requestPermission(true);
  }

  void handleConsent() {
    if (kDebugMode) {
      print("Setting consent to true");
    }
    OneSignal.consentGiven(true);
  }

  Future<void> handleLogin() async {
    //await OneSignal.login(userId);
    // await OneSignal.User.addAlias("user_id", userId);
  }

  Future<void> handleLogout() async {
    await OneSignal.logout();
    await OneSignal.User.removeAlias("user_id");
  }

  Future<void> handleOptIn() async {
    await OneSignal.User.pushSubscription.optIn();
  }

  Future<void> handleOptOut() async {
    await OneSignal.User.pushSubscription.optOut();
  }
}
