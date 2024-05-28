import 'package:checkedln/models/checkIn/event_model.dart';
import 'package:checkedln/models/checkIn/home_event_model.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../services/checkIn/check_in_services.dart';

class CheckInController extends GetxController {
  CheckInServices _checkInServices = CheckInServices();
  var upcomingEvents = <EventModel>[].obs;
  var pastEvent = <EventModel>[].obs;
  var nearByEvents = <HomeEventModel>[].obs;
  var isUpcomingLoading = false.obs;
  var isPastEventsLoading = false.obs;
  var isNearByEventsLoading = false.obs;

  getPastEvent() async {
    isPastEventsLoading.value = true;
    dio.Response response = await _checkInServices.getPastEvents();
    pastEvent.clear();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["events"];
      for (int i = 0; i < events.length; i++) {
        EventModel eventModel = EventModel.fromJson(events[i]);
        pastEvent.add(eventModel);
        update();
      }
    }
    isPastEventsLoading.value = false;
  }

  getSharebleLink(String id) async {
    dio.Response response = await _checkInServices.getShareLink(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "${dotenv.env["BASE_URL"]!}" +
          "shareCheckin/" +
          response.data["shareEvent"]["_id"];
    }
    return "";
  }

  getUpcomingEvent() async {
    isUpcomingLoading.value = true;
    upcomingEvents.clear();
    dio.Response response = await _checkInServices.getUpcomingEvents();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["events"];
      for (int i = 0; i < events.length; i++) {
        EventModel eventModel = EventModel.fromJson(events[i]);
        upcomingEvents.add(eventModel);
        update();
      }
    }
    isUpcomingLoading.value = false;
  }

  getDateTime(String dateString, String timeString) {
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

  getNearByEvents(double lat, double long) async {
    isNearByEventsLoading.value = true;
    nearByEvents.clear();
    update();
    dio.Response response = await _checkInServices.getNearByEvents(lat, long);
    print("Krish ${response.data}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["nearbyEvents"];
      for (int i = 0; i < events.length; i++) {
        HomeEventModel eventModel = HomeEventModel.fromJson(events[i]);
        nearByEvents.add(eventModel);
        update();
      }
    }
    isNearByEventsLoading.value = false;
  }
}
