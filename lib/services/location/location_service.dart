import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../controller/checkin/check_in_controller.dart';

class LocationService{
  Location location = new Location();
  GeoCode geoCode = GeoCode();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;


  checkLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
  }

  getLocation()async{
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    Get.find<CheckInController>().getNearByEvents(_locationData!.latitude!,_locationData!.longitude!);

    print(_locationData);

    //getLocationContinous();
  }

getLocationContinous(){
  location.onLocationChanged.listen((LocationData currentLocation) {
    // Use current location
    Get.find<CheckInController>().getNearByEvents(currentLocation.latitude!,currentLocation.longitude!);

  });
}

getNearbyEvents(){

}

getCoordinates(String address)async{
  try {
    Coordinates coordinates = await geoCode.forwardGeocoding(
        address:address);

    print("Latitude: ${coordinates.latitude}");
    print("Longitude: ${coordinates.longitude}");
    return coordinates;
  } catch (e) {
    print(e);
    return null;
  }

}

}