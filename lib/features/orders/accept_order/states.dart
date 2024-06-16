part of 'bloc.dart';

class AcceptOrderStates {}

class LoadingAcceptState extends AcceptOrderStates {}

class SuccessAcceptState extends AcceptOrderStates {
  SuccessAcceptState() {
    showSnackBar(
      "تم قبول الطلب",
      typ: MessageType.success,
    );
  }
}

class FailedAcceptState extends AcceptOrderStates {
  final String msg;

  FailedAcceptState({required this.msg}) {
    showSnackBar(msg);
  }
}
