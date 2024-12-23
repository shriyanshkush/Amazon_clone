import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variable.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProduct({required BuildContext context,required String category}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Product> productList=[];
    try{
      http.Response res= await http.get(Uri.parse('$uri/api/products?category=$category'),
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
    return productList;
  }


  Future<Product> fetchDealofDay({required BuildContext context}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    Product product=Product(name: '', description: '', quantity: 0, images: [], category: '', price: 0);
    try{
      http.Response res= await http.get(Uri.parse('$uri/api/deal-of-day'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':userProvider.user.token,
        },
      );

      httpErrorHandling(responce: res, buildcontext: context, onSuccess:(){
        product=Product.fromJson(res.body);
      });

    } catch(e) {
      showSnackBar(context, e.toString());
    }
    print(product);
    return product;
  }
}