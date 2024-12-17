import 'package:flutter/material.dart';

import '../../layouts/client_layouts/home_page/home_page.dart';
import '../animation/size_animation.dart';

class AppRouter {
  static const loginRoute = '/login';
  static const dashboardRoute = '/dashboard';
  static const cashierRoute = '/cashier';
  static const newOrderRoute = '/newOrder';
  static const settingsAdminRoute = '/settingsAdmin';
  static const homePageRoute = '/homePage';
  

  AppRouter._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
   /* final Map<String, Object?>? args = settings.arguments != null
        ? settings.arguments as Map<String, Object?>?
        : null;*/
    switch (settings.name) {
      case homePageRoute:
       return SizeAnimationToRight(page: const HomePage());
        
       
      
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(),
      );
    });
  }
}
