import 'package:checkedln/models/checkIn/info_event_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../models/checkIn/main_event_model.dart';
import '../../services/checkIn/check_in_services.dart';

class GetCheckInController extends GetxController{
  var isLoading = false.obs;
  Rx<MainEventModel>? eventModel;
  CheckInServices _checkInServices = CheckInServices();
  GetCheckInController(String id){
    getEventId(id);
  }
  getEventId(String id)async{
    isLoading.value = true;
    dio.Response response = await _checkInServices.getEventById(id);
    if(response.statusCode==200||response.statusCode==201){
      MainEventModel eventModel = MainEventModel.fromJson(response.data);
      this.eventModel = eventModel.obs;
      update();

    }
    isLoading.value = false;

  }
}