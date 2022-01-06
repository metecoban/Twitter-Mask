import 'package:flutter/material.dart';
import 'package:twitter_mask/pages/homepage.dart';
import 'package:twitter_mask/pages/login_page.dart';

class Navigation {
  static Route<dynamic> navigationGenarator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/Homepage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Homepage(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
