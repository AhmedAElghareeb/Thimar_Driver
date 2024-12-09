import 'package:flutter/material.dart';
import 'package:thimar_driver/features/authentication/city_model.dart';

class AuthenticationEvents {}

class GetCitiesDataEvent extends AuthenticationEvents {}

class GetCarsDataEvent extends AuthenticationEvents {}

class DriverLoginEvent extends AuthenticationEvents {}

class PostCheckCodeDataEvent extends AuthenticationEvents {
  final BuildContext context;
  final String phone;

  PostCheckCodeDataEvent({required this.context, required this.phone});
}

class PostResendCodeDataEvent extends AuthenticationEvents {
  final String phone;
  final BuildContext context;

  PostResendCodeDataEvent({required this.phone, required this.context});
}

class DriverRegisterEvent extends AuthenticationEvents {
  final BuildContext context;
  final String name, phone, location, id, email, password, confirmPassword;
  final CityModel cityId;

  DriverRegisterEvent(
      {required this.context,
      required this.cityId,
      required this.name,
      required this.phone,
      required this.location,
      required this.id,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class PostEditProfileDataEvent extends AuthenticationEvents {
  final BuildContext context;

  // final String name, phone, location, id, email;
  //
  PostEditProfileDataEvent({
    required this.context,
    // required this.name,
    // required this.phone,
    // required this.location,
    // required this.id,
    // required this.email
  });
}

class DriverForgetPasswordEvent extends AuthenticationEvents {}

class DriverResetPasswordEvent extends AuthenticationEvents {
  final String phone, newPassword;

  DriverResetPasswordEvent({
    required this.phone,
    required this.newPassword,
  });
}

class DriverLogOutEvent extends AuthenticationEvents {}

class GetProfileDataEvent extends AuthenticationEvents {}
