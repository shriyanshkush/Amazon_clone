import 'package:flutter/material.dart';

import 'account_button.dart';

class TopButtons extends StatefulWidget {
  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
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
            AccountButton(text: "LogOut", onTap: (){

            }),
            AccountButton(text: "Your Wishlist", onTap: (){

            }),
          ],
        ),
      ],
    );
  }
}