import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';
import 'package:thimar_driver/views/main/home_nav_bar.dart';
import 'events.dart';
import 'states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc() : super(AuthenticationStates()) {
    on<DriverLoginEvent>(login);
    on<DriverForgetPasswordEvent>(forgetPassword);
    on<DriverLogOutEvent>(logOut);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> login(
      DriverLoginEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      DriverLoginLoadingState(),
    );

    final response = await DioHelper().sendToServer(url: "login", body: {
      "phone": event.phController.text,
      "password": event.passController.text,
      "device_token": "test",
      "type": Platform.operatingSystem,
      "user_type": "driver",
      "lat": "",
      "lng": "",
    });

    if (response.success) {
      await CacheHelper.saveLoginData(
        DriverModel.fromJson(
          response.response!.data['data'],
        ),
      );
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
      navigateTo(
        const HomeNavBar(),
      );
      emit(
        DriverLoginSuccessState(),
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(
        DriverLoginFailedState(),
      );
    }
  }

  Future<void> logOut(
      DriverLogOutEvent event, Emitter<AuthenticationStates> emit) async {
    emit(DriverLogOutLoadingState());
    final response = await DioHelper().sendToServer(url: "logout", body: {
      "device_token": "test",
      "type": Platform.operatingSystem,
    });

    if (response.success) {
      CacheHelper.removeLoginData();
      emit(DriverLogOutSuccessState());
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(DriverLogOutFailedState());
    }
  }

  Future<void> forgetPassword(DriverForgetPasswordEvent event,
      Emitter<AuthenticationStates> emit) async {
    emit(
      DriverForgetPasswordLoadingState(),
    );

    final response = await DioHelper().sendToServer(
      url: "forget_password",
      body: {
        "phone": event.phController,
      },
    );

    if (response.success) {
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
      emit(
        DriverForgetPasswordSuccessState(),
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(
        DriverForgetPasswordFailedState(),
      );
    }
  }
}
