import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/checkin/check_in_controller.dart';
import 'checkin_widget_helper.dart';

class PastCheckInScreen extends StatefulWidget {
  const PastCheckInScreen({super.key});

  @override
  State<PastCheckInScreen> createState() => _PastCheckInScreenState();
}

class _PastCheckInScreenState extends State<PastCheckInScreen> {
  CheckInController _checkInController = Get.find<CheckInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => _checkInController.isPastEventsLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: _checkInController.pastEvent.length,
            itemBuilder: (context, i) {
              return checkIn(i, false);
            })),
      ),
    );
  }
}
