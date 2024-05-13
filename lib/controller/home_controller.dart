import 'package:checkedln/services/location/location_service.dart';
import 'package:get/get.dart';

import '../data/injection/dependency_injection.dart';

class HomeController extends GetxController {
  var currentBottomIndex = 0.obs;
  HomeController(){

    getLocation();
  }
  getLocation()async{
    await getIt<LocationService>().checkLocation();
    await getIt<LocationService>().getLocation();
  }
  var bottomNavigationJson = {
    "items": [
      {
        "icon": "assets/images/home.png",
        "selectedIcon": "assets/images/homeSelected.png",
        "title": "Home"
      },
      {
        "icon": "assets/images/chat.png",
        "selectedIcon": "assets/images/chat.png",
        "title": "Chat"
      },
      {
        "icon": "assets/images/addPost.png",
        "selectedIcon": "assets/images/addPost.png",
        "title": "Add Post"
      },
      {
        "icon": "assets/images/checkIn.png",
        "selectedIcon": "assets/images/checkIn.png",
        "title": "Check In"
      },
      {
        "icon": "assets/images/profile.png",
        "selectedIcon": "assets/images/profileSelected.png",
        "title": "Profile"
      }
    ]
  };
}
