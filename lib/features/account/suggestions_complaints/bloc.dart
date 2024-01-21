import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import 'events.dart';
import 'states.dart';

class SuggestionsAndComplaintsBloc extends Bloc<SuggestionsAndComplaintsEvents,
    SuggestionsAndComplaintsStates> {
  SuggestionsAndComplaintsBloc(this.dioHelper)
      : super(
          SuggestionsAndComplaintsStates(),
        ) {
    on<SendDataEvent>(sendData);
  }

  final DioHelper dioHelper;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> sendData(
      SendDataEvent event, Emitter<SuggestionsAndComplaintsStates> emit) async {
    emit(
      SendDataLoadingState(),
    );

    final response = await dioHelper.sendToServer(url: "contact", body: {
      // "fullname": event.nameController.text,
      // "phone": event.phoneController.text,
      // "title": event.titleController.text,
      // "content": event.contentController.text,
      "fullname": nameController.text,
      "phone": phoneController.text,
      "title": titleController.text,
      "content": contentController.text,
    });

    if (response.success) {
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
      emit(
        SendDataSuccessState(),
      );
      nameController.clear();
      phoneController.clear();
      titleController.clear();
      contentController.clear();
    } else {
      showSnackBar(
        response.msg,
      );
      emit(
        SendDataFailedState(),
      );
    }
  }
}
