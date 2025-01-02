import 'package:amazon_clone/features/admin/screens/order_screen.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../../constants/global_variable.dart';
import 'analytics_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth=42.0;
  double bottomBarBorderWidth=5;

  void updatePage(int page) {
    setState(() {
      _page=page;
    });
  }

  List<Widget>pages=[
    PostsScreen(),
    AnalyticsScreen(),
    OrderScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: GlobalVariable.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 45,
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/amazon_in.png"),
              ),
              Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
            ],
          ),
          centerTitle: true,
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
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
                  Icons.analytics_outlined
              ),
            ),
              label: " ",
            ),

            BottomNavigationBarItem(icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: _page ==2?GlobalVariable.selectedNavBarColor:GlobalVariable.backgroundColor,
                        width: bottomBarBorderWidth,
                      )
                  )
              ),
              child: Icon(
                  Icons.all_inbox_outlined
              ),
            ),
              label: " ",
            ),
          ]),
      body: pages[_page],
    );
  }
}