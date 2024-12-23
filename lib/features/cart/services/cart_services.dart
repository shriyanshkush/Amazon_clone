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

class CartServices{

  void remooveFromCart({required BuildContext context,required Product product}) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);

    try {
      http.Response res = await http.delete(Uri.parse('$uri/api/remove-to-cart/${product.id}'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
      );
      print("Responce:${res}");

      httpErrorHandling(responce:res , buildcontext: context, onSuccess: () {
        User user=userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart']
        );
        userProvider.setUserfromModel(user);
        print(user.toString());
      });
      showSnackBar(context, "Product remooved from cart Successfully !");

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

}