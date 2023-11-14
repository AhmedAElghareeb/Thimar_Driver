import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_bottom_line.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/login.dart';

import '../../features/authentication/bloc.dart';
import '../../features/authentication/events.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  final bloc = KiwiContainer().resolve<AuthenticationBloc>();

  final _event = DriverForgetPasswordEvent();

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
          Form(
            key: bloc.formKey,
            child: Scaffold(
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
                    AppInput(
                      controller: _event.phController,
                      keyboardType: TextInputType.phone,
                      labelText: "رقم الجوال",
                      prefixIcon: "assets/icons/call.svg",
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "هذا الحقل مطلوب!!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        return AppButton(
                          onPress: ()
                          {
                            if(bloc.formKey.currentState!.validate()) {
                              bloc.add(
                                DriverForgetPasswordEvent(),
                              );
                            }
                          },
                          isLoading: state is DriverForgetPasswordLoadingState,
                          text: "تأكيد رقم الجوال",
                        );
                      },
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
          ),
        ],
      ),
    );
  }
}
