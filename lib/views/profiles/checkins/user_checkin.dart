import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/my_checkin_controller.dart';
import '../profile_avatar.dart';

class UserCheckIns extends StatefulWidget {
  String userId;
  UserCheckIns({super.key, required this.userId});

  @override
  State<UserCheckIns> createState() => _UserCheckInsState();
}

class _UserCheckInsState extends State<UserCheckIns> {
  MyCheckInController _myCheckInController = Get.put(MyCheckInController());
  @override
  void initState() {
    // TODO: implement initState
    _myCheckInController.getCheckin(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => _myCheckInController.isLoading.value
              ? SizedBox.shrink()
              : Text(
                  "${_myCheckInController.checkin.length} Checkins",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff000000),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: Obx(
          () => _myCheckInController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                    );
                  },
                  itemCount: _myCheckInController.checkin.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 18.w),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Color(0xffF6F4F4),
                        borderRadius: BorderRadius.circular(10.w.h),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ProfileAvatar(
                                imageUrl: _myCheckInController
                                    .checkin[i].bannerImages!,
                                size: 51,
                                borderColor: Colors.white,
                                child: SizedBox.shrink(),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _myCheckInController
                                        .checkin[i].checkInName!,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                  Text(
                                    timeAgo(_myCheckInController
                                        .checkin[i].createdAt!),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9C9C9C),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                _myCheckInController.checkin[i].description ??
                                    "",
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_outlined),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                _myCheckInController
                                    .checkin[i].interested.length
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        )));
  }
}

String timeAgo(DateTime dateTime) {
  final Duration diff = DateTime.now().difference(dateTime);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} seconds ago';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
  } else if (diff.inDays < 7) {
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  } else if (diff.inDays < 30) {
    return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? 's' : ''} ago';
  } else if (diff.inDays < 365) {
    return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() > 1 ? 's' : ''} ago';
  } else {
    return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() > 1 ? 's' : ''} ago';
  }
}
