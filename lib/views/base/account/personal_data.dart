import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/cities/cities_data.dart';
import 'package:thimar_driver/views/auth/resuable/upload_photo.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  final _getProfileBloc = KiwiContainer().resolve<AuthenticationBloc>()
    ..add(GetProfileDataEvent());
  final _editProfileBloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "البيانات الشخصية"),
      body: Column(
        children: [
          SizedBox(height: 24.h),
          BlocBuilder(
              bloc: _getProfileBloc,
              builder: (BuildContext context, state) {
                if (state is GetProfileLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetProfileSuccessState) {
                  return Column(children: [
                    GestureDetector(
                        onTap: () async {
                          _editProfileBloc.userImage = await uploadPhoto(
                            context: context,
                          );
                          setState(() {});
                        },
                        child: PhotoUpload(
                          showPhoto: true,
                          imageNumber: 0,
                          text: state.data.data.fullname,
                          image: _editProfileBloc.userImage,
                        )),
                    SizedBox(height: 4.h),
                    Text(
                      "${state.data.data.phone}+",
                      style: TextStyle(
                          fontSize: 17.sp, color: Theme.of(context).hintColor),
                    ),
                  ]);
                } else if (state is GetProfileErrorState) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              }),
          SizedBox(height: 24.h),
          TabBar(
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Theme.of(context).hintColor,
              padding: const EdgeInsets.all(10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Theme.of(context).primaryColor,
              ),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    "البيانات الشخصية",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "بيانات السيارة",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ]),
          SizedBox(height: 24.h),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    AppInput(
                      controller: _editProfileBloc.nameController,
                      labelText: "اسم المستخدم",
                      prefixIcon: "assets/icons/person.svg",
                    ),
                    SizedBox(height: 20.h),
                    AppInput(
                      controller: _editProfileBloc.phoneController,
                      keyboardType: TextInputType.phone,
                      labelText: "رقم الجوال",
                    ),
                    SizedBox(height: 20.h),
                    StatefulBuilder(
                      builder: (context, setState) => GestureDetector(
                        onTap: () async {
                          var result = await showModalBottomSheet(
                            context: context,
                            builder: (context) => const CitiesData(),
                          );
                          if (result != null) {
                            _getProfileBloc.selectedCity = result;
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
                                      _getProfileBloc.selectedCity?.name ??
                                          "المدينة",
                                  validator: (value) {
                                    if (_getProfileBloc.selectedCity == null) {
                                      return "الرجاء اختيار المدينة";
                                    }
                                    return null;
                                  },
                                  prefixIcon: "assets/icons/flag.svg",
                                ),
                              ),
                            ),
                            if (_getProfileBloc.selectedCity != null)
                              IconButton(
                                onPressed: () {
                                  _getProfileBloc.selectedCity = null;
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
                    SizedBox(height: 20.h),
                    AppInput(
                      controller: _editProfileBloc.idController,
                      keyboardType: TextInputType.number,
                      labelText: "رقم الهوية",
                      prefixIcon: "assets/icons/identity.svg",
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.licenseImage =
                                      await uploadPhoto(
                                    context: context,
                                  );
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "صورة رخصة القيادة",
                                  image: _editProfileBloc.licenseImage,
                                  showPhoto: true,
                                  imageNumber: 1,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.carFormImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "استمارة السيارة",
                                  image: _editProfileBloc.carFormImage,
                                  showPhoto: true,
                                  imageNumber: 2,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.carInsurance =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "تأمين السيارة",
                                  showPhoto: true,
                                  imageNumber: 3,
                                  image: _editProfileBloc.carInsurance,
                                )),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.frontCarImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "السيارة من الأمام",
                                  image: _editProfileBloc.frontCarImage,
                                  showPhoto: true,
                                  imageNumber: 4,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.backCarImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "السيارة من الخلف",
                                  showPhoto: true,
                                  imageNumber: 5,
                                  image: _editProfileBloc.backCarImage,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AppInput(
                      controller: _editProfileBloc.carTypeController,
                      labelText: "نوع السيارة",
                      prefixIcon: "assets/icons/car.svg",
                    ),
                    SizedBox(height: 20.h),
                    AppInput(
                      controller: _editProfileBloc.iBanController,
                      keyboardType: TextInputType.number,
                      labelText: "رقم الإيبان",
                    ),
                    SizedBox(height: 20.h),
                    AppInput(
                      controller: _editProfileBloc.bankNameController,
                      labelText: "إسم البنك",
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocConsumer(
            bloc: _editProfileBloc,
            listener: (context, state) {
              if (state is EditProfileSuccessState) {
                navigateTo(
                  const HomeNavBar(),
                );
              }
            },
            buildWhen: (previous, current) =>
                current is EditProfileSuccessState,
            builder: (context, state) {
              return AppButton(
                isLoading: state is EditProfileLoadingState,
                text: "تعديل البيانات",
                onPress: () {
                  _editProfileBloc
                      .add(PostEditProfileDataEvent(context: context));
                },
              );
            }),
      ),
    );
  }
}
