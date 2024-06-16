import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

part 'event.dart';

part 'states.dart';

class AcceptOrderBloc extends Bloc<AcceptOrderEvent, AcceptOrderStates> {
  AcceptOrderBloc(this._dioHelper) : super(AcceptOrderStates()) {
    on<StartAcceptOrderEvent>(_getData);
  }

  final DioHelper _dioHelper;

  Future<void> _getData(
      StartAcceptOrderEvent event, Emitter<AcceptOrderStates> emit) async {
    emit(LoadingAcceptState());

    final response = await _dioHelper.getFromServer(
      url: "driver/accept_order/${event.id}",
    );

    if (response.success) {
      emit(SuccessAcceptState());
    } else {
      emit(FailedAcceptState(
        msg: response.response!.statusMessage ?? "Failed",
      ));
    }
  }
}
