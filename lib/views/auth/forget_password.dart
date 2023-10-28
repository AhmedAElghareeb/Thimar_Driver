import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_bottom_line.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/views/auth/login.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/bg.svg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: ListView(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
                children: [
                  const AuthHeader(
                    text1: "نسيت كلمة المرور",
                    text2: "أدخل رقم الجوال المرتبط بحسابك",
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  const AppInput(
                    keyboardType: TextInputType.phone,
                    labelText: "رقم الجوال",
                    prefixIcon: "assets/icons/call.svg",
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  AppButton(
                    onPress: () {},
                    text: "تأكيد رقم الجوال",
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  BottomLine(
                    onPress: () {
                      navigateTo(
                        const LoginView(),
                      );
                    },
                    subText: "لديك حساب بالفعل ؟",
                    text: "تسجيل الدخول",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
