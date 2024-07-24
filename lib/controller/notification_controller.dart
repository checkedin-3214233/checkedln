import 'package:checkedln/res/snakbar.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../models/notification/notification_model.dart';
import '../services/checkIn/check_in_services.dart';
import '../services/notiication/notification_services.dart';

class NotifiacationController extends GetxController {
  var notificationList = <NotificationModel>[].obs;
  var loading = false.obs;
  NotificatioServices notificatioServices = NotificatioServices();
  Future getNotification() async {
    // Call the service to get the notification
    loading(true);
    dio.Response response = await notificatioServices.getAllNotification();
    if (response.statusCode == 200) {
      List list = response.data["data"];
      for (var i = 0; i < list.length; i++) {
        NotificationModel notificationModel =
            NotificationModel.fromJson(list[i]);
        notificationList.add(notificationModel);
        update();
      }
    } else {
      Get.snackbar("Error", "Failed to get notification");
    }
    loading(false);
  }

  acceptInvite(String userId, String eventId) async {
    loading.value = true;
    dio.Response response =
        await CheckInServices().acceptRequest(userId, eventId);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showSnakBar("Success " + response.data["message"]);
    } else {
      showSnakBar("Error " + response.data["message"]);
    }
    loading.value = false;
  }
}
