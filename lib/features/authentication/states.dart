class AuthenticationStates {}

class DriverLoginLoadingState extends AuthenticationStates {}

class DriverLoginSuccessState extends AuthenticationStates {
  final String msg;

  DriverLoginSuccessState({required this.msg});
}

class DriverLoginFailedState extends AuthenticationStates {}
