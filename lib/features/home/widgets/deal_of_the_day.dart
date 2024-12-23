import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/Product_detail_screen/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget{
  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices=HomeServices();
  Product? product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealofDay();
  }
  
  void fetchDealofDay() async{
    product=await homeServices.fetchDealofDay(context: context,);
    print("p:${product}");
    setState(() {
    });
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }
  @override
  Widget build(BuildContext context) {
    return product==null?Loader():product!.name.isEmpty?SizedBox():
    GestureDetector(
      onTap: (){
        navigateToDetailScreen();
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:10,top: 15,),
            child: Text("Deal of the Day",style: TextStyle(fontSize: 20,),),
          ),
          Image.network(product!.images[0],
          fit: BoxFit.fitHeight,
          height: 235,),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15),
            child: Text("\$100",style: TextStyle(fontSize: 18,),),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 5,left: 15,right: 40),
            child: Text("Shriyansh",maxLines: 2,overflow: TextOverflow.ellipsis,),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images.map((e)=>Image.network(e,fit: BoxFit.fitWidth,width: 100,height: 100,),).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text("See all Deals",style: TextStyle(color: Colors.cyan.shade800),),
          )
        ],
      ),
    );
  }
}