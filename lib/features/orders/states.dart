import 'model.dart';

class OrdersStates {}

class GetOrdersDataLoadingState extends OrdersStates {}

class GetOrdersDataSuccessState extends OrdersStates {
  final List<DriverOrdersModel> data;

  GetOrdersDataSuccessState({required this.data});
}

class GetOrdersDataFailedState extends OrdersStates {}
