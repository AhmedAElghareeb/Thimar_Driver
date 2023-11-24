import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/logic/helper_methods.dart';
import '../../../features/notifications/model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key,
    required this.model,
  });

  final NotificationsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 10.h),
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(
          15.r,
        ),
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Image.network(
            model.image,
            width: 33.w,
            height: 33.h,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: getMaterialColor()
                ),
              ),
              Text(
                model.body,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff989898,),
                ),
              ),
              Text(
                model.createdAt,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: getMaterialColor()
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
