import 'package:flutter/material.dart';
import 'package:twitter_mask/login_page.dart';
import 'package:twitter_mask/register_page.dart';

class Navigation {
  static Route<dynamic> navigationGenarator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/RegisterPage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RegisterPage(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
