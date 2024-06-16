class OrderDetailsData {
  late final String status;
  late final String message;
  late final OrderDetailsModel data;

  OrderDetailsData.fromJson(Map<String, dynamic> json){
    status = json['status'] ?? "";
    message = json['message'] ?? "";
    data = OrderDetailsModel.fromJson(json['data']);
  }
}

class OrderDetailsModel {
  late final int id;
  late final String status;
  late final String date;
  late final String time;
  late final num orderPrice;
  late final num deliveryPrice;
  late final num totalPrice;
  late final String clientName;
  late final String clientImage;
  late final String phone;
  late final Address address;
  late final String location;
  late final List<Images> images;
  late final String payType;
  late final String note;

  OrderDetailsModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    time = json['time'] ?? "";
    orderPrice = json['order_price'] ?? 0;
    deliveryPrice = json['delivery_price'] ?? 0;
    totalPrice = json['total_price'] ?? 0;
    clientName = json['client_name'] ?? "";
    clientImage = json['client_image'] ?? "";
    phone = json['phone'] ?? "";
    address = Address.fromJson(json['address'] ?? {});
    location = json['location'] ?? "";
    images = List.from(json['images'] ?? []).map((e)=>Images.fromJson(e)).toList();
    payType = json['pay_type'] ?? "";
    note = json['note'] ?? "";
  }
}

class Address {
  late final int id;
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final int userId;
  late final int isDefault;
  late final String phone;
  late final String createdAt;
  late final String updatedAt;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    type = json['type'] ?? "";
    lat = json['lat'] ?? 0;
    lng = json['lng'] ?? 0;
    location = json['location'] ?? "";
    description = json['description'] ?? "";
    userId = json['user_id'] ?? 0;
    isDefault = json['is_default'] ?? 0;
    phone = json['phone'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json){
    name = json['name'] ?? "";
    url = json['url'] ?? "";
  }
}