import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/features/account/policy/bloc.dart';
import 'package:thimar_driver/features/account/policy/events.dart';
import 'package:thimar_driver/features/account/policy/states.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  final bloc = KiwiContainer().resolve<PolicyBloc>()..add(GetPolicyDataEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "سياسة الخصوصية",
      ),
      body: Column(
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
            bloc: bloc,
            builder: (context, state) {
              if (state is GetPolicyDataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetPolicyDataSuccessState) {
                return Center(
                  child: Html(
                    data: bloc.data,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
