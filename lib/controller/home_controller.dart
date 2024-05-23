import 'package:checkedln/services/location/location_service.dart';
import 'package:get/get.dart';

import '../data/injection/dependency_injection.dart';

class HomeController extends GetxController {
  var currentBottomIndex = 0.obs;
  HomeController() {
    getLocation();
  }
  getLocation() async {
    await getIt<LocationService>().checkLocation();
    await getIt<LocationService>().getLocation();
  }

  var bottomNavigationJson = {
    "items": [
      {
        "icon": "assets/images/home.svg",
        "selectedIcon": "assets/images/homeSelected.svg",
        "title": "Home"
      },
      {
        "icon": "assets/images/chat.svg",
        "selectedIcon": "assets/images/chat.svg",
        "title": "Chat"
      },
      {
        "icon": "assets/images/addPost.svg",
        "selectedIcon": "assets/images/addPost.svg",
        "title": "Add Post"
      },
      {
        "icon": "assets/images/checkIn.svg",
        "selectedIcon": "assets/images/checkIn.svg",
        "title": "Check In"
      },
      {
        "icon": "assets/images/profile.svg",
        "selectedIcon": "assets/images/profileSelected.svg",
        "title": "Profile"
      }
    ]
  };
}
