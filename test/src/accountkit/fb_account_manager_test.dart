import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutteraccountkit/src/accountkit/fb_account_manager.dart';
import 'package:flutteraccountkit/src/accountkit/fb_token_manager.dart';
import 'package:mockito/mockito.dart';

class MockFbAccountKit extends Mock implements FlutterAccountKit {}

class MockTokenManager extends Mock implements FbTokenManager {}

main() {
  group('configure', () {
    test('fb configure success', () {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);

      manager.configureDefault();
      verify(mockFbAccountKit.configure(any)).called(1);
    });
  });

  group('isLoggedIn', () {
    test('is logged in false', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);
      
      when(mockFbTokenManager.getToken()).thenAnswer((_) => Future.value(null));
      bool isLoggedIn = await manager.isLoggedIn();
      expect(isLoggedIn, false);
    });

    test('is logged in true', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);
      
      when(mockFbTokenManager.getToken()).thenAnswer((_) => Future.value('token'));
      bool isLoggedIn = await manager.isLoggedIn();
      expect(isLoggedIn, true);
    });
  });

  group('logout', () {

    test('logout is logged in false', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);

      await manager.logout();
      verifyNever(mockFbAccountKit.logOut());
      verifyNever(mockFbTokenManager.clearToken());
    });


    test('logout is logged in true', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);

      when(mockFbTokenManager.getToken()).thenAnswer((_) => Future.value('token'));

      await manager.logout();
      verify(mockFbAccountKit.logOut()).called(1);
      verify(mockFbTokenManager.clearToken()).called(1);
    });
  });

  group('login', () {
    test('login failure', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);
      bool isFailed = false;
      Map<String, dynamic> map = Map();
      map['status'] = 'error';
      map['code'] = 'code';
      map['errorMesssage'] = 'error';
      LoginResult result = LoginResult.fromMap(map);
      when(mockFbAccountKit.logInWithPhone())
          .thenAnswer((_) => Future.value(result));

      await manager.login(() {
        isFailed = false;
      }, () {
        isFailed = true;
      });

      expect(isFailed, true);
      verify(mockFbAccountKit.logInWithPhone()).called(1);
    });

    test('login Success', () async {
      final mockFbAccountKit = MockFbAccountKit();
      final mockFbTokenManager = MockTokenManager();
      final FbAccountManager manager =
          FbAccountManager(mockFbAccountKit, mockFbTokenManager);

      bool isSuccess;
      Map<String, dynamic> map = Map();
      String token = 'token';
      map['status'] = 'loggedIn';
      map['code'] = 'code';
      map['errorMesssage'] = 'error';
      map['accessToken'] = {'token': token};
      LoginResult result = LoginResult.fromMap(map);

      when(mockFbAccountKit.logInWithPhone())
          .thenAnswer((_) => Future.value(result));
      when(mockFbTokenManager.setToken(token)).thenReturn({});

      await manager.login(() {
        isSuccess = true;
      }, () {
        isSuccess = false;
      });

      expect(isSuccess, true);
      verify(mockFbAccountKit.logInWithPhone()).called(1);
      verify(mockFbTokenManager.setToken(token)).called(1);
    });
  });
}
