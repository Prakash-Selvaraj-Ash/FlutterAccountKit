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
}
