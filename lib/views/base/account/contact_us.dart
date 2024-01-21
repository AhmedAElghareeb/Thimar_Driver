import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar_driver/features/account/contact_us/events.dart';
import 'package:thimar_driver/features/account/contact_us/states.dart';
import 'package:thimar_driver/features/account/suggestions_complaints/bloc.dart';
import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../features/account/contact_us/bloc.dart';
import '../../../features/account/suggestions_complaints/events.dart';
import '../../../features/account/suggestions_complaints/states.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final contactBloc = KiwiContainer().resolve<ContactUsBloc>();
  final suggestionsBloc = KiwiContainer().resolve<SuggestionsAndComplaintsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "تواصل معنا"),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.r,
          ),
          children: [
            BlocBuilder(
              bloc: contactBloc
                ..add(
                  GetContactDataEvent(),
                ),
              builder: (context, state) {
                if(state is GetContactDataLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetContactDataSuccessState) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 198.h,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              state.data.lat,
                              state.data.lng,
                            ),
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("1"),
                              position: LatLng(
                                state.data.lat,
                                state.data.lng,
                              ),
                            ),
                          },
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 312.w,
                          margin: EdgeInsetsDirectional.only(
                            top: 170.h,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                15.r,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15.r,
                                    color: const Color(0xff000000).withOpacity(
                                      0.02,
                                    ),
                                    offset: Offset(0.w, 10.h))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/location.svg",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      state.data.location,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/contact_us.svg",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      state.data.phone,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/email.svg",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      state.data.email,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "أو يمكنك إرسال رسالة ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Form(
              key: suggestionsBloc.formKey,
              child: Column(
                children: [
                  AppInput(
                    controller: suggestionsBloc.nameController,
                    labelText: "الإسم",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  AppInput(
                    controller: suggestionsBloc.phoneController,
                    labelText: "رقم الموبايل",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  AppInput(
                    controller: suggestionsBloc.titleController,
                    labelText: "عنوان الموضوع",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  AppInput(
                    controller: suggestionsBloc.contentController,
                    labelText: "محتوى الموضوع",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      return null;
                    },
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            BlocBuilder(
              bloc: suggestionsBloc,
              builder: (context, state) {
                return AppButton(
                  onPress: () async {
                    if(suggestionsBloc.formKey.currentState!.validate()) {
                      suggestionsBloc.add(
                        SendDataEvent(),
                      );
                    }
                  },
                  isLoading: state is SendDataLoadingState,
                  text: "إرسال",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
