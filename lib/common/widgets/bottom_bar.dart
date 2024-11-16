import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';

import '../../features/account/screens/account_screen.dart';

class BottomBar extends StatefulWidget{
  static const String routeName='/actual-home';
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth=42.0;
  double bottomBarBorderWidth=5;

  void updatePage(int page) {
    setState(() {
      _page=page;
    });
  }

  List<Widget>pages=[
    HomeScreen(),
    AccountScreen(),
    Center(child: Text("Cart Page",style: TextStyle(fontSize: 30),),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
          selectedItemColor: GlobalVariable.selectedNavBarColor,
          unselectedItemColor: GlobalVariable.unselectedNavBarColor,
          backgroundColor: GlobalVariable.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page ==0?GlobalVariable.selectedNavBarColor:GlobalVariable.backgroundColor,
                    width: bottomBarBorderWidth,
                  )
                )
              ),
              child: Icon(
                Icons.home_outlined
              ),
            ),
              label: " ",
            ),

            BottomNavigationBarItem(icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: _page ==1?GlobalVariable.selectedNavBarColor:GlobalVariable.backgroundColor,
                        width: bottomBarBorderWidth,
                      )
                  )
              ),
              child: Icon(
                  Icons.person_outline
              ),
            ),
              label: " ",
            ),

            BottomNavigationBarItem(icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: _page ==2? GlobalVariable.selectedNavBarColor:GlobalVariable.backgroundColor,
                        width: bottomBarBorderWidth,
                      )
                  )
              ),
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white
                ),
                badgeContent: Text(
                  '1', // or any number to display inside the badge
                  style: TextStyle(color: Colors.black),
                ),
                child: Icon(Icons.shopping_cart_outlined),
              )
            ),
              label: " ",
            ),
          ]),
    );
  }
}