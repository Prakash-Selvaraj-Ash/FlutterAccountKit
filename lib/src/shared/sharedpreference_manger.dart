import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager{
  final Future<SharedPreferences> _sharedPreferences;
  SharedPreferencesManager(this._sharedPreferences): super();

  getValue(String key) async {
    SharedPreferences pref = await _sharedPreferences;
    return pref.getString(key);
  }

  setValue(String key, String value) async {
    SharedPreferences pref = await _sharedPreferences;
    pref.setString(key, value);
  }

  clearValue(String key) async {
    SharedPreferences pref = await _sharedPreferences;
    pref.remove(key);
  }
}