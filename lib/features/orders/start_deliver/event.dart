part of 'bloc.dart';

class StartDeliverEvent {}

class FirstStartDeliver extends StartDeliverEvent {
  final int id;

  FirstStartDeliver({required this.id});
}
