import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'events.dart';
import 'states.dart';

class PolicyBloc extends Bloc<PolicyEvents, PolicyStates> {
  PolicyBloc(this.dioHelper) : super(PolicyStates()) {
    on<GetPolicyDataEvent>(getData);
  }

  final DioHelper dioHelper;

  var data;

  Future<void> getData(
      GetPolicyDataEvent event, Emitter<PolicyStates> emit) async {
    emit(
      GetPolicyDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "policy",
    );

    if (response.success) {
      data = response.response!.data["data"]["policy"];
      emit(
        GetPolicyDataSuccessState(),
      );
    } else {
      emit(
        GetPolicyDataFailedState(),
      );
    }
  }
}
