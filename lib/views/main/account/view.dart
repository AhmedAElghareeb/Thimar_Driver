import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/views/main/account/components/driver_card.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/login.dart';

import '../../../features/authentication/bloc.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final bloc = KiwiContainer().resolve<AuthenticationBloc>();

  List<String> titles = [
    "البيانات الشخصية",
    "المحفظة",
    "عن التطبيق",
    "أسئلة متكررة",
    "سياسة الخصوصية",
    "تواصل معنا",
    "الشكاوي والأقتراحات",
    "اللغة",
  ];

  List<String> icons = [
    "person.svg",
    "wallet.svg",
    "about_us.svg",
    "question.svg",
    "policy.svg",
    "contact_us.svg",
    "conditions.svg",
    "language.svg",
  ];

  // List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DriverCard(),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    // navigateTo(
                    //   pages[index],
                    // );
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 20.w,
                      end: 20.w,
                      top: 15.h,
                      bottom: 15.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/${icons[index]}",
                              width: 18.w,
                              height: 18.h,
                              fit: BoxFit.scaleDown,
                              color: getMaterialColor(),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: getMaterialColor(),
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          "assets/icons/arrow_left.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                  color: const Color(0xffF6F6F6),
                ),
                itemCount: titles.length,
              ),
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is DriverLogOutLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      bloc.add(
                        DriverLogOutEvent(),
                      );
                      navigateTo(
                        const LoginView(),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: getMaterialColor()),
                          ),
                          SvgPicture.asset(
                            "assets/icons/exit.svg",
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
