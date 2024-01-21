import 'home_model.dart';
import 'search_model.dart';

class HomeStates {}

class GetSearchDataSuccessState extends HomeStates {
  final List<HomeSearchModel> data;

  GetSearchDataSuccessState({required this.data});
}

class GetPendingOrdersDataLoadingState extends HomeStates {}

class GetPendingOrdersDataSuccessState extends HomeStates {
  final List<PendingOrdersModel> data;

  GetPendingOrdersDataSuccessState({required this.data});
}

class GetPendingOrdersDataFailedState extends HomeStates {}
