import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../controller/buddies_controller.dart';
import '../../../controller/checkin/get_checkin_controller.dart';
import '../../../global_index.dart';
import '../../../res/colors/routes/route_constant.dart';
import '../profile_avatar.dart';

class UserBuddiesScreen extends StatefulWidget {
  String userId;
  UserBuddiesScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserBuddiesScreen> createState() => _UserBuddiesScreenState();
}

class _UserBuddiesScreenState extends State<UserBuddiesScreen> {
  late final BuddiesController _buddiesController;
  // final GetCheckInController _getCheckInController =
  //     Get.find<GetCheckInController>();
  @override
  void initState() {
    // TODO: implement initState

    _buddiesController = Get.put(BuddiesController(), tag: widget.userId);
    _buddiesController.getBuddies(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          () => _buddiesController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                    );
                  },
                  itemCount: _buddiesController.buddies.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () {
                        ctx!.push(
                            "${RoutesConstants.userProfile}/${_buddiesController.buddies[i].id}");
                      },
                      trailing: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Remove",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        width: 77.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: Color(0xffCBCBCB),
                          borderRadius: BorderRadius.circular(3.w.h),
                        ),
                      ),
                      leading: ProfileAvatar(
                        imageUrl: _buddiesController
                                .buddies[i].profileImageUrl!.isEmpty
                            ? _buddiesController.buddies[i].gender == "male"
                                ? "https://userallimages.s3.amazonaws.com/male.png"
                                : "https://userallimages.s3.amazonaws.com/female.png"
                            : _buddiesController.buddies[i].profileImageUrl!,
                        size: 68,
                        borderColor: Colors.white,
                        child: SizedBox.shrink(),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _buddiesController.buddies[i].name!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            _buddiesController.buddies[i].userName!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
        )));
  }
}
