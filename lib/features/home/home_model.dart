class PendingOrdersData {
  late final List<PendingOrdersModel> data;
  late final Links links;
  late final Meta meta;
  late final String status;
  late final String message;

  PendingOrdersData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'] ?? [])
        .map((e) => PendingOrdersModel.fromJson(e))
        .toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class PendingOrdersModel {
  late final int id;
  late final String status;
  late final String date;
  late final String time;
  late final num orderPrice;
  late final num deliveryPrice;
  late final num? totalPrice;
  late final String phone;
  late final Address address;
  late final String payType;
  late final String? note;
  late final String clientName;
  late final String clientImage;
  late final Null city;
  late final List<Images> images;

  PendingOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    time = json['time'] ?? "";
    orderPrice = json['order_price'] ?? 0;
    deliveryPrice = json['delivery_price'] ?? 0;
    totalPrice = json['total_price'] ?? 0;
    phone = json['phone'] ?? "";
    address = Address.fromJson(json['address'] ?? {});
    payType = json['pay_type'] ?? "";
    note = null;
    clientName = json['client_name'] ?? "";
    clientImage = json['client_image'] ?? "";
    city = null;
    images =
        List.from(json['images'] ?? []).map((e) => Images.fromJson(e)).toList();
  }
}

class Address {
  late final int id;
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final num userId;
  late final num isDefault;
  late final String phone;
  late final String createdAt;
  late final String updatedAt;

  Address.fromJson(Map<String, dynamic> json) {
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

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
  }
}

class Links {
  late final String first;
  late final String last;
  late final Null prev;
  late final String next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'] ?? "";
    last = json['last'] ?? "";
    prev = null;
    next = json['next'] ?? "";
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

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    links =
        List.from(json['links'] ?? []).map((e) => Links.fromJson(e)).toList();
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }
}
