import 'package:flutteraccountkit/src/shared/sharedpreference_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

main(){
  group('get value', (){
    test('get value null', () async {
      final _sharedPreferences = SharedPreferencesMock();
      final futureSharedPreference = Future.value(_sharedPreferences);
      final key = 'key';

      final SharedPreferencesManager manager = 
        SharedPreferencesManager(futureSharedPreference);
      
      final result = await manager.getValue(key);
      
      verify(_sharedPreferences.getString(key)).called(1);
      expect(result, null);
    });

    test('get value not null', () async {
      final _sharedPreferences = SharedPreferencesMock();
      final futureSharedPreference = Future.value(_sharedPreferences);
      final key = 'key';
      final expectedValue = 'value';

      when(_sharedPreferences.getString(key)).thenReturn(expectedValue);

      final SharedPreferencesManager manager = 
        SharedPreferencesManager(futureSharedPreference);
      
      final result = await manager.getValue('key');
      
      verify(_sharedPreferences.getString(key)).called(1);
      expect(result, expectedValue);
    });
  });

  group('set value', (){
    test('set value', () async {
      final _sharedPreferences = SharedPreferencesMock();
      final futureSharedPreference = Future.value(_sharedPreferences);
      final key = 'key';
      final expectedValue = 'value';

      final SharedPreferencesManager manager = 
        SharedPreferencesManager(futureSharedPreference);
      
      await manager.setValue(key, expectedValue);
      
      verify(_sharedPreferences.setString(key, expectedValue)).called(1);
    });
  });

  group('clear value', (){
    test('clear value', () async {
      final _sharedPreferences = SharedPreferencesMock();
      final futureSharedPreference = Future.value(_sharedPreferences);
      final key = 'key';

      final SharedPreferencesManager manager = 
        SharedPreferencesManager(futureSharedPreference);
      
      await manager.clearValue(key);
      
      verify(_sharedPreferences.remove(key)).called(1);
    });
  });
}