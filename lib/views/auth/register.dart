import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/views/auth/login.dart';

import '../../core/design/auth_bottom_line.dart';
import '../../core/design/steps.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
                child: Column(
                  children: [
                    const AuthHeader(
                      text1: "مرحبا بك مرة أخرى",
                      text2: "يمكنك تسجيل حساب جديد الأن",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const AppSteps(),
                    SizedBox(
                      height: 45.h,
                    ),
                    BottomLine(
                      onPress: () {
                        navigateTo(
                          const LoginView(),
                        );
                      },
                      subText: "لديك حساب بالفعل ؟ ",
                      text: "تسجيل الدخول",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
