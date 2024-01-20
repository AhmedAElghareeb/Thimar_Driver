import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:thimar_driver/features/account/about_app/bloc.dart';
import 'package:thimar_driver/features/account/about_app/events.dart';
import 'package:thimar_driver/features/account/about_app/states.dart';
import '../../../core/design/app_bar.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  final bloc = KiwiContainer().resolve<AboutAppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "عن التطبيق",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/center.svg",
                width: 160.w,
                height: 157.h,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            BlocBuilder(
              bloc: bloc
                ..add(
                  GetAboutAppDataEvent(),
                ),
              builder: (context, state) {
                if(state is GetAboutAppDataLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetAboutAppDataSuccessState) {
                  return Html(
                    data: bloc.data,
                  );
                } else {
                  return const SizedBox.shrink();
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
