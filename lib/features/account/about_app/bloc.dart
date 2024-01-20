import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'events.dart';
import 'states.dart';

class AboutAppBloc extends Bloc<AboutAppEvents, AboutAppStates> {
  AboutAppBloc(this.dioHelper) : super(AboutAppStates()) {
    on<GetAboutAppDataEvent>(getData);
  }

  final DioHelper dioHelper;

  var data;
  Future<void> getData(
      GetAboutAppDataEvent event, Emitter<AboutAppStates> emit) async {
    emit(
      GetAboutAppDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "about",
    );

    if (response.success) {
      data = response.response!.data["data"]["about"];
      emit(
        GetAboutAppDataSuccessState(),
      );
    } else {
      emit(
        GetAboutAppDataFailedState(),
      );
    }
  }
}
