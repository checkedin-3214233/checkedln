import 'dart:developer';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../services/notiication/one_signal_services.dart';
import 'package:get/get.dart';

import '../data/injection/dependency_injection.dart';
import '../data/local/cache_manager.dart';
import '../views/auth/authentication_screen.dart';
import '../views/home/home.dart';

class SplashController extends GetxController {
  SplashController() {
    navigate();
    log("SplashController");
  }
  navigate() async {
    bool? loggedIn = await getIt<CacheManager>().getLoggedIn();
    log(loggedIn.toString());
    if (loggedIn!) {
      Get.context?.go(RoutesConstants.home);
    } else {
      Get.context?.go(RoutesConstants.login);
    }
  }
}
