import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationRoute route = NavigationRoute.main;

  login() {
    route = NavigationRoute.login;
    notifyListeners();
  }

  admin() {
    route = NavigationRoute.admin;
    notifyListeners();
  }

  reset() {
    route = NavigationRoute.main;
    notifyListeners();
  }
}

enum NavigationRoute { login, admin, main }
