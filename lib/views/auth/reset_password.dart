import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';

class ResetPasswordView extends StatefulWidget {
  final String phone;

  const ResetPasswordView({
    super.key,
    required this.phone,
  });

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final bloc = KiwiContainer().resolve<AuthenticationBloc>();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            key: _formKey,
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
                      text1: "إعادة تعيين كلمة المرور",
                      text2: "أدخل كلمة المرور الجديدة",
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    AppInput(
                      controller: _passwordController,
                      prefixIcon: "assets/icons/lock.svg",
                      labelText: "كلمة المرور الجديدة",
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال كلمة المرور الجديدة";
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
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              bloc.add(
                                DriverResetPasswordEvent(
                                  newPassword: _passwordController.text,
                                  phone: widget.phone,
                                ),
                              );
                            }
                          },
                          isLoading: state is DriverResetPasswordSuccessState,
                          text: "حفظ",
                        );
                      },
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
