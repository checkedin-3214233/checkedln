import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_it/get_it.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import '../../data/injection/dependency_injection.dart';
import '../../models/checkIn/event_model.dart';
import '../../services/checkIn/check_in_services.dart';
import '../../services/location/location_service.dart';
import '../../services/upload_image.dart';
import 'check_in_controller.dart';

class CreateCheckInController extends GetxController {
  var address = <GeoCodeResult>[].obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  TextEditingController typeController = TextEditingController();
  TextEditingController checkInNameController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController aboutCheckIn = TextEditingController();
  var bannerImage = "".obs;
  CheckInServices _checkInServices = CheckInServices();

  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController priceController = TextEditingController();
  UploadImage _uploadImage = UploadImage();
  var isImageUploading = false.obs;
  var isCreatingEvent = false.obs;
  validate() async {
    isCreatingEvent.value = true;

    if (typeController.text.isEmpty) {
      Get.rawSnackbar(message: "Type is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (bannerImage.value.isEmpty) {
      Get.rawSnackbar(message: "Banner Image is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (startDateTime.text.isEmpty) {
      Get.rawSnackbar(message: "Start Date is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (endDateTime.text.isEmpty) {
      Get.rawSnackbar(message: "End Date is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (startTime.text.isEmpty) {
      Get.rawSnackbar(message: "Start Time  is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (endTime.text.isEmpty) {
      Get.rawSnackbar(message: "End Time is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (checkInNameController.text.isEmpty) {
      Get.rawSnackbar(message: "Event Name  is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (location.text.isEmpty) {
      Get.rawSnackbar(message: "Event Venue  is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (aboutCheckIn.text.isEmpty) {
      Get.rawSnackbar(message: "About Check In is required");
      isCreatingEvent.value = false;
      return false;
    }
    if (latitude.value == 0.0 && longitude.value == 0.0) {
      Coordinates coordinates =
          await getIt<LocationService>().getCoordinates(location.text);
      if (coordinates.latitude == null && coordinates.longitude == null) {
        Get.rawSnackbar(message: "Location Not Found");
        isCreatingEvent.value = false;
        return false;
      }

      latitude.value = coordinates.latitude!;
      longitude.value = coordinates.longitude!;
    }
    return true;
  }

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

  createEvent() async {
    if (await validate()) {
      isCreatingEvent.value = true;

      dio.Response response = await _checkInServices.createEvent(
          typeController.text,
          bannerImage.value,
          checkInNameController.text,
          getDateTime(startDateTime.text, startTime.text),
          getDateTime(endDateTime.text, endTime.text),
          location.text,
          latitude.value,
          longitude.value,
          double.parse(
              !priceController.text.isEmpty ? priceController.text : "0.0"),
          aboutCheckIn.text);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.rawSnackbar(message: "Event Created Succesfully");
        EventModel eventModel = EventModel.fromJson(response.data["event"]);
        Get.find<CheckInController>().upcomingEvents.add(eventModel);
        Get.find<CheckInController>().update();

        update();
        getIt<LocationService>().getNearbyEvents();
      }
      isCreatingEvent.value = false;

      Navigator.pop(Get.context!);
    }
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

  searchAddress() async {
    try {
      GeocodeResponse? response =
          await MapmyIndiaGeoCoding(address: location.text, itemCount: 20)
              .callGeocoding();
      if (response != null &&
          response.results != null &&
          response.results!.length > 0) {
        address.clear();
        address.value = response.results!;
        update();
      }
    } catch (e) {
      if (e is PlatformException) {
        log(e.message.toString());
      }
    }
  }
}
