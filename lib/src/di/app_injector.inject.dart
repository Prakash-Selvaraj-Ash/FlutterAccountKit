import 'app_injector.dart' as _i1;
import 'app_module.dart' as _i2;
import '../accountkit/fb_account_manager.dart' as _i3;
import 'dart:async' as _i4;
import '../../app.dart' as _i5;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._appModule);

  final _i2.AppModule _appModule;

  _i3.FbAccountManager _singletonFbAccountManager;

  static _i4.Future<_i1.AppInjector> create(_i2.AppModule appModule) async {
    final injector = AppInjector$Injector._(appModule);

    return injector;
  }

  _i5.App _createApp() => _i5.App(_createFbAccountManager());
  _i3.FbAccountManager _createFbAccountManager() =>
      _singletonFbAccountManager ??= _appModule.accountManager();
  @override
  _i5.App get app => _createApp();
}
