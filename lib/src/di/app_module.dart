import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutteraccountkit/src/accountkit/fb_account_manager.dart';
import 'package:flutteraccountkit/src/accountkit/fb_token_manager.dart';
import 'package:flutteraccountkit/src/category/webclient/category_service_client.dart';
import 'package:flutteraccountkit/src/shared/sharedpreference_manger.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@module
class AppModule{

  @provide
  FirebaseMessaging firebaseMessaging() => FirebaseMessaging();

  @provide
  @singleton
  CategoryServiceClient categoryServiceClient() => CategoryServiceClient();

  @provide
  FlutterAccountKit accountKit() => FlutterAccountKit();

  @provide
  @singleton
  Future<SharedPreferences> preferences() async => SharedPreferences.getInstance();
  
  @provide
  @singleton
  SharedPreferencesManager preferenceManger() => SharedPreferencesManager(preferences());

  @provide
  FbTokenManager tokenManager() => FbTokenManager(preferenceManger());

  @provide
  @singleton
  FbAccountManager accountManager() => FbAccountManager(accountKit(), tokenManager());
}