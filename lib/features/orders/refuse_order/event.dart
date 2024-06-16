part of 'bloc.dart';

class RefuseOrderEvent {}

class StartRefuseOrderEvent extends RefuseOrderEvent {
  final int id;

  StartRefuseOrderEvent({required this.id});

}
