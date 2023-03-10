import 'package:flutter/material.dart';
import 'navigator_custom.dart';

class NavigatorManager {
  NavigatorManager._();
  static NavigatorManager instance = NavigatorManager._();
  final GlobalKey<NavigatorState> _navigatorGlobalKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorGlobalKey => _navigatorGlobalKey;

  Future<void> pushToPage(NavigateCustomEnum route, {Object? arguments}) async {
    await _navigatorGlobalKey.currentState?.pushNamed(
      route.withParaf,
      arguments: arguments,
    );
  }

  void popToPage({Object? arguments}) {
    _navigatorGlobalKey.currentState?.pop(arguments);
  }
}
