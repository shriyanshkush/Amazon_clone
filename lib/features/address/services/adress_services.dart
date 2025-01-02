import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';


class AddressServices{
  void saveUserAdress({
    required BuildContext context,
    required String address,

  }) async{
    final userProvider=Provider.of<UserProvider>(context,listen:false);

    try{
      http.Response res = await http.post(Uri.parse('$uri/api/save-user-adress'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
        body:jsonEncode({
          'address':address,
        }),
      );

      httpErrorHandling(responce: res, buildcontext: context, onSuccess: () {
        User user= userProvider.user.copyWith(address: jsonDecode(res.body)['address']);
        userProvider.setUserfromModel(user);
      });

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
  //get all the products
  void placeOrder({required BuildContext context,required String address, required double totalSum }) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res= await http.post(Uri.parse('$uri/api/order'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
        body: jsonEncode({
          'cart':userProvider.user.cart,
          'address':address,
          'totalPrice':totalSum,
        }),
      );

      httpErrorHandling(responce: res, buildcontext: context, onSuccess:(){
        showSnackBar(context, 'your order has been placed!');
        User user =userProvider.user.copyWith(
          cart: [],
        );
        userProvider.setUserfromModel(user);
      });

    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({required BuildContext context,required Product product,required VoidCallback onSucess})async {
    final userProvider=Provider.of<UserProvider>(context,listen:false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/admin/delete-product'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
        body:jsonEncode({
          'id':product.id,
        }),
      );
      print(res.toString());

      httpErrorHandling(responce: res, buildcontext: context, onSuccess: () {
        onSucess();
      });

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}