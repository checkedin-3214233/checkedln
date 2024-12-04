import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global.dart';

class AuthButton extends StatefulWidget {
  String text;
  Function() onPressed;
  bool isFullWidth;
  AuthButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isFullWidth = true})
      : super(key: key);

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        await widget.onPressed();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        alignment: Alignment.center,
        width: widget.isFullWidth ? MediaQuery.of(ctx!).size.width : null,
        decoration: BoxDecoration(
          color: Color(isLoading ? 0xffDADADA : 0xffECECEC),
          borderRadius: BorderRadius.circular(11.5.w.h),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff000000),
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
