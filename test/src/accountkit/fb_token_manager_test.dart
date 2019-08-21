import 'package:flutter_test/flutter_test.dart';
import 'package:flutteraccountkit/src/shared/sharedpreference_manger.dart';
import 'package:flutteraccountkit/src/accountkit/fb_token_manager.dart';
import 'package:mockito/mockito.dart';

class SharedPreferencesMock extends Mock implements SharedPreferencesManager{}

main(){
  group('getToken', () {
    test('getToken null', () async {
      final sharedPreferencesMock = SharedPreferencesMock();
      final tokenManager = FbTokenManager(sharedPreferencesMock);

      when(sharedPreferencesMock.getValue(tokenManager.appToken)).thenAnswer((_) => Future.value(null));

      final token = await tokenManager.getToken();
      expect(token, null);
    });

    test('getToken not null', () async {
      final sharedPreferencesMock = SharedPreferencesMock();
      final tokenManager = FbTokenManager(sharedPreferencesMock);
      const accessToken = "accessToken";

      when(sharedPreferencesMock.getValue(tokenManager.appToken)).thenAnswer((_) => Future.value(accessToken));

      final token = await tokenManager.getToken();
      expect(token, accessToken);
    });
  });

  group('set token', (){
    test('set token success', () async {
      final sharedPreferencesMock = SharedPreferencesMock();
      final tokenManager = FbTokenManager(sharedPreferencesMock);
      const accessToken = "accessToken";

      await tokenManager.setToken(accessToken);
      verify(sharedPreferencesMock.setValue(tokenManager.appToken, accessToken)).called(1);
    });
  });

  group('clear token', (){
    test('set token success', () async {
      final sharedPreferencesMock = SharedPreferencesMock();
      final tokenManager = FbTokenManager(sharedPreferencesMock);

      await tokenManager.clearToken();
      verify(sharedPreferencesMock.clearValue(tokenManager.appToken)).called(1);
    });
  });
}