import 'package:flutter/material.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/tabs_screen.dart';

class AppRouter {
  Route? ongenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBin(),
        );
      case TabScreen.id:
        return MaterialPageRoute(
          builder: (_) => const TabScreen(),
        );
      default:
        return null;
    }
  }
}
