import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomLine extends StatelessWidget {
  const BottomLine({
    super.key,
    this.onPress,
  });

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب ؟",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            "تسجيل الأن",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
