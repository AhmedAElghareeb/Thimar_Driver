import 'package:dotted_border/dotted_border.dart';
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
import 'package:thimar_driver/features/authentication/city_model.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/car/cars_data.dart';
import 'package:thimar_driver/views/auth/check_code.dart';
import 'package:thimar_driver/views/auth/login.dart';

class RegisterDriverCarInfo extends StatefulWidget {
  final String name, phone, location, id, email, password, confirmPassword;
  final CityModel cityId;

  const RegisterDriverCarInfo({
    super.key,
    required this.name,
    required this.phone,
    required this.location,
    required this.id,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.cityId,
  });

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _bloc.licenseImage = await uploadPhoto(
                                context: context,
                                selectedImage: _bloc.licenseImage,
                              );
                              setState(() {});
                            },
                            child: _bloc.licenseImage == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: DottedBorder(
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'صورة رخصة السيارة',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(
                                        _bloc.licenseImage!,
                                        width: 70,
                                        height: 70,
                                      ),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            _bloc.licenseImage = null;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _bloc.carFormImage = await uploadPhoto(
                                context: context,
                                selectedImage: _bloc.carFormImage,
                              );
                              setState(() {});
                            },
                            child: _bloc.carFormImage == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: DottedBorder(
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'استمارة السيارة',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(
                                        _bloc.carFormImage!,
                                        width: 70,
                                        height: 70,
                                      ),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            _bloc.carFormImage = null;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _bloc.carInsurance = await uploadPhoto(
                                context: context,
                                selectedImage: _bloc.carInsurance,
                              );
                              setState(() {});
                            },
                            child: _bloc.carInsurance == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: DottedBorder(
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'تأمين السيارة',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(
                                        _bloc.carInsurance!,
                                        width: 70,
                                        height: 70,
                                      ),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            _bloc.carInsurance = null;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _bloc.frontCarImage = await uploadPhoto(
                                context: context,
                                selectedImage: _bloc.frontCarImage,
                              );
                              setState(() {});
                            },
                            child: _bloc.frontCarImage == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: DottedBorder(
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "السيارة من الأمام",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(
                                        _bloc.frontCarImage!,
                                        width: 70,
                                        height: 70,
                                      ),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            _bloc.frontCarImage = null;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _bloc.backCarImage = await uploadPhoto(
                                context: context,
                                selectedImage: _bloc.backCarImage,
                              );
                              setState(() {});
                            },
                            child: _bloc.backCarImage == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: DottedBorder(
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "السيارة من الخلف",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(
                                        _bloc.backCarImage!,
                                        width: 70,
                                        height: 70,
                                      ),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            _bloc.backCarImage = null;
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
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
                  if (state is DriverRegisterFailedState) {
                    showSnackBar(
                      state.msg,
                      typ: MessageType.fail,
                    );
                  }
                },
                builder: (BuildContext context, state) {
                  return AppButton(
                    isLoading: state is DriverRegisterLoadingState,
                    text: "تسجيل",
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        if (_bloc.licenseImage == null) {
                          showSnackBar(
                            "بالرجاء ادخال صورة رخصة القيادة",
                            typ: MessageType.fail,
                          );
                        } else if (_bloc.carFormImage == null) {
                          showSnackBar(
                            "بالرجاء ادخال صورة استمارة السيارة",
                            typ: MessageType.fail,
                          );
                        } else if (_bloc.carInsurance == null) {
                          showSnackBar(
                            "بالرجاء ادخال صورة تأمين السيارة",
                            typ: MessageType.fail,
                          );
                        } else if (_bloc.frontCarImage == null) {
                          showSnackBar(
                            "بالرجاء ادخال صورة السيارة من الامام",
                            typ: MessageType.fail,
                          );
                        } else if (_bloc.backCarImage == null) {
                          showSnackBar(
                            "بالرجاء ادخال صورة السيارة من الخلف",
                            typ: MessageType.fail,
                          );
                        } else if (!_isSelectable) {
                          showSnackBar(
                            "الرجاء الموافقة علي الشروط والاحكام!!",
                            typ: MessageType.fail,
                          );
                        } else {
                          _bloc.add(
                            DriverRegisterEvent(
                              context: context,
                              cityId: widget.cityId,
                              id: widget.id,
                              name: widget.name,
                              phone: widget.phone,
                              location: widget.location,
                              email: widget.email,
                              password: widget.password,
                              confirmPassword: widget.confirmPassword,
                            ),
                          );
                        }
                      }
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
