import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

part 'event.dart';

part 'states.dart';

class RefuseOrderBloc extends Bloc<RefuseOrderEvent, RefuseOrderStates> {
  RefuseOrderBloc(this._dioHelper)
      : super(
          RefuseOrderStates(),
        ) {
    on<StartRefuseOrderEvent>(_getData);
  }

  final DioHelper _dioHelper;

  Future<void> _getData(
      StartRefuseOrderEvent event, Emitter<RefuseOrderStates> emit) async {
    emit(
      LoadingState(),
    );
    final response = await _dioHelper.getFromServer(
      url: "driver/refuse_order/${event.id}",
    );
    if (response.success) {
      emit(
        SuccessState(),
      );
    } else {
      emit(
        FailedState(
          msg: response.response!.statusMessage ?? "Failed",
        ),
      );
    }
  }
}
