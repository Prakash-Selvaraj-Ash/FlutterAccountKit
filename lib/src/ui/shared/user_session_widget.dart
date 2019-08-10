import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutteraccountkit/src/accountkit/fb_account_manager.dart';

class UserSessionWidget extends StatefulWidget {
  final FbAccountManager _fbAccountManager;

  UserSessionWidget(this._fbAccountManager) : super();

  @override
  State<StatefulWidget> createState() {
    return _SessionState(_fbAccountManager);
  }
}

class _SessionState extends State {

  bool _isLoggedIn = false;
  FbAccountManager _fbAccountManager;
  _SessionState(this._fbAccountManager): super();


  @override
  void initState() {
    initAppBar();
    super.initState();
  }

  void initAppBar() async {
    bool isLoggedIn = await _fbAccountManager.isLoggedIn();
    if (!mounted) return;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    return getAppBarButtonWidget();
  }

  getAppBarButtonWidget() {
    if (_isLoggedIn) {
      return IconButton(
          icon: Icon(Icons.verified_user),
          onPressed: () async {
            await _fbAccountManager.logout();
            changeLoginState(false);
          });
    } else {
      return IconButton(
        icon: Icon(Icons.supervised_user_circle),
        onPressed: () async {
          await _fbAccountManager.login(
              () => processLogin(), () => processFailure());
        },
      );
    }
  }

  changeLoginState(bool state){
    setState(() {
      _isLoggedIn = state;
    });
  }
  processLogin() {
    changeLoginState(true);
  }

  processFailure() {}
}
