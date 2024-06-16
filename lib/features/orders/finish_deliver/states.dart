part of 'bloc.dart';

class FinishDeliverStates {}

class LoadingFinishDeliverState extends FinishDeliverStates {}

class SuccessFinishDeliverState extends FinishDeliverStates {
  final String msg;

  SuccessFinishDeliverState({required this.msg}) {
    showSnackBar(msg, typ: MessageType.success);
  }
}

class FailedFinishDeliverState extends FinishDeliverStates {
  final String msg;

  FailedFinishDeliverState({required this.msg}) {
    showSnackBar(msg);
  }
}
