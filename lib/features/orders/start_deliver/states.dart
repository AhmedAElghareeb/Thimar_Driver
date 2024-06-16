part of 'bloc.dart';

class StartDeliverStates {}

class LoadingStartDeliverState extends StartDeliverStates {}

class SuccessStartDeliverState extends StartDeliverStates {
  final String msg;

  SuccessStartDeliverState({required this.msg}) {
    showSnackBar(msg, typ: MessageType.success);
  }
}

class FailedStartDeliverState extends StartDeliverStates {
  final String msg;

  FailedStartDeliverState({required this.msg}) {
    showSnackBar(msg);
  }
}
