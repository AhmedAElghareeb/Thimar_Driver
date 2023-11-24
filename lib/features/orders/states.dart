import 'model.dart';
import 'search_model.dart';

class OrdersStates {}

class GetOrdersDataLoadingState extends OrdersStates {}

class GetOrdersDataSuccessState extends OrdersStates {
  final List<DriverOrdersModel> data;

  GetOrdersDataSuccessState({required this.data});
}

class GetOrdersDataFailedState extends OrdersStates {}

class GetSearchDataSuccessState extends OrdersStates{
  final List<OrderSearchModel> data;

  GetSearchDataSuccessState({required this.data});
}

class GetSearchDataFailedState extends OrdersStates {}
