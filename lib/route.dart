import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screens.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case Bottombar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Bottombar(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Center(
          child: Text('Something wrong happened! :('),
        ),
      );
  }
}
