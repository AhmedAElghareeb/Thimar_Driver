import 'package:flutter/material.dart';

class AuthenticationEvents {}

class GetCitiesDataEvent extends AuthenticationEvents {}
class GetCarsDataEvent extends AuthenticationEvents {}

class DriverLoginEvent extends AuthenticationEvents {}

class DriverRegisterEvent extends AuthenticationEvents {
  final BuildContext context;
  final String name, phone, location, id, email, password, confirmPassword;

  DriverRegisterEvent(
      {required this.context,
      required this.name,
      required this.phone,
      required this.location,
      required this.id,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class DriverForgetPasswordEvent extends AuthenticationEvents {}

class DriverLogOutEvent extends AuthenticationEvents {}

class GetProfileDataEvent extends AuthenticationEvents{}