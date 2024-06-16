part of 'bloc.dart';

class FinishDeliverEvents {}

class FinishDeliverEvent extends FinishDeliverEvents {
  final int id;

  FinishDeliverEvent({required this.id});
}
