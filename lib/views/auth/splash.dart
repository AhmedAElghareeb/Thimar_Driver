import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thimar_driver/views/auth/login.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/helper_methods.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 1,
        ), () async {
      if (CacheHelper.getToken().isNotEmpty) {
        pushReplacement(
          const HomeNavBar(),
        );
      } else {
        pushReplacement(
          const LoginView(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: -50.h,
              right: -150.w,
              child: Image.asset(
                "assets/images/bottom.png",
                width: 450.w,
                height: 300.h,
              ),
            ),
            SvgPicture.asset(
              "assets/images/bg.svg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Center(
              child: Flash(
                animate: true,
                duration: const Duration(
                  seconds: 3,
                ),
                child: SvgPicture.asset(
                  "assets/images/center.svg",
                  width: 160.w,
                  height: 160.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
