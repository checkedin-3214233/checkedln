import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:checkedln/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/injection/dependency_injection.dart';
import '../../res/colors/colors.dart';

Widget userName(TextEditingController controller, TextInputType type,
    String hintText, bool isEditable) {
  PostController _postController = Get.find<PostController>();
  return TextField(
    maxLines: hintText == "Write something.. (Optional)" ? 3 : null,
    textInputAction: TextInputAction.next,
    onTap: () async {},
    readOnly: isEditable,
    controller: controller,
    onChanged: (val) async {
      if (hintText == "Add Friends") {
        await _postController.searchUser();
      }
    },
    keyboardType: type,
    decoration: InputDecoration(
      prefixIcon: (hintText == "Location")
          ? Image.asset("assets/images/location.png")
          : (hintText == "Add Friends")
              ? Image.asset("assets/images/atherate.png")
              : null,
      filled: true,
      fillColor: Color(0xFFF5F4F6), // Background color
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD189F0)), // Border color
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF5F4F6)),
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: getIt<ColorsFile>().textColor4, // Text color
        fontWeight: FontWeight.w500, // Text weight
        fontSize: 12.0.sp, // Text size
      ),
    ),
  ).marginSymmetric(vertical: 3.h);
}

Widget addFriendsHelper(TextEditingController controller, TextInputType type,
    String hintText, bool isEditable) {
  GlobalKey<AutoCompleteTextFieldState<dynamic>> key =
      GlobalKey<AutoCompleteTextFieldState<dynamic>>();
  PostController _postController = Get.find<PostController>();
  return AutoCompleteTextField<dynamic>(
    controller: controller,
    textChanged: (data) async {
      await _postController.searchUser();
    },
    decoration: InputDecoration(
      prefixIcon: (hintText == "Location")
          ? Image.asset("assets/images/location.png")
          : (hintText == "Add Friends")
              ? Image.asset("assets/images/atherate.png")
              : null,
      filled: true,
      fillColor: Color(0xFFF5F4F6), // Background color
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD189F0)), // Border color
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF5F4F6)),
        borderRadius: BorderRadius.circular(15.0), // Border radius
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: getIt<ColorsFile>().textColor4, // Text color
        fontWeight: FontWeight.w500, // Text weight
        fontSize: 12.0.sp, // Text size
      ),
    ),
    itemSubmitted: (item) {
      print("object");
      _postController.addElements(item);
    },
    suggestions: _postController.users,
    itemBuilder: (context, suggestion) => Padding(
        child: ListTile(
          title: Text(suggestion.userName),
        ),
        padding: EdgeInsets.all(8.0)),
    key: key,
    itemFilter: (suggestion, String query) =>
        suggestion.userName.toLowerCase().startsWith(query.toLowerCase()),
    itemSorter: (a, b) => a.userName.compareTo(b.userName),
  );
}
