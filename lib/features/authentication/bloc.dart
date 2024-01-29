import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';
import 'city_model.dart';
import 'events.dart';
import 'states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc(this.dioHelper) : super(AuthenticationStates()) {
    on<GetCitiesDataEvent>(cities);
    on<DriverLoginEvent>(login);
    on<DriverRegisterEvent>(register);
    on<DriverForgetPasswordEvent>(forgetPassword);
    on<DriverLogOutEvent>(logOut);
  }

  File? licenseImage, carFormImage, carInsurance, frontCarImage, backCarImage;

  late int modelId, cityId;

  CityModel? selectedCity;

  final phController = TextEditingController();
  final passController = TextEditingController();
  final fullNameController = TextEditingController();
  final identityNumberController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPassController = TextEditingController();
  final iBanController = TextEditingController();
  final bankNameController = TextEditingController();
  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();

  final DioHelper dioHelper;
  final formKey = GlobalKey<FormState>();

  Future<void> cities(
      GetCitiesDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      GetCitiesDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "cities/1",
    );

    if (response.success) {
      final list = List.from(response.response!.data['data'] ?? [])
          .map((e) => CityModel.fromJson(e))
          .toList();
      emit(
        GetCitiesDataSuccessState(
          list: list,
        ),
      );
    } else {
      emit(
        GetCitiesDataFailedState(),
      );
    }
  }

  Future<void> login(
      DriverLoginEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      DriverLoginLoadingState(),
    );

    final response = await dioHelper.sendToServer(url: "login", body: {
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
        "phone": phController.text,
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

  Future<void> register(
      DriverRegisterEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      DriverRegisterLoadingState(),
    );

    final response = await dioHelper.sendToServer(
      url: "driver_register",
      body: {
        "fullname": fullNameController.text,
        "phone": phController.text,
        "city_id": selectedCity!.id,
        "lat": "",
        "lng": "",
        "location": "",
        "identity_number": identityNumberController.text,
        "email": emailController.text,
        "password": passController.text,
        "password_confirmation": confirmPassController.text,
        "car_licence_image": MultipartFile.fromFileSync(
          licenseImage!.path,
          filename: licenseImage!.path.split("/").last,
        ),
        "car_form_image": MultipartFile.fromFileSync(
          carFormImage!.path,
          filename: carFormImage!.path.split("/").last,
        ),
        "car_insurance_image": MultipartFile.fromFileSync(
          carInsurance!.path,
          filename: carInsurance!.path.split("/").last,
        ),
        "car_front_image": MultipartFile.fromFileSync(
          frontCarImage!.path,
          filename: frontCarImage!.path.split("/").last,
        ),
        "car_back_image": MultipartFile.fromFileSync(
          backCarImage!.path,
          filename: backCarImage!.path.split("/").last,
        ),
        "car_type": carTypeController.text,
        "model_id": carModelController.text,
        "iban": iBanController.text,
        "bank_name": bankNameController.text,
      },
    );

    if (response.success) {
      emit(
        DriverRegisterSuccessState(
          msg: response.msg,
        ),
      );
    } else {
      emit(
        DriverRegisterFailedState(
          msg: response.msg,
        ),
      );
    }
  }
}
