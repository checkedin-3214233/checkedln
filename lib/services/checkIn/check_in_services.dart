import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class CheckInServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _event = dotenv.env['EVENT']!;
  final String _upcomingEvent = dotenv.env["UPCOMING_EVENT"]!;
  final String _pastEvent = dotenv.env["PAST_EVENT"]!;
  final String _nearByEvent = dotenv.env["NEARBY_EVENT"]!;
  final String _shareLink = dotenv.env["SHARE_EVENT"]!;
  final String _getEventById = dotenv.env["GET_SHARED_EVENT"]!;
  final String _joinEvent = dotenv.env["JOIN_EVENT"]!;
  final String _requestEvent = dotenv.env["REQUEST_EVENT"]!;
  final String _acceptEvent = dotenv.env["ACCEPT_EVENT"]!;
  final String _popularEvents = dotenv.env["POPULAR_EVENTS"]!;
  final String _friendsCheckin = dotenv.env["FRIENDS_CHECKINS"]!;
  final String _liveEvents = dotenv.env["LIVE_EVENTS"]!;
  final String _changeStatus = dotenv.env["CHANGE_EVENT_STATUS"]!;
  final String _joinEventThemSelf = dotenv.env["JOIN_EVENT_THEMSELF"]!;
  final String _addImages = dotenv.env["ADD_IMAGE"]!;

  changeStatus(String id, String status) async {
    try {
      Response response = await dioNetwork.getData(
        "$_event$_changeStatus/$id/$status",
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getPastEvents() async {
    try {
      Response response = await dioNetwork.getData(_event + _pastEvent);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getSharedEventById(String id) async {
    try {
      Response response = await dioNetwork.getData(_event + _getEventById + id);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getShareLink(String id) async {
    try {
      Response response = await dioNetwork.getData(_event + _shareLink + id);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getUpcomingEvents() async {
    print("Upcoming");
    try {
      Response response = await dioNetwork.getData(_event + _upcomingEvent);
      print("Upcoming");
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getNearByEvents(double lat, double long) async {
    print("getNearByEvents");
    var data = {
      "latitude": lat, // Example latitude
      "longitude": long,
      "maxDistance": 250000
    };
    try {
      Response response =
          await dioNetwork.postData(_event + _nearByEvent, data: data);
      print("NearBy");
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getPopularEvents(double lat, double long) async {
    print("getNearByEvents");
    var data = {
      "latitude": lat, // Example latitude
      "longitude": long,
      "maxDistance": 250000
    };
    try {
      Response response =
          await dioNetwork.postData(_event + _popularEvents, data: data);
      print("Popular");
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getFriendsCheckin() async {
    print("getFriendsEvent");

    try {
      Response response = await dioNetwork.getData(_event + _friendsCheckin);
      print("FriendsEvent");
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getLiveEvents(double lat, double long) async {
    print("getLiveEvents");
    var data = {
      "latitude": lat, // Example latitude
      "longitude": long
    };

    try {
      Response response =
          await dioNetwork.postData(_event + _liveEvents, data: data);
      print("LiveEvents");
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  createEvent(
      String type,
      String bannerImages,
      String checkInName,
      DateTime startDateTime,
      DateTime endDateTime,
      String location,
      double lat,
      double long,
      double price,
      String description) async {
    var data = {
      "type": type,
      "bannerImages": bannerImages,
      "checkInName": checkInName,
      "startDateTime": startDateTime.toUtc().toString(),
      "endDateTime": endDateTime.toUtc().toString(),
      "address": location,
      "description": description,
      "lat": lat,
      "long": long,
      "price": price
    };
    try {
      Response response = await dioNetwork.postData(_event, data: data);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getEventById(String id) async {
    try {
      Response response = await dioNetwork.getData(
        _event + "/${id}",
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  joinEvent(String id, bool isShare) async {
    try {
      Response response = await dioNetwork.getData(
        "$_event${isShare ? _joinEvent : _joinEventThemSelf}$id",
      );
      log("OM" + response.data.toString());
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  requestEvent(String id) async {
    try {
      Response response = await dioNetwork.getData(
        "$_event$_requestEvent$id/requested",
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  acceptRequest(String userId, String eventId) async {
    try {
      Response response = await dioNetwork.getData(
        "$_event$_acceptEvent/$eventId/$userId",
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  deleteEvent(String id) async {
    try {
      Response response = await dioNetwork.deleteData(
        "$_event/$id",
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  updateEvent(String id, var body) async {
    try {
      Response response =
          await dioNetwork.updateDate("$_event/$id", data: body);
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  addImages(String id, List<String> images) async {
    try {
      Response response = await dioNetwork.updateDate(
        "$_event$_addImages$id",
        data: {"images": images},
      );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
