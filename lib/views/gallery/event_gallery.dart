import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget_helper.dart';

class EventGallery extends StatefulWidget {
  List<String> images;
  EventGallery({super.key, required this.images});

  @override
  State<EventGallery> createState() => _EventGalleryState();
}

class _EventGalleryState extends State<EventGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar("Event Gallery", [], SizedBox.shrink(), false),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 0, // Gap between columns
              mainAxisSpacing: 0, // Gap between rows
              childAspectRatio: 115.33 / 112, // Aspect ratio for each container
            ),
            itemBuilder: (context, index) {
              return Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8.w.h),
                child: Container(
                  margin: EdgeInsets.all(10.w.h),
                  width: 115.33, // Width of each container
                  height: 112, // Height of each container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.images[index])),
                    // Background color

                    borderRadius: BorderRadius.circular(8.w.h), // Border radius
                  ),
                ),
              );
            },
            itemCount: widget.images.length, // Number of items in the grid
          ),
        )));
  }
}
