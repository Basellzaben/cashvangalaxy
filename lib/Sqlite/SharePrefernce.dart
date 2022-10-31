import 'package:shared_preferences/shared_preferences.dart';

class SharePrefernce{

  static Future<void> setR(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<String?> getR(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);

  }


}


