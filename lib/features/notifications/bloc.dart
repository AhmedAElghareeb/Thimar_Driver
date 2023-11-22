import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/features/notifications/events.dart';
import 'package:thimar_driver/features/notifications/states.dart';

import 'model.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  NotificationsBloc() : super(NotificationsStates()) {
    on<GetNotificationsEvent>(getData);
  }

  Future<void> getData(
      GetNotificationsEvent event, Emitter<NotificationsStates> emit) async {
    emit(NotificationsLoadingState());

    final response = await DioHelper().getFromServer(
      url: "notifications",
    );

    if (response.success) {
      final data = DriverNotificationData.fromJson(response.response!.data)
          .data
          .notifications;
      emit(
        NotificationsSuccessState(
          notifications: data,
        ),
      );
    } else {
      emit(NotificationsFailedState());
    }
  }
}
