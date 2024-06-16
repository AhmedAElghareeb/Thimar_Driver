part of 'bloc.dart';

class RefuseOrderStates {}

class LoadingState extends RefuseOrderStates {}

class SuccessState extends RefuseOrderStates {
  SuccessState() {
    showSnackBar(
      "تم رفض الطلب",
      typ: MessageType.success,
    );
  }
}

class FailedState extends RefuseOrderStates {
  final String msg;

  FailedState({required this.msg}) {
    showSnackBar(msg);
  }
}
