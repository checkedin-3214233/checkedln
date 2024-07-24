import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/networks/dio_networks.dart';

class StoriesServices {
  DioNetwork dioNetwork = DioNetwork();
  final String _story = dotenv.env['STORY']!;
  getStories() async {
    try {
      final response = await dioNetwork.getData(_story);
      return response;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  createStories(List images) async {
    var data = {
      "imageUrls": images,
    };
    try {
      final response = await dioNetwork.postData(_story, data: data);
      return response;
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }
}
