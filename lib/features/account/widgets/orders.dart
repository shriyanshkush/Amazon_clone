import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order/screen/order_details.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices accountServices =AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async{
    orders=await accountServices.fetchAllOrders(context);
    setState(() {

    });
    print(orders);
  }


  @override
  Widget build(BuildContext context) {
    return orders==null?const CircularProgressIndicator():Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text("Your orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Text("See all",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: GlobalVariable.selectedNavBarColor),),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: EdgeInsets.only(left: 10,top: 20,right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: ((context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetails.routeName,arguments: orders![index]);
                },
                  child: SingleProduct(image: orders![index].products[0].images[0]));
          }),
          ),
        ),
      ],
    );
  }
}