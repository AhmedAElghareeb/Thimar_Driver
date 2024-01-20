import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/features/account/faqs/model.dart';
import 'events.dart';
import 'states.dart';

class FaqsBloc extends Bloc<FaqsEvents, FaqsStates> {
  FaqsBloc(this.dioHelper) : super(FaqsStates()) {
    on<GetFaqsDataEvent>(getData);
  }

  final DioHelper dioHelper;

  Future<void> getData(GetFaqsDataEvent event, Emitter<FaqsStates> emit) async {
    emit(
      GetFaqsDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "faqs",
    );

    if (response.success) {
      final data = FaqsData.fromJson(response.response!.data);
      emit(
        GetFaqsDataSuccessState(
          data: data.data,
        ),
      );
    } else {
      emit(
        GetFaqsDataFailedState(),
      );
    }
  }
}
