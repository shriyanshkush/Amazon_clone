import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/Product_detail_screen/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/categoryDeal_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

import 'features/search/screen/search_screen.dart';

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
      case CategorydealScreen.routeName:
        var category =routesetting.arguments as String;
        return MaterialPageRoute(
            settings: routesetting,
            builder: (_)=>CategorydealScreen(category: category));
    case SearchScreen.routeName:
      var searchQuery =routesetting.arguments as String;
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>SearchScreen(searchQuery: searchQuery,));
    case ProductDetailScreen.routeName:
      var product =routesetting.arguments as Product;
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>ProductDetailScreen(product: product,));
    default:
      return MaterialPageRoute(
          settings: routesetting,
          builder: (_)=>const Scaffold(
            body: Center(child: Text("Route Not Found"),),
          ));
  }
}