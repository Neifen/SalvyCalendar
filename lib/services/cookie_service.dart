import 'package:shared_preferences/shared_preferences.dart';

class CookieService {
  static SharedPreferences? _preferences;
  static CookieService? _instance;
  static const DAY_LIST = 'DAY_LIST';

  bool has(String key) {
    if (_preferences == null) {
      return false;
    }
    return _preferences!.containsKey(key);
  }

  save(String key, String value) {
    _preferences?.setString(key, value);
  }

  saveList(String key, List<String> values) {
    _preferences?.setStringList(key, values);
  }

  String? load(String key) {
    return _preferences?.getString(key);
  }

  List<String> loadList(String key) {
    return _preferences?.getStringList(key) ?? [];
  }

  static Future<CookieService> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();

    return _instance ??= CookieService();
  }
}
