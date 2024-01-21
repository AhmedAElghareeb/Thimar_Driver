import 'package:flutter/material.dart';

class AuthenticationEvents {}

class DriverLoginEvent extends AuthenticationEvents {
  TextEditingController phController = TextEditingController(
    // text: "966541236423",
  );
  TextEditingController passController = TextEditingController(
    // text: "123456789",
  );
}

class DriverForgetPasswordEvent extends AuthenticationEvents {
  TextEditingController phController = TextEditingController();
}

class DriverLogOutEvent extends AuthenticationEvents {}
