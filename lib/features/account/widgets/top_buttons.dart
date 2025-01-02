import 'package:amazon_clone/features/account/account_services.dart';
import 'package:flutter/material.dart';

import 'account_button.dart';

class TopButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: (){

            }),
            AccountButton(text: "Turn Seller", onTap: (){

            }),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: "LogOut", onTap: () {
              print("hello");
             AccountServices().logOut(context);
            }),
            AccountButton(text: "Your Wishlist", onTap: (){

            }),
          ],
        ),
      ],
    );
  }
}