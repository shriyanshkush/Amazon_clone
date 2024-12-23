import 'package:amazon_clone/features/Product_detail_screen/services/product_detail_services.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget{
  final int index;
  const CartProduct({super.key, required this.index});
  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices productDetailServices =ProductDetailServices();
  final CartServices cartServices=CartServices();
  void increaseQuantity(Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.remooveFromCart(context: context, product: product);
  }
  @override
  Widget build(BuildContext context) {
    final productCart=context.watch<UserProvider>().user.cart[widget.index];
    final product=Product.fromMap(productCart['product']);
    final quantity=productCart['quantity'];
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10,),
          child: Row(
            children: [
              Image.network( product.images[0],fit: BoxFit.fitHeight,height: 135,width: 135,),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(product.name,style: TextStyle(fontSize: 16),maxLines: 2,),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(top: 5,left: 10),
                    child: Text("\$${product.price}.",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(top: 5,left: 10),
                    child: Text("Eligible For Free Shipping"),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(top: 5,left: 10),
                    child: Text("In Stock",style: TextStyle(
                      color: Colors.teal,
                    ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap:() {
                        decreaseQuantity(product);
                      },
                      child: Container(
                        width: 35,
                          height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.remove,size: 18,),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 2.5
                        ),
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        increaseQuantity(product);
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.add,size: 18,),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}