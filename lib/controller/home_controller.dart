import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentBottomIndex = 0.obs;
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
