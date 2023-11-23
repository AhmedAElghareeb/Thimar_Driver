class OrdersEvents{}

class GetOrdersDataEvent extends OrdersEvents{
  final String type;

  GetOrdersDataEvent({required this.type});
}