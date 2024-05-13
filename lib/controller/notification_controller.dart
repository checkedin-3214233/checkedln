import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../models/notification/notification_model.dart';
import '../services/notiication/notification_services.dart';

class NotifiacationController extends GetxController {
  var notificationList = <NotificationModel>[].obs;
  var loading = false.obs;
  NotificatioServices notificatioServices = NotificatioServices();
  getNotification() async {
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
}
