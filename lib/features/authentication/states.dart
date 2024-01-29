import 'package:thimar_driver/core/logic/helper_methods.dart';

import 'city_model.dart';

class AuthenticationStates {}

class GetCitiesDataLoadingState extends AuthenticationStates {}

class GetCitiesDataSuccessState extends AuthenticationStates {
  final List<CityModel> list;

  GetCitiesDataSuccessState({required this.list});
}

class GetCitiesDataFailedState extends AuthenticationStates {}

class DriverLoginLoadingState extends AuthenticationStates {}

class DriverLoginSuccessState extends AuthenticationStates {}

class DriverLoginFailedState extends AuthenticationStates {}

class DriverRegisterLoadingState extends AuthenticationStates {}

class DriverRegisterSuccessState extends AuthenticationStates {
  final String msg;

  DriverRegisterSuccessState({required this.msg}) {
    showSnackBar(msg, typ: MessageType.success);
  }
}

class DriverRegisterFailedState extends AuthenticationStates {
  final String msg;

  DriverRegisterFailedState({required this.msg}) {
    showSnackBar(msg);
  }
}

class DriverForgetPasswordLoadingState extends AuthenticationStates {}

class DriverForgetPasswordSuccessState extends AuthenticationStates {}

class DriverForgetPasswordFailedState extends AuthenticationStates {}

class DriverLogOutLoadingState extends AuthenticationStates {}

class DriverLogOutSuccessState extends AuthenticationStates {}

class DriverLogOutFailedState extends AuthenticationStates {}
