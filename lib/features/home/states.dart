import 'search_model.dart';

class HomeStates {}

class GetSearchDataSuccessState extends HomeStates {
  final List<HomeSearchModel> data;

  GetSearchDataSuccessState({required this.data});
}