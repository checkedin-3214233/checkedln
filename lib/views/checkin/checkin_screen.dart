import 'package:checkedln/controller/checkin/check_in_controller.dart';
import 'package:checkedln/global_index.dart';
import 'package:checkedln/views/checkin/create_checkin.dart';
import 'package:checkedln/views/checkin/past_checkin_sceen.dart';
import 'package:checkedln/views/checkin/upcoming_checkin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/checkin/create_checkin_controller.dart';
import '../../controller/home_controller.dart';
import '../../res/colors/routes/route_constant.dart';
import '../widget_helper.dart';
import 'checkin_widget_helper.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final CheckInController _checkInController =
      Get.isRegistered<CheckInController>()
          ? Get.find<CheckInController>()
          : Get.put(CheckInController());
  final CreateCheckInController _createCheckInController =
      Get.put(CreateCheckInController());
  @override
  void initState() {
    // TODO: implement initState
    _checkInController.getUpcomingEvent();
    _checkInController.getPastEvent();
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
              ctx!.push(RoutesConstants.createCheckin);
            },
            child: Icon(
              Icons.add,
              color: Color(0xffFFFFFF),
            ),
            backgroundColor: Color(0xffBD57EA),
          ),
          appBar: mainAppBar(
              "Check-ins",
              [],
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: TextField(
                      controller: _checkInController.searchEvents,
                      onChanged: (val) {
                        _checkInController.search(val);
                      },
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey), // Search icon
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFDDD8DF), // Border color in hex
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                              14.0), // Optional border radius
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xffDDD8DF), // Border color for focused state
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xffDDD8DF), // Border color for focused state
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                      isScrollable: false,
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: (value) {
                        _checkInController.tab.value = value;
                      },
                      padding: EdgeInsets.symmetric(vertical: 15),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Color(0xff2E083F),
                      indicatorWeight: 2,
                      indicatorPadding: EdgeInsets.symmetric(vertical: 0),
                      tabs: [tabContainer("Upcoming"), tabContainer("Past")]),
                ],
              ),
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
