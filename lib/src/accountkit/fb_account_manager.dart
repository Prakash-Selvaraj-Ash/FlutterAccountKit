import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter/services.dart';
import 'package:flutteraccountkit/src/accountkit/fb_token_manager.dart';
import 'package:inject/inject.dart';

class FbAccountManager {
  FlutterAccountKit _flutterAccountKit;
  FbTokenManager _fbTokenManager;

  @provide
  FbAccountManager(this._flutterAccountKit, this._fbTokenManager) : super();

  configureDefault() async {
    try {
      await _flutterAccountKit.configure(Config()
        ..facebookNotificationsEnabled = true
        ..receiveSMS = true
        ..readPhoneStateEnabled = true);
      print('configured successfully');
    } on PlatformException {
      print('Failed to initialize account kit');
    }
  }

  login(successCallBack, failureCallBack) async {
    final result = await _flutterAccountKit.logInWithPhone();
    switch (result.status) {
      case LoginStatus.cancelledByUser:
      case LoginStatus.error:
        String errorMessage = result.errorMessage;
        print('loggin error $errorMessage');
        failureCallBack();
        break;
      case LoginStatus.loggedIn:
        await _fbTokenManager.setToken(result.accessToken.token);
        successCallBack();
        break;
      default:
        break;
    }
  }

  isLoggedIn() async {
    dynamic token = await _fbTokenManager.getToken();
    return token != null;
  }

  logout() async {
    if (await isLoggedIn()) {
      await _fbTokenManager.clearToken();
      await _flutterAccountKit.logOut();
    }
  }
}
