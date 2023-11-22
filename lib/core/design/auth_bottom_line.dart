import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

class BottomLine extends StatelessWidget {
  const BottomLine({
    super.key,
    this.onPress,
    this.text,
    this.subText
  });

  final VoidCallback? onPress;
  final String? text, subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          subText!,
          style: TextStyle(
            color: getMaterialColor(),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            text!,
            style: TextStyle(
              color: getMaterialColor(),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
