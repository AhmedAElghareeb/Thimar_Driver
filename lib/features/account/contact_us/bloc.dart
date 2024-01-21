import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'events.dart';
import 'states.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ContactUsStates> {
  ContactUsBloc(this.dioHelper) : super(ContactUsStates()) {
    on<GetContactDataEvent>(getData);
  }

  final DioHelper dioHelper;

  Future<void> getData(
      GetContactDataEvent event, Emitter<ContactUsStates> emit) async {
    emit(
      GetContactDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "contact",
    );

    if (response.success) {
      final data = ContactUsData.fromJson(response.response!.data);
      emit(
        GetContactDataSuccessState(
          data: data.data,
        ),
      );
    } else {
      emit(
        GetContactDataFailedState(),
      );
    }
  }
}
