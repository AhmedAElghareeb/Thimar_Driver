import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_header.dart';

import '../../core/design/auth_bottom_line.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          children: [
            const AuthHeader(
              text1: "مرحبا بك مرة أخرى",
              text2: "يمكنك تسجيل الدخول الأن",
            ),
            SizedBox(
              height: 28.h,
            ),
            const AppInput(
              labelText: "رقم الجوال",
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 16.h,
            ),
            const AppInput(
              labelText: "كلمة المرور",
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(
              height: 9.h,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "هل نسيت كلمة المرور ؟",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(
                      0xff707070,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            AppButton(
              onTap: () {},
              text: "تسجيل الدخول",
            ),
            SizedBox(
              height: 45.h,
            ),
            BottomLine(
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
