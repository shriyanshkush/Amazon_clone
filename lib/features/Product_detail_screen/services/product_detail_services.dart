import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';

class ProductDetailServices{

  void addToCart({required BuildContext context,required Product product}) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);

    try {

      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
        body:jsonEncode({
          'id':product.id,
        }),
      );

      httpErrorHandling(responce:res , buildcontext: context, onSuccess: () {
        User user=userProvider.user.copyWith(
          cart: jsonDecode(res.body)['cart']
        );
        userProvider.setUserfromModel(user);
      });
      showSnackBar(context, "Product added to cart Successfully !");

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  void rateProduct({required BuildContext context,required Product product,required double ratiing}) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);

    try {

      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
        body:jsonEncode({
          'id':product.id,
          'rating':ratiing,
        }),
      );

      httpErrorHandling(responce:res , buildcontext: context, onSuccess: () {});

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

}