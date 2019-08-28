import 'package:flutter/material.dart';
import 'package:flutteraccountkit/src/di/app_injector.dart';
import 'package:flutteraccountkit/src/di/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var container = await AppInjector.create(AppModule());
  runApp(container.app);
}