
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesetting) {
  switch(routesetting.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routesetting,
          builder: (_)=>AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>AddProductScreen());
    default:
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>const Scaffold(
            body: Center(child: Text("Route Not Found"),),
          ));
  }
}