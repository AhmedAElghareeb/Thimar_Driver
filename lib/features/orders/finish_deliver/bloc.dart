import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

part 'event.dart';

part 'states.dart';

class FinishDeliverBloc extends Bloc<FinishDeliverEvents, FinishDeliverStates> {
  FinishDeliverBloc(this._dioHelper) : super(FinishDeliverStates()) {
    on<FinishDeliverEvent>(_getDeliver);
  }

  final DioHelper _dioHelper;

  final clientPaidAmount = TextEditingController();

  Future<void> _getDeliver(
      FinishDeliverEvent event, Emitter<FinishDeliverStates> emit) async {
    emit(LoadingFinishDeliverState());

    final response = await _dioHelper
        .getFromServer(url: "driver/finish_order/${event.id}", params: {
      "client_paid_amount": clientPaidAmount.text,
    });

    if (response.success) {
      emit(
        SuccessFinishDeliverState(
            msg: response.response!.statusMessage ?? "يتم الآن توصيل الطلب"),
      );
    } else {
      emit(
        FailedFinishDeliverState(
            msg: response.response!.statusMessage ?? "Failed"),
      );
    }
  }
}
