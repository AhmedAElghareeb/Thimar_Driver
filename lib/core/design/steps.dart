import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/views/auth/cities/cities_data.dart';

import '../../features/authentication/bloc.dart';
import 'app_button.dart';

class AppSteps extends StatefulWidget {
  const AppSteps({super.key});

  @override
  State<AppSteps> createState() => _AppStepsState();
}

class _AppStepsState extends State<AppSteps> {
  int currentIndex = 0;

  final bloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  currentIndex = 0;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadiusDirectional.circular(
                          6.r,
                        ),
                        color: currentIndex == 0
                            ? getMaterialColor()
                            : const Color(
                          0xffE4EFD9,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "البيانات الشخصية",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: currentIndex == 0
                            ? getMaterialColor()
                            : const Color(
                          0xffE4EFD9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 90.w,
              ),
              GestureDetector(
                onTap: () {
                  currentIndex = 1;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadiusDirectional.circular(
                          6.r,
                        ),
                        color: currentIndex == 1
                            ? getMaterialColor()
                            : const Color(
                          0xffE4EFD9,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "بيانات السيارة",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: currentIndex == 1
                            ? getMaterialColor()
                            : const Color(
                          0xffE4EFD9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: ListView(
              children: [
                currentIndex == 0
                    ? Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          AppInput(
                            controller: bloc.fullNameController,
                            labelText: "اسم المندوب",
                            prefixIcon: "assets/icons/person.svg",
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppInput(
                            controller: bloc.phController,
                            labelText: "رقم الجوال",
                            prefixIcon: "assets/icons/call.svg",
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => GestureDetector(
                              onTap: () async {
                                var result = await showModalBottomSheet(
                                  context: context,
                                  builder: (context) => const CitiesData(),
                                );
                                if (result != null) {
                                  bloc.selectedCity = result;
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
                                        bloc.selectedCity?.name ?? "المدينة",
                                        validator: (value) {
                                          if (bloc.selectedCity == null) {
                                            return "حقل المدينة مطلوب";
                                          }
                                          return null;
                                        },
                                        prefixIcon:
                                        "assets/icons/flag.svg",
                                      ),
                                    ),
                                  ),
                                  if (bloc.selectedCity != null)
                                    IconButton(
                                      onPressed: () {
                                        bloc.selectedCity = null;
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
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "تحديد الموقع على الخريطة",
                            prefixIcon: "assets/icons/location.svg",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "رقم الهوية",
                            prefixIcon: "assets/icons/identity.svg",
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "البريد الالكتروني",
                            prefixIcon: "assets/icons/email.svg",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppInput(
                            controller: bloc.passController,
                            labelText: "كلمة المرور",
                            prefixIcon: "assets/icons/lock.svg",
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "حقل المدينة مطلوب";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppInput(
                            controller: bloc.confirmPassController,
                            labelText: "تأكيد كلمة المرور",
                            prefixIcon: "assets/icons/lock.svg",
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "حقل المدينة مطلوب";
                              } else if (value.toString() != bloc.passController.text) {
                                return "كلمتا المرور غير متطابقتين";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppButton(
                            onPress: () {
                              if(bloc.formKey.currentState!.validate()) {
                                currentIndex = 1;
                                setState(
                                      () {},
                                );
                              }
                            },
                            text: "التالي",
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 71.h,
                                    child: DottedBorder(
                                      radius: Radius.circular(
                                        6.r,
                                      ),
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: const Color(
                                            0xff4C8613,
                                          ),
                                          size: 50.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "صورة رخصة القيادة",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      color: getMaterialColor(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 71.h,
                                    child: DottedBorder(
                                      radius: Radius.circular(
                                        6.r,
                                      ),
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: const Color(
                                            0xff4C8613,
                                          ),
                                          size: 50.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "استمارة السيارة",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      color: getMaterialColor(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 71.h,
                                    child: DottedBorder(
                                      radius: Radius.circular(
                                        6.r,
                                      ),
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: const Color(
                                            0xff4C8613,
                                          ),
                                          size: 50.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "تأمين السيارة",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      color: getMaterialColor(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 71.h,
                                    child: DottedBorder(
                                      radius: Radius.circular(
                                        6.r,
                                      ),
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: const Color(
                                            0xff4C8613,
                                          ),
                                          size: 50.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "السيارة من الأمام",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      color: getMaterialColor(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 71.h,
                                    child: DottedBorder(
                                      radius: Radius.circular(
                                        6.r,
                                      ),
                                      borderType: BorderType.RRect,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: const Color(
                                            0xff4C8613,
                                          ),
                                          size: 50.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "السيارة من الخلف",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      color: getMaterialColor(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          const AppInput(
                            labelText: "نوع السيارة",
                            prefixIcon: "assets/icons/car.svg",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "موديل السيارة",
                            prefixIcon: "assets/icons/car.svg",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "رقم الإيبان",
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppInput(
                            labelText: "إسم البنك",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppButton(
                            onPress: () {},
                            text: "تسجيل",
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
