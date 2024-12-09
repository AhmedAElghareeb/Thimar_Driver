import 'package:flutter/material.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
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

class DriverResetPasswordLoadingState extends AuthenticationStates {}

class DriverResetPasswordSuccessState extends AuthenticationStates {}

class DriverResetPasswordFailedState extends AuthenticationStates {}

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

class CheckCodeLoadingState extends AuthenticationStates {}

class CheckCodeSuccessState extends AuthenticationStates {
  final String message;
  final BuildContext context;

  CheckCodeSuccessState({required this.message,required this.context}){
    showSnackBar(message,typ: MessageType.success);
  }
}

class CheckCodeErrorState extends AuthenticationStates {
  final String message ;
  final int statueCode;
  final BuildContext context;

  CheckCodeErrorState({required this.message, required this.statueCode,required  this.context}){
    showSnackBar(message,typ: MessageType.fail);
  }
}

class ResendCodeLoadingState extends AuthenticationStates {}

class ResendCodeSuccessState extends AuthenticationStates {
  final String message;
  final BuildContext context;
  ResendCodeSuccessState({required this.message,required this.context}) {
    // Toast.show(message,context);
  }
}

class ResendCodeErrorState extends AuthenticationStates {
  final String message;
  final int statusCode;
  final BuildContext context;
  ResendCodeErrorState({required this.message, required this.statusCode,required this.context }){
    // Toast.show(message,context,messageType: MessageType.error);

  }
}

class EditProfileLoadingState extends AuthenticationStates {}

class EditProfileSuccessState extends AuthenticationStates {
  final BuildContext context;
  final  String message;
  final  String? image;

  EditProfileSuccessState({required this.context, required this.message,required this.image}){
    showSnackBar('تم التعديل بنجاح', typ: MessageType.success);
    debugPrint(image??"image is null");
    if(image!=null) {
      CacheHelper.setImage(image!);
    }
  }
}

class EditProfileErrorState extends AuthenticationStates {
  final BuildContext context;
  final  String message;
  final int statusCode;
  EditProfileErrorState({required this.context, required this.message, required this.statusCode}){
    showSnackBar(message, typ: MessageType.fail);
  }

}
