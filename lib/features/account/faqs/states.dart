import 'model.dart';

class FaqsStates {}

class GetFaqsDataLoadingState extends FaqsStates {}

class GetFaqsDataSuccessState extends FaqsStates {
  final List<FaqsModel> data;

  GetFaqsDataSuccessState({required this.data});
}

class GetFaqsDataFailedState extends FaqsStates {}
