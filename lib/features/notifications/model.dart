class DriverNotificationData {
  late final Data data;
  late final Links links;
  late final Meta meta;
  late final String status;
  late final String message;

  DriverNotificationData.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  late final int unreadnotificationsCount;
  late final List<NotificationsModel> notifications;

  Data.fromJson(Map<String, dynamic> json){
    unreadnotificationsCount = json['unreadnotifications_count'];
    notifications = List.from(json['notifications']).map((e)=>NotificationsModel.fromJson(e)).toList();
  }
}

class NotificationsModel {
  late final String id;
  late final String title;
  late final String body;
  late final String notifyType;
  late final Order order;
  late final Null offer;
  late final Null chat;
  late final String createdAt;
  late final String? readAt;
  late final String image;

  NotificationsModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? "";
    title = json['title'] ?? "";
    body = json['body'] ?? "";
    notifyType = json['notify_type'] ?? "";
    order = Order.fromJson(json['order']);
    offer = null;
    chat = null;
    createdAt = json['created_at'] ?? "";
    readAt = null;
    image = json['image'] ?? "";
  }
}

class Order {
  late final num orderId;
  late final num clientId;
  late final num? driverId;
  late final Null orderType;
  late final String orderStatus;

  Order.fromJson(Map<String, dynamic> json){
    orderId = json['order_id'] ?? 0;
    clientId = json['client_id'] ?? 0;
    driverId = null;
    orderType = null;
    orderStatus = json['order_status'] ?? "";
  }
}

class Links {
  late final String first;
  late final String last;
  late final Null prev;
  late final Null next;

  Links.fromJson(Map<String, dynamic> json){
    first = json['first'] ?? "";
    last = json['last'] ?? "";
    prev = null;
    next = null;
  }
}

class Meta {
  late final num currentPage;
  late final num from;
  late final num lastPage;
  late final List<Links> links;
  late final String path;
  late final num perPage;
  late final num to;
  late final num total;

  Meta.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'] ?? 0;
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    links = List.from(json['links'] ?? []).map((e)=>Links.fromJson(e)).toList();
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }
}