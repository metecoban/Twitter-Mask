import 'package:flutter/material.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/pages/archive_page.dart';
import 'package:twitter_mask/pages/filter_page.dart';
import 'package:twitter_mask/pages/homepage.dart';
import 'package:twitter_mask/pages/login_page.dart';
import 'package:twitter_mask/pages/profile_page.dart';

class Navigation {
  static Route<dynamic> navigationGenarator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/Homepage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Homepage(
            user: settings.arguments as UserModel?,
          ),
        );
      case '/FilterPage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => FilterPage(
            user: settings.arguments as UserModel?,
          ),
        );
      case '/ArchivePage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ArchivePage(
            user: settings.arguments as UserModel?,
          ),
        );
      case '/ProfilePage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ProfilePage(
            user: settings.arguments as UserModel?,
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
