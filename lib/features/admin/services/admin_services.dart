import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../../providers/user_provider.dart';


class AdminServices{
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
}) async{
    final userProvider=Provider.of<UserProvider>(context,listen:false);
    try {

      final cloudinary = Cloudinary.unsignedConfig(
        cloudName: "dxx2cuoew",
      );
      List<String> imageUrls = [];

      for (var file in images) {
        final response = await cloudinary.unsignedUpload(
          file: file.path,
          uploadPreset: "rkz9gk91",
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: name,
          fileName: '${name}-${DateTime.now().millisecondsSinceEpoch}', // Use unique names if needed
          progressCallback: (count, total) {
            print('Uploading ${file.path} with progress: $count/$total');
          },
        );

        if (response.isSuccessful) {
          imageUrls.add(response.secureUrl!);
          print('Uploaded ${file.path} to ${response.secureUrl}');
        } else {
          print('Failed to upload ${file.path}');
        }
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);
      print(product.toJson());

     http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
       headers:{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':userProvider.user.token,
      },
        body:product.toJson(),
      );

     httpErrorHandling(responce: res, buildcontext: context, onSuccess: () {
       showSnackBar(context, "Product added successfully!");
       Navigator.pop(context);
     });

    }catch(e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
  //get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Product> productList=[];
    try{
      http.Response res= await http.get(Uri.parse('$uri/admin/get-product'),
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