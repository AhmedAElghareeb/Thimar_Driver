import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/features/account/suggestions_complaints/bloc.dart';
import 'package:thimar_driver/features/account/suggestions_complaints/states.dart';

import '../../../features/account/suggestions_complaints/events.dart';

class SuggestionsAndComplaints extends StatefulWidget {
  const SuggestionsAndComplaints({super.key});

  @override
  State<SuggestionsAndComplaints> createState() =>
      _SuggestionsAndComplaintsState();
}

class _SuggestionsAndComplaintsState extends State<SuggestionsAndComplaints> {
  final bloc = KiwiContainer().resolve<SuggestionsAndComplaintsBloc>();

  // final event = SendDataEvent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "الأقتراحات والشكاوي",
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          children: [
            Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  AppInput(
                    controller: bloc.nameController,
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
                    controller: bloc.phoneController,
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
                    controller: bloc.titleController,
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
                    controller: bloc.contentController,
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
              bloc: bloc,
              builder: (context, state) {
                return AppButton(
                  onPress: () async {
                    if(bloc.formKey.currentState!.validate()) {
                      bloc.add(
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

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
