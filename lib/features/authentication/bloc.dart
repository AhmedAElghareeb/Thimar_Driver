import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/cars_model.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';
import 'package:thimar_driver/features/authentication/profile_model.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';
import 'city_model.dart';
import 'events.dart';
import 'states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc(this.dioHelper) : super(AuthenticationStates()) {
    on<GetCitiesDataEvent>(cities);
    on<GetCarsDataEvent>(cars);
    on<DriverLoginEvent>(login);
    on<DriverRegisterEvent>(register);
    on<DriverForgetPasswordEvent>(forgetPassword);
    on<DriverLogOutEvent>(logOut);
    on<GetProfileDataEvent>(getProfileData);
  }

  File? licenseImage, carFormImage, carInsurance, frontCarImage, backCarImage;

  CityModel? selectedCity;
  CarsModel? selectedCar;

  final phController = TextEditingController();
  final passController = TextEditingController();
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

  Future<void> cars(
      GetCarsDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      GetCarsDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "car_models",
    );

    if (response.success) {

      final list = CarsData.fromJson(response.response!.data);

      emit(
        GetCarsDataSuccessState(
          data: list.data,
        ),
      );
    } else {
      emit(
        GetCarsDataFailedState(),
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
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
      "user_type": "driver",
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
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
    });

    if (response.success) {
      CacheHelper.removeLoginInfo();
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
        "fullname": event.name,
        "phone": event.phone,
        "city_id": selectedCity!.id,
        "lat": CacheHelper.getLat(),
        "lng": CacheHelper.getLongitude(),
        "location": "",
        "identity_number": event.id,
        "email": event.email,
        "password": event.password,
        "password_confirmation": event.confirmPassword,
        "car_licence_image": dioHelper.getMultiPartImage(licenseImage!.path),
        "car_form_image": dioHelper.getMultiPartImage(carFormImage!.path),
        "car_insurance_image": dioHelper.getMultiPartImage(carInsurance!.path),
        "car_front_image": dioHelper.getMultiPartImage(frontCarImage!.path),
        "car_back_image": dioHelper.getMultiPartImage(backCarImage!.path),
        "car_type": carTypeController.text,
        "model_id": selectedCar!.id,
        "iban": iBanController.text,
        "bank_name": bankNameController.text,
      },
    );

    if (response.success) {
      emit(
        DriverRegisterSuccessState(
          context: event.context,
          msg: response.msg,
        ),
      );
    } else {
      emit(
        DriverRegisterFailedState(
          context: event.context,
          msg: response.msg,
        ),
      );
    }
  }

  void getProfileData(
      GetProfileDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(GetProfileLoadingState());

    final response = await dioHelper.getFromServer(
      url: "driver/profile",
    );
    final data = ProfileData.fromJson(response.response!.data);
    if (response.success) {
      emit(
        GetProfileSuccessState(
          data: data,
        ),
      );
    } else {
      emit(
        GetProfileErrorState(
          message: response.msg,
        ),
      );
    }
  }
}
