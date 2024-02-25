import 'package:flutter/material.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/cars_model.dart';
import 'package:thimar_driver/features/authentication/profile_model.dart';

import 'city_model.dart';

class AuthenticationStates {}

class GetCitiesDataLoadingState extends AuthenticationStates {}

class GetCitiesDataSuccessState extends AuthenticationStates {
  final List<CityModel> list;

  GetCitiesDataSuccessState({required this.list});
}

class GetCitiesDataFailedState extends AuthenticationStates {}

class GetCarsDataLoadingState extends AuthenticationStates {}

class GetCarsDataSuccessState extends AuthenticationStates {
  final List<CarsModel> data;

  GetCarsDataSuccessState({required this.data});
}

class GetCarsDataFailedState extends AuthenticationStates {}


class DriverLoginLoadingState extends AuthenticationStates {}

class DriverLoginSuccessState extends AuthenticationStates {}

class DriverLoginFailedState extends AuthenticationStates {}

class DriverRegisterLoadingState extends AuthenticationStates {}

class DriverRegisterSuccessState extends AuthenticationStates {
  final String msg;
  final BuildContext context;

  DriverRegisterSuccessState({required this.msg, required this.context}) {
    showSnackBar(msg, typ: MessageType.success);
  }
}

class DriverRegisterFailedState extends AuthenticationStates {
  final String msg;
  final BuildContext context;

  DriverRegisterFailedState({required this.msg, required this.context}) {
    showSnackBar(msg);
  }
}

class DriverForgetPasswordLoadingState extends AuthenticationStates {}

class DriverForgetPasswordSuccessState extends AuthenticationStates {}

class DriverForgetPasswordFailedState extends AuthenticationStates {}

class DriverLogOutLoadingState extends AuthenticationStates {}

class DriverLogOutSuccessState extends AuthenticationStates {}

class DriverLogOutFailedState extends AuthenticationStates {}

class GetProfileLoadingState extends AuthenticationStates {}

class GetProfileSuccessState extends AuthenticationStates {
  ProfileData data;

  GetProfileSuccessState({required this.data});
}

class GetProfileErrorState extends AuthenticationStates {
  final String message;

  GetProfileErrorState({required this.message});
}
