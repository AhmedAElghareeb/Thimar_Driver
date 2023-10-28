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

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static String getFullName() {
    return _prefs.getString("fullname") ?? "";
  }

  static String getCity() {
    return _prefs.getString("cityName") ?? "";
  }

  static int getCityId() {
    return int.parse(_prefs.getString("cityId") ?? "0");
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

  static Future removeLoginData() async {
    await _prefs.clear();
  }
}
