import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../models/checkIn/profile_checkin.dart';
import '../services/user/userServices.dart';

class MyCheckInController extends GetxController {
  var isLoading = false.obs;
  RxList<ProfileCheckIn> checkin = <ProfileCheckIn>[].obs;
  UserServices _userServices = UserServices();
  getCheckin(String id) async {
    isLoading(true);
    try {
      dio.Response response = await _userServices.getEventByUserId(id);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["success"]) {
        List list = response.data["events"];
        print(list);
        checkin.clear();
        for (int i = 0; i < list.length; i++) {
          ProfileCheckIn checkInModel = ProfileCheckIn.fromJson(list[i]);
          checkin.add(checkInModel);
        }
      }
      print(checkin);
    } catch (e) {}

    isLoading(false);
  }
}
