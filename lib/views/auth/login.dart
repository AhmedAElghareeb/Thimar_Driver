import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';

import '../../core/design/auth_bottom_line.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final bloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
            Form(
              key: bloc.formKey,
              child: Scaffold(
                backgroundColor: Colors.transparent,
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
                      AppInput(
                        controller: bloc.phController,
                        labelText: "رقم الجوال",
                        keyboardType: TextInputType.phone,
                        prefixIcon: "assets/icons/call.svg",
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppInput(
                        controller: bloc.passController,
                        labelText: "كلمة المرور",
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        prefixIcon: "assets/icons/lock.svg",
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
                      BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          return AppButton(
                            isLoading: state is DriverLoginLoadingState,
                            onPress: () {
                              bloc.add(
                                DriverLoginEvent(),
                              );
                            },
                            text: "تسجيل الدخول",
                          );
                        },
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
              ),
            ),
          ],
        ),
      );
    });
  }
}
