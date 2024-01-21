part 'model.dart';

class ContactUsStates {}

class GetContactDataLoadingState extends ContactUsStates {}

class GetContactDataSuccessState extends ContactUsStates {
  final ContactUsModel data;

  GetContactDataSuccessState({required this.data});
}

class GetContactDataFailedState extends ContactUsStates {}

