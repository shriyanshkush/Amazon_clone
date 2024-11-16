import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';

class AuthServices {
  //sign up user

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
}) async{
    try{
      User user =User(id: " ", name: name, email:email,password: password, type: " ", address:  " ", token: " ");
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),body:json.encode(user.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);

      httpErrorHandling(responce: res, buildcontext: context, onSuccess: (){
        showSnackBar(context, "Account has been created, Login with same credential!");
      });
    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  //SignIn user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async{
    try{
      User user =User(id: " ", name: " ", email:email,password: password, type: " ", address:  " ", token: " ");
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),body:json.encode(user.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);

      httpErrorHandling(
          responce: res,
          buildcontext: context,
          onSuccess: () async{
            SharedPreferences prefs= await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context,listen: false).setUser(res.body);
            await prefs.setString("x-auth-token", jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName, (route)=>false);
          });

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        // Set a blank token if not found
        prefs.setString("x-auth-token", '');
      }

      // Check if the token is valid
      var tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // Get user data
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}