import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/feature/admin/screens/admin_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screens.dart';
import 'package:amazon_clone/feature/home/screens/category_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:amazon_clone/feature/product_details/screens/product_details.dart';
import 'package:amazon_clone/feature/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
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
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: product),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
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
