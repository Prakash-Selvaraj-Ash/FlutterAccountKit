import 'package:flutteraccountkit/src/shared/sharedpreference_manger.dart';
import 'package:inject/inject.dart';


class FbTokenManager {

  final String appToken = "app_token";
  SharedPreferencesManager _sharedPreferenceManager;

  @provide
  FbTokenManager(this._sharedPreferenceManager): super();

  getToken() async {
    return await _sharedPreferenceManager.getValue(appToken);
  }

  setToken(String token) async {
    await _sharedPreferenceManager.setValue(appToken, token);
  }

  clearToken() async {
    await _sharedPreferenceManager.clearValue(appToken);
  }
}