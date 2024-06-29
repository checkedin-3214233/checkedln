import 'dart:developer';
import 'package:checkedln/services/user/contactServices.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/user/userModel.dart';

class PermissionPhone {
  PermissionStatus? _permissionStatus;
  PermissionStatus? get permissionStatus => _permissionStatus;

  PermissionPhone() {}
  requestContactPermission() async {
    _permissionStatus = await Permission.contacts.request();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await Permission.contacts.request();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionStatus != PermissionStatus.granted) {
      return;
    }
  }
}
