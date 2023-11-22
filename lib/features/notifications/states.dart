import 'model.dart';

class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  final List<NotificationsModel> notifications;

  NotificationsSuccessState({required this.notifications});
}

class NotificationsFailedState extends NotificationsStates {}
