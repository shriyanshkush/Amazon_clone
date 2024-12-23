import 'package:amazon_clone/common/widgets/cutom_buttom.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/Product_detail_screen/services/product_detail_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product_model.dart';
import '../../search/screen/search_screen.dart';

class ProductDetailScreen extends StatefulWidget{
  static const String routeName='productDetailScreen';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices productDetailServices=ProductDetailServices();
  double avgRating=0.0;
  double myRating=0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating=0;
    for(var i=0;i<widget.product.rating!.length;i++) {
      totalRating+=widget.product.rating![i].rating;

      if(widget.product.rating![i].userId==Provider.of<UserProvider>(context,listen: false).user.id) {
        myRating=widget.product.rating![i].rating;
      }
    }
    if(totalRating!=0) {
      avgRating=totalRating/widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  
  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: PreferredSize(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: Text(widget.product.name,style: TextStyle(fontSize: 15),),
            ),
          CarouselSlider(
          items: widget.product.images.map((i){
            return Builder(
                builder: (BuildContext context)=> Image.network(i,fit: BoxFit.contain,height: 200,));
          }).toList(),
          options: CarouselOptions(
            //autoPlay: true,
            viewportFraction: 1,
            height: 300,
          ),
          ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(padding: EdgeInsets.all(8),

             child: RichText(
                 text: TextSpan(text: 'Deal Price : ',
                   style: TextStyle(fontSize: 16,
                       color:Colors.black,
                       fontWeight: FontWeight.bold ),
                   children: [
                     TextSpan(text: '\$ ${widget.product.price}',
                         style: TextStyle(fontSize: 22,
                             color:Colors.red,
                             fontWeight: FontWeight.w500 ),
                     ),
                   ]
            ),
             ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(text: 'Buy Now', onTap: (){}),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                color: Color.fromRGBO(254, 216, 19, 1),
                  text: 'Add to Cart', onTap: (){
                  addToCart();
                }),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 ),
              child: Text("Rate the Product",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ),
            RatingBar.builder(
              initialRating: myRating,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemBuilder: (context,_){return Icon(Icons.star_sharp,color: GlobalVariable.secondaryColor,);},
                onRatingUpdate: (rating){
                productDetailServices.rateProduct(context: context, product: widget.product, ratiing: rating);
            }),
          ],
        ),
      ),
    );
  }
}