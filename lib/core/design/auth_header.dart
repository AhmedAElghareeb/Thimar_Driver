import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/center.svg",
          width: 130.w,
          height: 125.h,
        ),
        SizedBox(
          height: 21.h,
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            text1,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF707070),
            ),
          ),
        ),
      ],
    );
  }
}
