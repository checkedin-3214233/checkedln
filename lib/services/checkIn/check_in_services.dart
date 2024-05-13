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

  getEventById(String id)async{
    try {
      Response response = await dioNetwork.getData(_event+"/${id}", );
      print(response);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
