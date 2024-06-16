import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

part 'event.dart';

part 'states.dart';

class StartDeliverBloc extends Bloc<StartDeliverEvent, StartDeliverStates> {
  StartDeliverBloc(this._dioHelper) : super(StartDeliverStates()) {
    on<FirstStartDeliver>(_getDeliver);
  }

  final DioHelper _dioHelper;

  Future<void> _getDeliver(
      FirstStartDeliver event, Emitter<StartDeliverStates> emit) async {
    emit(LoadingStartDeliverState());

    final response = await _dioHelper.getFromServer(
      url: "driver/start_delivering_order/${event.id}",
    );

    if (response.success) {
      emit(
        SuccessStartDeliverState(
            msg: response.response!.statusMessage ?? "يتم الآن توصيل الطلب"),
      );
    } else {
      emit(
        FailedStartDeliverState(
            msg: response.response!.statusMessage ?? "Failed"),
      );
    }
  }
}
