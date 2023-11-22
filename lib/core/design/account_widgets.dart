import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

class AccountWidgets extends StatelessWidget {
  const AccountWidgets({
    super.key,
    this.onPress,
    this.imageName,
    this.title,
  });

  final VoidCallback? onPress;
  final String? imageName, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        top: 15.h,
        bottom: 15.h,
      ),
      child: GestureDetector(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/$imageName",
                  width: 18.w,
                  height: 18.h,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: getMaterialColor(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: 20.w,
              ),
              child: SvgPicture.asset(
                "assets/icons/arrow_left.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
