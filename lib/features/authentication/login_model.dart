class DriverData {
  late final DriverModel data;
  late final String status;
  late final String message;

  DriverData.fromJson(Map<String, dynamic> json){
    data = DriverModel.fromJson(json['data']);
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class DriverModel {
  late final int id;
  late final String fullname;
  late final String phone;
  late final String email;
  late final String image;
  late final int isBan;
  late final bool isActive;
  late final int unreadNotifications;
  late final String userType;
  late final String token;
  late final City city;
  late final String identityNumber;
  late final int userCartCount;

  DriverModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    fullname = json['fullname'] ?? "";
    phone = json['phone'] ?? "";
    email = json['email'] ?? "";
    image = json['image'] ?? "";
    isBan = json['is_ban'] ?? 0;
    isActive = json['is_active'] ?? false;
    unreadNotifications = json['unread_notifications'] ?? 0;
    userType = json['user_type'] ?? "";
    token = json['token'] ?? "";
    city = City.fromJson(json['city'] ?? []);
    identityNumber = json['identity_number'] ?? "";
    userCartCount = json['user_cart_count'] ?? 0;
  }
}

class City {
  late final String id;
  late final String name;

  City.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }
}