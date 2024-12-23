import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variable.dart';

class SearchServices{
  Future<List<Product>> fetchSearchedProduct({required BuildContext context,required String searchQuery}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Product> productList=[];
    try{
      http.Response res= await http.get(Uri.parse('$uri/api/products/search/$searchQuery'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
      );

      httpErrorHandling(responce: res, buildcontext: context, onSuccess:(){
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      });

    } catch(e) {
      showSnackBar(context, e.toString());
    }
    print("printing:${productList}");
    return productList;
  }
}