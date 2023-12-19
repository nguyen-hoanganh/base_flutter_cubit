import 'package:flutter/material.dart';

class AppConfig {
  static final AppConfig shared = AppConfig._();
  AppConfig._();
  factory AppConfig() {
    return shared;
  }

  static const Duration apiTimeOut = Duration(seconds: 60);
  static const bool isShowChangeENV = true;
  static const int fileMaxSize = 3 * 1000 * 1000;
  static final List<String> allowDomain = [
    'test.com.vn',
  ];
  String currentRoute = '';

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
