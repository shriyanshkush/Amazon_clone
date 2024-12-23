import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class SearchProduct extends StatelessWidget{
  final Product product;
  const SearchProduct({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    double totalRating=0;
    double avgRating=0.0;
    for(var i=0;i<product.rating!.length;i++) {
      totalRating+=product.rating![i].rating;
    }
    if(totalRating!=0) {
      avgRating=totalRating/product.rating!.length;
    }
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10,),
          child: Row(
            children: [
              Image.network(product.images[0],fit: BoxFit.fitHeight,height: 135,width: 135,),
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
                    child: Stars(rating: avgRating),
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
        )
      ],
    );
  }
  
}