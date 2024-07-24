import 'dart:developer';

import 'package:checkedln/models/checkIn/buddy_checkin.dart';
import 'package:checkedln/models/checkIn/event_model.dart';
import 'package:checkedln/models/checkIn/home_event_model.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/res/snakbar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../services/checkIn/check_in_services.dart';
import '../../views/dialog/dialog_helper.dart';

class CheckInController extends GetxController {
  CheckInServices _checkInServices = CheckInServices();
  var upcomingEvents = <EventModel>[].obs;
  var upcomingEventsBackcup = <EventModel>[].obs;
  var pastEvent = <EventModel>[].obs;
  var pastEventBackcup = <EventModel>[].obs;
  var nearByEvents = <HomeEventModel>[].obs;
  var tab = 0.obs;
  var popularEvents = <HomeEventModel>[].obs;
  var liveEvents = <HomeEventModel>[].obs;
  var friendsCheckIn = <BuddyCheckIn>[].obs;
  var isUpcomingLoading = false.obs;
  var isPastEventsLoading = false.obs;
  var isNearByEventsLoading = false.obs;
  var searchEvents = TextEditingController();
  getdetails() {
    if (tab.value == 0) {
      upcomingEvents.value = upcomingEventsBackcup;
    } else {
      pastEvent.value = pastEventBackcup;
    }
  }

  search(String text) {
    if (tab.value == 0) {
      if (text.isEmpty) {
        searchEvents.clear();

        getdetails();
      } else {
        final suggestion = upcomingEventsBackcup.where((element) {
          final title = element.checkInName!.toLowerCase();
          final input = text.toLowerCase();
          return title.contains(input);
        }).toList();

        upcomingEvents.value = suggestion;
      }
    } else {
      if (text.isEmpty) {
        searchEvents.clear();

        getdetails();
      } else {
        final suggestion = pastEventBackcup.where((element) {
          final title = element.checkInName!.toLowerCase();
          final input = text.toLowerCase();
          return title.contains(input);
        }).toList();

        pastEvent.value = suggestion;
      }
    }
  }

  getMutuals(List<String> list1, List<dynamic> list2) {
    List<String> newList2 = [];

    for (var element in list2) {
      newList2.add(element);
    }
    Set<String> set1 = list1.toSet();
    Set<String> set2 = newList2.toSet();

    // Find common elements
    Set<String> commonElements = set1.intersection(set2);

    // Convert the set back to a list if needed
    List<String> commonList = commonElements.toList();

    print('Common elements: $commonList');
    return commonList.length;
  }

  Future getPastEvent() async {
    isPastEventsLoading.value = true;
    dio.Response response = await _checkInServices.getPastEvents();
    pastEvent.clear();
    pastEventBackcup.clear();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["events"];
      for (int i = 0; i < events.length; i++) {
        EventModel eventModel = EventModel.fromJson(events[i]);
        pastEvent.add(eventModel);
        pastEventBackcup.add(eventModel);
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

  deleteEvent(String id) async {
    DialogHelper.showLoading("Deleting Event");
    try {
      dio.Response response = await _checkInServices.deleteEvent(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnakBar("Event Deleted Succesfully");
        DialogHelper.hideLoading();
        return true;
      }
      DialogHelper.hideLoading();
      return false;
    } catch (e) {
      DialogHelper.hideLoading();
      return false;
    }
  }

  updateEvent(String id, var body) async {
    try {
      dio.Response response = await _checkInServices.updateEvent(id, body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnakBar("Event Updated Succesfully");
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  getUpcomingEvent() async {
    isUpcomingLoading.value = true;
    upcomingEvents.clear();
    upcomingEventsBackcup.clear();
    dio.Response response = await _checkInServices.getUpcomingEvents();
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["events"];
      for (int i = 0; i < events.length; i++) {
        EventModel eventModel = EventModel.fromJson(events[i]);
        upcomingEvents.add(eventModel);
        upcomingEventsBackcup.add(eventModel);
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

  getPopularEvents(double lat, double long) async {
    popularEvents.clear();
    update();
    dio.Response response = await _checkInServices.getPopularEvents(lat, long);
    print("Krish ${response.data}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data["events"];
      for (int i = 0; i < events.length; i++) {
        HomeEventModel eventModel = HomeEventModel.fromJson(events[i]);
        popularEvents.add(eventModel);
        update();
      }
    }
  }

  Future getFriendsCheckIn() async {
    friendsCheckIn.clear();
    dio.Response response = await _checkInServices.getFriendsCheckin();
    log("FriendsEvent ${response.data}");
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List events = response.data;
      log("FriendsEvent ${events.length}");
      for (int i = 0; i < events.length; i++) {
        log("FriendsEvent ${events[i]}");
        BuddyCheckIn eventModel = BuddyCheckIn.fromJson(events[i]);
        log("FriendsEvent1 ${eventModel}");
        friendsCheckIn.add(eventModel);

        log("FriendsEvent ${friendsCheckIn}");
      }
      log("FriendsEvent ${friendsCheckIn}");
    }
    log("FriendsEvent ${friendsCheckIn}");
  }

  postLiveEvents(double lat, double long) async {
    dio.Response response = await _checkInServices.getLiveEvents(lat, long);
    log("LiveEvents ${response.data}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      liveEvents.clear();
      List list = response.data["nearbyEvents"];
      for (int i = 0; i < list.length; i++) {
        HomeEventModel eventModel = HomeEventModel.fromJson(list[i]);
        liveEvents.add(eventModel);
        update();
      }
    }
  }

  changeEventStatus(String active, String id) async {
    dio.Response response = await _checkInServices.changeStatus(id, active);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
