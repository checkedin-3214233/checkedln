import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s){
        Get.find<HomeController>().currentBottomIndex.value=0;
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("CheckIn"),
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }
}
