import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/driver_card.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/login.dart';

import '../../../core/design/account_widgets.dart';
import '../../../features/authentication/bloc.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final bloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DriverCard(),
            AccountWidgets(
              onPress: () {},
              title: "البيانات الشخصية",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "المحفظة",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "عن التطبيق",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "أسئلة متكررة",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "سياسة الخصوصية",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "تواصل معنا",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "تغيير اللغة",
              imageName: "person.svg",
            ),
            AccountWidgets(
              onPress: () {},
              title: "الشكاوي والأقتراحات",
              imageName: "person.svg",
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
                              color: Theme.of(context).primaryColor
                            ),
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
