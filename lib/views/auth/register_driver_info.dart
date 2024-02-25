import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/views/auth/cities/cities_data.dart';
import 'package:thimar_driver/views/auth/login.dart';
import 'package:thimar_driver/views/auth/map/map.dart';
import 'package:thimar_driver/views/auth/register_driver_car_info.dart';

import '../../core/design/auth_bottom_line.dart';
import '../../core/design/steps.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _bloc = KiwiContainer().resolve<AuthenticationBloc>();

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
                    const RegisterSteps(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: ListView(
                          children: [
                            AppInput(
                              controller: _nameController,
                              prefixIcon: "assets/icons/person.svg",
                              labelText: "اسم المندوب",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال اسم المندوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _phoneController,
                              prefixIcon: "assets/icons/call.svg",
                              keyboardType: TextInputType.phone,
                              labelText: "رقم الجوال",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال رقم الجوال";
                                } else if (value.length < 9) {
                                  return "الرجاء ادخال 9 أرقام على الأقل";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => GestureDetector(
                                onTap: () async {
                                  var result = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const CitiesData(),
                                  );
                                  if (result != null) {
                                    _bloc.selectedCity = result;
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: AppInput(
                                          labelText: _bloc.selectedCity?.name ??
                                              "المدينة",
                                          validator: (value) {
                                            if (_bloc.selectedCity == null) {
                                              return "الرجاء اختيار المدينة";
                                            }
                                            return null;
                                          },
                                          prefixIcon: "assets/icons/flag.svg",
                                        ),
                                      ),
                                    ),
                                    if (_bloc.selectedCity != null)
                                      IconButton(
                                        onPressed: () {
                                          _bloc.selectedCity = null;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          size: 24.w.h,
                                          color: Colors.red,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _locationController,
                              prefixIcon: "assets/icons/location.svg",
                              labelText: "تحديد الموقع على الخريطة",
                              onPress: () {
                                navigateTo(const MapScreen()).then((value) {
                                  if (CacheHelper
                                          .getCurrentLocationWithNameMap()
                                      .isNotEmpty) {
                                    _locationController.text = CacheHelper
                                        .getCurrentLocationWithNameMap();
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _idController,
                              prefixIcon: "assets/icons/identity.svg",
                              labelText: "رقم الهوية",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال رقم الهوية";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _emailController,
                              prefixIcon: "assets/icons/email.svg",
                              labelText: "البريد الالكتروني",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال البريد الالكتروني";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _passwordController,
                              prefixIcon: "assets/icons/lock.svg",
                              labelText: "كلمة المرور",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال كلمة المرور";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppInput(
                              controller: _confirmPasswordController,
                              prefixIcon: "assets/icons/lock.svg",
                              labelText: "تأكيد كلمة المرور",
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length < 6 ||
                                    value != _passwordController.text) {
                                  return "الرجاء ادخال كلمة مرور صحيحة ومطابقة";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppButton(
                                text: "التالي",
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    navigateTo(
                                      RegisterDriverCarInfo(
                                        name: _nameController.text,
                                        phone: _phoneController.text,
                                        location: _locationController.text,
                                        id: _idController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        confirmPassword: _confirmPasswordController.text,
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
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
