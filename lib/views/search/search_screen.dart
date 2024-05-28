import 'package:checkedln/global.dart';
import 'package:checkedln/res/colors/routes/route_constant.dart';
import 'package:checkedln/views/profiles/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/search_controller.dart';
import '../profiles/user_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  MainSearchController _searchController = Get.put(MainSearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextField(
                      onChanged: (val) {
                        _searchController.searchUser();
                      },
                      controller: _searchController.searchEditingController,
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
                              8.0), // Optional border radius
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(
                              0xffDDD8DF), // Border color for focused state
                          width: 1.0,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xffDDD8DF), // Border color for focused state
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          Obx(() => ListView.separated(
              separatorBuilder: (context, i) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                );
              },
              shrinkWrap: true,
              itemCount: _searchController.users.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    ctx!.push(
                        "${RoutesConstants.userProfile}/${_searchController.users[i].id!}");
                  },
                  child: Row(
                    children: [
                      ProfileAvatar(
                        imageUrl: _searchController.users[i].profileImageUrl!,
                        size: 40,
                        child: SizedBox.shrink(),
                        borderColor: Colors.white,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _searchController.users[i].userName!,
                            style: TextStyle(
                                color: Color(0xff050506),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "10 Mutulas",
                            style: TextStyle(
                                color: Color(0xff6A5C70),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).marginSymmetric(horizontal: 10.w, vertical: 10.h))
        ],
      )),
    );
  }
}
