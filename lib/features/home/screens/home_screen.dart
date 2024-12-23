import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../search/screen/search_screen.dart';
import '../widgets/adress_box.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/deal_of_the_day.dart';
import '../widgets/top_catageries.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName="/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: GlobalVariable.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){

                          },
                          child: Padding(padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.search,color: Colors.black,size: 23,),),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(7),
                          ),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: TextStyle(fontWeight:FontWeight.w500,fontSize: 17)
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 42,
                child: Icon(Icons.mic,color: Colors.black,size: 25,),
              )

            ],
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AdressBox(),
            SizedBox(height: 10,),
            TopCatageries(),
            SizedBox(height: 10,),
            CarouselWidget(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}