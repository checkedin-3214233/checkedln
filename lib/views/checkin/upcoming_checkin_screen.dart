import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/check_in_controller.dart';
import 'checkin_widget_helper.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  CheckInController _checkInController = Get.find<CheckInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => _checkInController.isUpcomingLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _checkInController.upcomingEvents.length,
                itemBuilder: (context, i) {
                  return checkIn(i, true);
                })),
      ),
    );
  }
}
