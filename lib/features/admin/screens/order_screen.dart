import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order/screen/order_details.dart';
import 'package:flutter/material.dart';

import '../../../models/order_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices=AdminServices();
  @override
  void initState() {
    super.initState();
    fetchorders();
  }
  void fetchorders() async{
    orders=await adminServices.fetchAllOrders(context);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return orders==null?Center(child: CircularProgressIndicator()):GridView.builder(
      itemCount:orders!.length ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,index) {
        final Orderdata=orders![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context,OrderDetails.routeName,arguments: Orderdata);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(image: Orderdata.products[0].images[0]),
          ),
        );
    });
  }
}