import 'dart:io';

import 'package:checkedln/models/checkIn/event_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/checkIn/check_in_services.dart';
import '../services/upload_image.dart';

class CheckInController extends GetxController{
  CheckInServices _checkInServices = CheckInServices();
  var upcomingEvents = <EventModel>[].obs;
  var pastEvent =<EventModel>[].obs;
  var isUpcomingLoading = false.obs;
  var isPastEventsLoading = false.obs;
  TextEditingController typeController = TextEditingController();
  TextEditingController checkInNameController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController aboutCheckIn = TextEditingController();
  var bannerImage="".obs;
  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime=TextEditingController();
  TextEditingController startTime=TextEditingController();
  TextEditingController endTime=TextEditingController();
  UploadImage _uploadImage = UploadImage();

  var isImageUploading = false.obs;
  var isCreatingEvent = false.obs;
  Future<String> uploadImage(File file) async {
    isImageUploading.value = true;
    try {
      String path = await _uploadImage.uploadImage(file);
      isImageUploading.value = false;
      return path;
    } catch (e) {
      isImageUploading.value = false;

      return "";
    }
  }

  getPastEvent()async{
    isPastEventsLoading.value = true;
    dio.Response response = await _checkInServices.getPastEvents();
    if(response.statusCode==200||response.statusCode==201){
      List events = response.data["events"];
      for(int i =0;i<events.length;i++){
        EventModel eventModel = EventModel.fromJson(events[i]);
        pastEvent.add(eventModel);
        update();
      }
    }
    isPastEventsLoading.value = false;
  }
  getUpcomingEvent()async{
    isUpcomingLoading.value = true;

    dio.Response response = await _checkInServices.getUpcomingEvents();
    if(response.statusCode==200||response.statusCode==201){
      List events = response.data["events"];
      for(int i =0;i<events.length;i++){
        EventModel eventModel = EventModel.fromJson(events[i]);
        upcomingEvents.add(eventModel);
        update();
      }
    }
    isUpcomingLoading.value = false;

  }

  validate(){
    if(typeController.text.isEmpty){
      Get.rawSnackbar(message: "Type is required");
      return false;
    }
    if(bannerImage.value.isEmpty){
      Get.rawSnackbar(message: "Banner Image is required");
      return false;
    }
    if(startDateTime.text.isEmpty){
      Get.rawSnackbar(message: "Start Date is required");
      return false;
    }
    if(endDateTime.text.isEmpty){
      Get.rawSnackbar(message: "End Date is required");
      return false;
    }
    if(startTime.text.isEmpty){
      Get.rawSnackbar(message: "Start Time  is required");
      return false;
    }
    if(endTime.text.isEmpty){
      Get.rawSnackbar(message: "End Time is required");
      return false;
    }
    if(checkInNameController.text.isEmpty){
      Get.rawSnackbar(message: "Event Name  is required");
      return false;
    }
    if(location.text.isEmpty){
      Get.rawSnackbar(message: "Event Venue  is required");
      return false;
    }
    if(aboutCheckIn.text.isEmpty){
      Get.rawSnackbar(message: "About Check In is required");
      return false;
    }
    return true;
  }
  createEvent()async{
  if(validate()){
    isCreatingEvent.value = true;

    dio.Response response = await _checkInServices.createEvent(typeController.text, bannerImage.value, checkInNameController.text, getDateTime(startDateTime.text,startTime.text), getDateTime(endDateTime.text,endTime.text), location.text, aboutCheckIn.text);
    if(response.statusCode==200||response.statusCode==201){
Get.rawSnackbar(message: "Event Created Succesfully");
EventModel eventModel = EventModel.fromJson(response.data["event"]);
upcomingEvents.add(eventModel);
update();
    }
    isCreatingEvent.value = false;

    Navigator.pop(Get.context!);
  }
  }
  getDateTime(String dateString,String timeString){
    DateTime date = DateTime.parse(dateString);

    // Parse time string into TimeOfDay
    List<String> timeComponents = timeString.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);

    // Combine date and time to create DateTime
    DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return combinedDateTime;
  }
}
