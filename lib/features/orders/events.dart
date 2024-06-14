class OrdersEvents{}

class GetOrdersDataEvent extends OrdersEvents{
  final String type;

  GetOrdersDataEvent({required this.type});
}

class GetSearchData extends OrdersEvents {
  final String keyWord;

  GetSearchData({required this.keyWord});
}

class GetOrderDetailsDataEvent extends OrdersEvents{
  final int id;

  GetOrderDetailsDataEvent(this.id);
}