import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variable.dart';
import '../../../providers/user_provider.dart';


class AccountServices{

  //get all the products
  Future<List<Order>> fetchAllOrders(BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Order> productList=[];
    try{
      http.Response res= await http.get(Uri.parse('$uri/api/orders/me'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
      );

      httpErrorHandling(responce: res, buildcontext: context, onSuccess:(){
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });

    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
            (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}