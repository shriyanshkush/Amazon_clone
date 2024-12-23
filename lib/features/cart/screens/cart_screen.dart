import 'package:amazon_clone/common/widgets/cutom_buttom.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/adress_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../../providers/user_provider.dart';
import '../../search/screen/search_screen.dart';

class CartScreen extends StatefulWidget{
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    final user= context.watch<UserProvider>().user;
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
            CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: "Proceed To Buy (${user.cart.length} items)", onTap: (){},color: Colors.yellow.shade600,),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            SizedBox(height: 5,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
                itemBuilder: (context,index) {
                return CartProduct(index: index);
            }),
          ],
        ),
      ),
    );
  }
}