import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/design/auth_bottom_line.dart';
import 'package:thimar_driver/core/design/auth_header.dart';
import 'package:thimar_driver/core/design/steps.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/car/cars_data.dart';
import 'package:thimar_driver/views/auth/check_code.dart';
import 'package:thimar_driver/views/auth/login.dart';
import 'package:thimar_driver/views/auth/resuable/upload_photo.dart';

class RegisterDriverCarInfo extends StatefulWidget {
  final String name, phone, location, id, email, password, confirmPassword;

  const RegisterDriverCarInfo(
      {super.key,
      required this.name,
      required this.phone,
      required this.location,
      required this.id,
      required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  State<RegisterDriverCarInfo> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterDriverCarInfo> {
  bool _isSelectable = false;
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const AuthHeader(
                text1: "مرحبا بك مرة أخرى",
                text2: "يمكنك تسجيل حساب جديد الأن",
              ),
              SizedBox(
                height: 15.h,
              ),
              const RegisterSteps(
                isActive: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              _bloc.licenseImage = await uploadPhoto(
                                context: context,
                              );
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "صورة رخصة القيادة",
                              image: _bloc.licenseImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.carFormImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "استمارة السيارة",
                              image: _bloc.carFormImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.carInsurance =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "تأمين السيارة",
                              image: _bloc.carInsurance,
                            )),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              _bloc.frontCarImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "السيارة من الأمام",
                              image: _bloc.frontCarImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.backCarImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "السيارة من الخلف",
                              image: _bloc.backCarImage,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              AppInput(
                controller: _bloc.carTypeController,
                labelText: "نوع السيارة",
                prefixIcon: "assets/icons/car.svg",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال نوع السيارة";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              StatefulBuilder(
                builder: (context, setState) => GestureDetector(
                  onTap: () async {
                    var result = await showModalBottomSheet(
                      context: context,
                      builder: (context) => const CarsData(),
                    );
                    if (result != null) {
                      _bloc.selectedCar = result;
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
                            labelText:
                                _bloc.selectedCar?.name ?? "موديل السيارة",
                            validator: (value) {
                              if (_bloc.selectedCar == null) {
                                return "الرجاء اختيار موديل السيارة";
                              }
                              return null;
                            },
                            prefixIcon: "assets/icons/car.svg",
                          ),
                        ),
                      ),
                      if (_bloc.selectedCar != null)
                        IconButton(
                          onPressed: () {
                            _bloc.selectedCar = null;
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
              SizedBox(height: 16.h),
              AppInput(
                controller: _bloc.iBanController,
                labelText: "رقم الإيبان",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال رقم الإيبان";
                  }

                  return null;
                },
              ),
              SizedBox(height: 16.h),
              AppInput(
                controller: _bloc.bankNameController,
                labelText: "إسم البنك",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال إسم البنك";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: () {
                  _isSelectable = !_isSelectable;
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: _isSelectable
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            color: _isSelectable
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: _isSelectable
                            ? Colors.white
                            : Theme.of(context).hintColor,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "الموافقة على الشروط والأحكام",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              BlocConsumer(
                bloc: _bloc,
                listener: (BuildContext context, Object? state) {
                  if (state is DriverRegisterSuccessState) {
                    navigateTo(
                      CheckCodeScreen(
                        pageName: "activation",
                        phone: widget.phone,
                      ),
                    );
                  }
                },
                builder: (BuildContext context, state) {
                  return AppButton(
                    isLoading: state is DriverRegisterLoadingState,
                    text: "تسجيل",
                    onPress: () {
                      String message = "";
                      if (_bloc.licenseImage == null) {
                        message = "بالرجاء ادخال صورة رخصة القيادة";
                      } else if (_bloc.carFormImage == null) {
                        message = "بالرجاء ادخال صورة استمارة السيارة";
                      } else if (_bloc.carInsurance == null) {
                        message = "بالرجاء ادخال صورة تأمين السيارة";
                      } else if (_bloc.frontCarImage == null) {
                        message = "بالرجاء ادخال صورة السيارة من الامام";
                      } else if (_bloc.backCarImage == null) {
                        message = "بالرجاء ادخال صورة السيارة من الخلف";
                      } else if (_bloc.carModelController.text.isEmpty) {
                        message = "بالرجاء ادخال موديل السيارة";
                      } else if (!_isSelectable) {
                        message = "بالرجاء الموافقة علي الشروط والاحكام";
                      }
                      if (message.isNotEmpty) {
                        showSnackBar(
                          message,
                          typ: MessageType.fail,
                        );
                      } else if (_formKey.currentState!.validate()) {
                        _bloc.add(DriverRegisterEvent(
                            context: context,
                            name: widget.name,
                            phone: widget.password,
                            location: widget.location,
                            id: widget.id,
                            email: widget.email,
                            password: widget.password,
                            confirmPassword: widget.confirmPassword));
                      }
                      navigateTo(
                        CheckCodeScreen(
                            pageName: "activation", phone: widget.phone),
                      );
                    },
                  );
                },
              ),
              // BlocBuilder(
              //   bloc: _bloc,
              //   builder: (BuildContext context, state) {
              //     return AppButton(
              //       isLoading: state is DriverRegisterLoadingState,
              //       text: "تسجيل",
              //       onPress: () {
              //         if (_formKey.currentState!.validate()) {
              //           _bloc.add(
              //             DriverRegisterEvent(
              //               context: context,
              //               name: widget.name,
              //               phone: widget.password,
              //               location: widget.location,
              //               id: widget.id,
              //               email: widget.email,
              //               password: widget.password,
              //               confirmPassword: widget.confirmPassword,
              //             ),
              //           );
              //         }
              //       },
              //     );
              //   },
              // ),
              SizedBox(height: 24.h),
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
    );
  }
}
