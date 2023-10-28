import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';
import 'events.dart';
import 'states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc() : super(AuthenticationStates()) {
    on<DriverLoginEvent>(driverLogin);
  }

  final formKey = GlobalKey<FormState>();
  final phController = TextEditingController(
    text: "966541236423",
  );
  final passController = TextEditingController(
    text: "123456789",
  );

  Future<void> driverLogin(
      DriverLoginEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      DriverLoginLoadingState(),
    );

    final response = await DioHelper().sendToServer(url: "login", body: {
      "phone": phController.text,
      "password": passController.text,
      "device_token": "test",
      "type": Platform.operatingSystem,
      "user_type": "driver",
      "lat": "",
      "lng": "",
    });

    if (response.success) {
      await CacheHelper.saveLoginData(
        DriverModel.fromJson(response.response!.data['data'],),
      );
      showSnackBar(
        "تم تسجيل الدخول بنجاح",
        typ: MessageType.success,
      );
      emit(
        DriverLoginSuccessState(),
      );
    } else {
      emit(
        DriverLoginFailedState(),
      );
    }
  }
}
