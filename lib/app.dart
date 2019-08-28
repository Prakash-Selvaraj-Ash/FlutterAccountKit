import 'package:flutter/material.dart';
import 'package:flutteraccountkit/src/accountkit/fb_account_manager.dart';
import 'package:flutteraccountkit/src/category/dto/response/get_category_response_dto.dart';
import 'package:flutteraccountkit/src/category/webclient/category_service_client.dart';
import 'package:flutteraccountkit/src/category/widgets/category_list_widget.dart';
import 'package:flutteraccountkit/src/ui/shared/user_session_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inject/inject.dart';

class App extends StatefulWidget {
  final FbAccountManager fbAccountManager;
  final CategoryServiceClient categoryServiceClient;
  final FirebaseMessaging firebaseMessaging;

  @provide
  App(this.fbAccountManager, this.categoryServiceClient, this.firebaseMessaging)
      : super();

  @override
  State<StatefulWidget> createState() {
    return _AppState(fbAccountManager, categoryServiceClient, firebaseMessaging);
  }
}

class _AppState extends State {
  final CategoryServiceClient _categoryServiceClient;
  final FbAccountManager _fbAccountManager;
  final FirebaseMessaging _firebaseMessaging;

  List<GetCategoryResponseDto> _categories;
  bool _isInitialized = false;

  _AppState(this._fbAccountManager, this._categoryServiceClient,
      this._firebaseMessaging)
      : super();

  @override
  void initState() {
    initAppState();
    firebaseCloudMessagingListeners();
    super.initState();
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      print('fcm token');
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void initAppState() async {
    await _fbAccountManager.configureDefault();
    _categories = await _categoryServiceClient.getCategories();
    if (!mounted) return;
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearYu',
      home: Scaffold(
        appBar: AppBar(
          title: Text('NearYu'),
          actions: buildActions(),
        ),
        body: buildBody(),
      ),
    );
  }

  buildActions() {
    if (_isInitialized) {
      return <Widget>[UserSessionWidget(_fbAccountManager)];
    } else {
      return <Widget>[];
    }
  }

  buildBody() {
    if (_isInitialized) {
      return CategoryList(_categories);
    } else {
      return CircularProgressIndicator();
    }
  }
}
