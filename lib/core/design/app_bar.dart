import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

AppBar buildAppBar({final String? title}) {
  return AppBar(
    title: Text(
      title ?? "",
    ),
    leading: Padding(
      padding: EdgeInsetsDirectional.all(
        10.r,
      ),
      child: GestureDetector(
        child: Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color: const Color(
              0xff707070,
            ).withOpacity(0.1),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 7.w,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 16.r,
              color: Theme.of(navigatorKey.currentContext!).primaryColor,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(navigatorKey.currentContext!);
        },
      ),
    ),
  );
}