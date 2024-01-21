class HomeEvents {}

class GetSearchDataEvent extends HomeEvents {
  final String keyWord;

  GetSearchDataEvent({required this.keyWord});
}

class GetPendingOrdersDataEvent extends HomeEvents {}
