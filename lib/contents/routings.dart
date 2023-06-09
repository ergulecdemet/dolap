import 'package:dolap_app/screen/category/category_add.dart';
import 'package:dolap_app/screen/category/category_list.dart';
import 'package:dolap_app/screen/home/home_screen.dart';
import 'package:dolap_app/screen/login/login_screen.dart';
import 'package:dolap_app/screen/product_add/product_add_screen.dart';
import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:dolap_app/screen/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? createRoute(Widget page, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(settings: settings, builder: (context) => page);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(settings: settings, builder: (context) => page);
    } else {
      return CupertinoPageRoute(builder: (context) => page);
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return createRoute(const SplashScreen(), settings);
      case "/register":
        return createRoute(const RegisterScreen(), settings);
      case "/login":
        return createRoute(const LoginScren(), settings);
      case "/home":
        return createRoute(const HomeScreen(), settings);
      case "/productAdd":
        return createRoute(const ProductAdd(), settings);
      case "/categoryAdd":
        return createRoute(const CategoryAdd(), settings);
      case "/categoryList":
        return createRoute(const CategoryList(), settings);

      default:
        return MaterialPageRoute(
          builder: (context) => const Text("Container with a screen"),
        );
    }
  }
}

enum AppRoutes {
  home,
  splash,
  login,
  register,
  productAdd,
  categoryAdd,
  categoryList,
}

extension MyAppRoutes on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return "/";
      case AppRoutes.login:
        return "/login";
      case AppRoutes.register:
        return "/register";
      case AppRoutes.home:
        return "/home";
      case AppRoutes.productAdd:
        return "/productAdd";
      case AppRoutes.categoryAdd:
        return "/categoryAdd";
      case AppRoutes.categoryList:
        return "/categoryList";

      default:
        return "";
    }
  }
}
