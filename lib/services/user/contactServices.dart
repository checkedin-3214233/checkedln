import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class ContactsServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _user = dotenv.env['USER']!;
  final String _suggestedUser = dotenv.env['SUGGESTED_USER']!;

  getSuggestedUser(List phoneNumber) async {
    try {
      var response = await dioNetwork.postData(_user + _suggestedUser,
          data: {"phoneNumbers": phoneNumber});
      log("Suggested" + response.data.toString());
      return response;
    } catch (e) {
      return null;
    }
  }
}
