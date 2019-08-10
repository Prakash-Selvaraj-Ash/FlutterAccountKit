import 'package:flutter/material.dart';
import 'package:flutteraccountkit/src/accountkit/fb_account_manager.dart';
import 'package:flutteraccountkit/src/ui/shared/user_session_widget.dart';
import 'package:inject/inject.dart';

class App extends StatefulWidget {
  final FbAccountManager fbAccountManager;

  @provide
  App(this.fbAccountManager) : super();

  @override
  State<StatefulWidget> createState() {
    return _AppState(fbAccountManager);
  }
}

class _AppState extends State {
  final FbAccountManager _fbAccountManager;
  bool _isInitialized = false;

  _AppState(this._fbAccountManager): super();

  @override
  void initState() {
    initAppState();
    super.initState();
  }

  void initAppState() async {
    await _fbAccountManager.configureDefault();
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
              actions: buildActions())),
    );
  }

  buildActions(){
    if(_isInitialized){
      return <Widget>[UserSessionWidget(_fbAccountManager)];
    } 
    else{
      return <Widget>[];
    }
  }
}