import 'package:checkedln/global_index.dart';
import 'package:flutter/material.dart';

showSnakBar(String text) {
  final snackBar = SnackBar(
    content: Text(text),
  );

  ScaffoldMessenger.of(ctx!).showSnackBar(snackBar);
}
