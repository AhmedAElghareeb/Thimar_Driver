import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backColor,
    this.textColor,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String text;
  final Color? backColor;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const FittedBox(
      fit: BoxFit.scaleDown,
      child: CircularProgressIndicator(),
    )
        : Container(
      width: 343.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        color: backColor ?? Theme.of(context).primaryColor,
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? const Color(0xFFFFFFFF),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
