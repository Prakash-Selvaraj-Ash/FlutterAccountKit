import 'app_injector.dart' as _i1;
import 'app_module.dart' as _i2;
import '../accountkit/fb_account_manager.dart' as _i3;
import '../category/webclient/category_service_client.dart' as _i4;
import 'dart:async' as _i5;
import '../../app.dart' as _i6;
import 'package:firebase_messaging/firebase_messaging.dart' as _i7;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._appModule);

  final _i2.AppModule _appModule;

  _i3.FbAccountManager _singletonFbAccountManager;

  _i4.CategoryServiceClient _singletonCategoryServiceClient;

  static _i5.Future<_i1.AppInjector> create(_i2.AppModule appModule) async {
    final injector = AppInjector$Injector._(appModule);

    return injector;
  }

  _i6.App _createApp() => _i6.App(_createFbAccountManager(),
      _createCategoryServiceClient(), _createFirebaseMessaging());
  _i3.FbAccountManager _createFbAccountManager() =>
      _singletonFbAccountManager ??= _appModule.accountManager();
  _i4.CategoryServiceClient _createCategoryServiceClient() =>
      _singletonCategoryServiceClient ??= _appModule.categoryServiceClient();
  _i7.FirebaseMessaging _createFirebaseMessaging() =>
      _appModule.firebaseMessaging();
  @override
  _i6.App get app => _createApp();
}
