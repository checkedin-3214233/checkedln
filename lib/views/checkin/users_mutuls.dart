// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../global.dart';
import '../../models/user/userModel.dart';

class UserMutuals extends StatefulWidget {
  List<String> list1;
  List<UserModel>? attendies;

  UserMutuals({
    Key? key,
    required this.list1,
    required this.attendies,
  }) : super(key: key);

  @override
  State<UserMutuals> createState() => _UserMutualsState();
}

class _UserMutualsState extends State<UserMutuals> {
  List<UserModel>? attendies = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  makeMutuals() {
    List<UserModel>? filteredAttendies = [];

    if (widget.list1.isNotEmpty && widget.attendies != null) {
      isLoading = true;
      setState(() {});
      // Create a set for fast lookups
      final attendiesMap = {for (var user in widget.attendies!) user.id: user};

      // Filter attendies based on matching IDs in list1
      for (final id in widget.list1) {
        if (attendiesMap.containsKey(id)) {
          filteredAttendies.add(attendiesMap[id]!);
        }
      }
    }
    attendies = filteredAttendies;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: attendies!.isEmpty
          ? Center(
              child: Text("No Mutuals Found"),
            )
          : ListView.separated(
              separatorBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.h),
                );
              },
              itemCount: attendies!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    ctx!.push(
                        "${RoutesConstants.userProfile}/${attendies![i].id}");
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
                    imageUrl: attendies![i].profileImageUrl!.isEmpty
                        ? attendies![i].gender == "male"
                            ? "https://userallimages.s3.amazonaws.com/male.png"
                            : "https://userallimages.s3.amazonaws.com/female.png"
                        : attendies![i].profileImageUrl!,
                    size: 68,
                    borderColor: Colors.white,
                    child: SizedBox.shrink(),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        attendies![i].name!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                        ),
                      ),
                      Text(
                        attendies![i].userName!,
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
    );
  }
}
