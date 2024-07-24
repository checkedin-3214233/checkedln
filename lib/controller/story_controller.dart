import 'dart:developer';

import 'package:checkedln/res/snakbar.dart';
import 'package:checkedln/services/stories/stories_services.dart';
import 'package:get/get.dart';
import '../models/story/story_model.dart';
import 'package:dio/dio.dart' as dio;

import '../views/dialog/dialog_helper.dart';

class StoryController extends GetxController {
  var stories = <StoryModel>[].obs;
  StoriesServices _storiesServices = StoriesServices();
  Future getStroies() async {
    _storiesServices.getStories().then((value) {
      stories.value =
          (value.data as List).map((e) => StoryModel.fromJson(e)).toList();
      update();
    });
    log(stories.toString());
  }

  createStroy(List<String> images) async {
    DialogHelper.showLoading("Uploading");
    dio.Response response = await _storiesServices.createStories(images);
    log(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      getStroies();
      showSnakBar(response.data['message']);
      DialogHelper.hideLoading();
    } else {
      DialogHelper.hideLoading();
      showSnakBar("Some error occurred at our end");
    }
  }
}
