part of 'bloc.dart';

class AcceptOrderEvent {}

class StartAcceptOrderEvent extends AcceptOrderEvent {
  final int id;

  StartAcceptOrderEvent({required this.id});
}