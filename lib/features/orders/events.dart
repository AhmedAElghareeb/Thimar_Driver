class OrdersEvents{}

class GetOrdersDataEvent extends OrdersEvents{
  final String type;

  GetOrdersDataEvent({required this.type});
}

class GetSearchData extends OrdersEvents {
  final String keyWord;

  GetSearchData({required this.keyWord});
}