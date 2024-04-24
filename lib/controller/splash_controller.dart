import 'dart:developer';

import 'package:get/get.dart';

import '../data/injection/dependency_injection.dart';
import '../data/local/cache_manager.dart';
import '../views/auth/authentication_screen.dart';
import '../views/home/home.dart';

class SplashController extends GetxController{
  SplashController(){
    navigate();
  }
  navigate() async{
    bool? loggedIn =  await getIt<CacheManager>().getLoggedIn();
log(loggedIn.toString());
    Future.delayed(const Duration(seconds: 2), () {
      if(loggedIn!){
        Get.offAll(() => const Home());
      }else{
        Get.offAll(const AuthenticationScreen());

      }
    });
  }
}