import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/cache_helper.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 217.h,
      padding: EdgeInsetsDirectional.symmetric(
        vertical: 25.h,
      ),
      margin: EdgeInsetsDirectional.only(
        bottom: 16.h
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            40.r,
          ),
          bottomLeft: Radius.circular(
            40.r,
          ),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Text(
            "حسابي",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: 76.w,
            height: 71.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15.r,
              ),
            ),
            child: Image.network(
              CacheHelper.getImage(),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            CacheHelper.getFullName(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            CacheHelper.getPhone(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(
                0xffA2D273,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
