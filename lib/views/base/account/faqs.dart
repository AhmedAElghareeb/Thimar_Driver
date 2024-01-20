import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/features/account/faqs/events.dart';
import 'package:thimar_driver/features/account/faqs/states.dart';

import '../../../features/account/faqs/bloc.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  final bloc = KiwiContainer().resolve<FaqsBloc>()
    ..add(
      GetFaqsDataEvent(),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "أسئلة متكررة",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(
            16.r,
          ),
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is GetFaqsDataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetFaqsDataSuccessState) {
                return ListView.builder(
                  itemBuilder: (context, index) => ExpansionTile(
                    title: Text(
                      state.data[index].question,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          11.r,
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        )),
                    collapsedIconColor: Theme.of(context).primaryColor,
                    children: [
                      Text(
                        state.data[index].answer,
                      ),
                    ],
                  ),
                  itemCount: state.data.length,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
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
