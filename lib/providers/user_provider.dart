import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    name: "",
    email: "",
    password: "",
    type: "",
    address: "",
    token: "",
  );

  User get user => _user;

  void setUser(String user) {
    try {
      _user = User.fromJson(user);
      notifyListeners();
    } catch (e) {
      print("error getting user:$e");
    }
  }
}
