import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getToken() {
    return _prefs.getString("token") ?? "";
  }

  static Future<bool> saveImageProfile(String url) async {
    return await _prefs.setString("image", url);
  }

  static String getImage() {
    return _prefs.getString("image") ?? "https://thimar.amr.aait-d.com/public/dashboardAssets/images/backgrounds/avatar.jpg";
  }

  static Future setImage(String path) async {
    await _prefs.setString("image", path);
  }

  static String getCurrentLocationName() {
    return _prefs.getString("currentLocationName") ?? "مدينتك";
  }

  static Future setCurrentLocationName(String path) async {
    await _prefs.setString("currentLocationName", path);
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static String getFullName() {
    return _prefs.getString("fullname") ?? "";
  }

  static String getCity() {
    return _prefs.getString("cityName") ?? "";
  }

  static Future setCityName(String city) async {
    await _prefs.setString("cityName", city);
  }

  static int getCityId() {
    return int.parse(_prefs.getString("cityId") ?? "0");
  }

  static Future setPhone(String phone) async {
    await _prefs.setString("phone", phone);
  }
  static Future setFullName(String fullName) async {
    await _prefs.setString("fullname", fullName);
  }

  static Future saveLoginData(DriverModel user) async {
    await _prefs.setString("image", user.image);
    await _prefs.setInt("id", user.id);
    await _prefs.setString("phone", user.phone);
    await _prefs.setString("email", user.email);
    await _prefs.setString("fullname", user.fullname);
    await _prefs.setString("token", user.token);
    await _prefs.setString("cityId", user.city.id);
    await _prefs.setString("cityName", user.city.name);
    await _prefs.setBool("isActive", user.isActive);
    await _prefs.setInt("userCartCount", user.userCartCount);
    await _prefs.setInt("unreadNotifications", user.unreadNotifications);
  }

  static Future saveLatAndLng(location) async {
    await _prefs.setDouble("lat", location.latitude);
    await _prefs.setDouble("lng", location.longitude);
  }

  static double getLat() {
    return _prefs.getDouble("lat") ?? 0;
  }

  static double getLng() {
    return _prefs.getDouble("lng") ?? 0;
  }
  static Future saveCurrentLocation(Position currentLocation) async {
    await _prefs.setDouble("latitude", currentLocation.latitude);
    await _prefs.setDouble("longitude", currentLocation.longitude);
  }

  static Future saveCurrentLocationWithNameMap(String location) async {
    await _prefs.setString("location", location);
  }

  static String getCurrentLocationWithNameMap() {
    return _prefs.getString("location") ?? "";
  }

  static double getLatitude() {
    return _prefs.getDouble("latitude") ?? 0;
  }

  static double getLongitude() {
    return _prefs.getDouble("longitude") ?? 0;
  }

  static Future removeLoginData() async {
    await _prefs.clear();
  }

  static Future removeCityName() async {
    await _prefs.remove("cityName");
  }

  static Future removeLoginInfo() async {
    await _prefs.remove("image");
    await _prefs.remove("id");
    await _prefs.remove("phone");
    await _prefs.remove("email");
    await _prefs.remove("fullname");
    await _prefs.remove("token");
    await _prefs.remove("cityId");
    await _prefs.remove("cityName");
    await _prefs.remove("isActive");
    await _prefs.remove("userCartCount");
    await _prefs.remove("unreadNotifications");
  }
}
