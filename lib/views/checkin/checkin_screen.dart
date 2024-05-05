import 'package:checkedln/controller/check_in_controller.dart';
import 'package:checkedln/views/checkin/create_checkin.dart';
import 'package:checkedln/views/checkin/past_checkin_sceen.dart';
import 'package:checkedln/views/checkin/upcoming_checkin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../widget_helper.dart';
import 'checkin_widget_helper.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  CheckInController _checkInController = Get.find<CheckInController>();
  @override
  void initState() {
    // TODO: implement initState
    _checkInController.getUpcomingEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s) {
        Get.find<HomeController>().currentBottomIndex.value = 0;
        return;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => CreateCheckIn());
            },
            child: Icon(
              Icons.add,
              color: Color(0xff050506),
            ),
            backgroundColor: Color(0xffDDD8DF),
          ),
          appBar: mainAppBar(
              "Check-ins",
              [],
              TabBar(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color(0xff000000),
                  indicatorWeight: 2,
                  tabs: [
                    tabContainer("Upcoming Check-ins"),
                    tabContainer("Past Check-ins")
                  ]),
              true),
          body: SafeArea(
              child: TabBarView(
            children: [
              UpcomingScreen(),
              PastCheckInScreen(),
            ],
          )),
        ),
      ),
    );
  }
}
