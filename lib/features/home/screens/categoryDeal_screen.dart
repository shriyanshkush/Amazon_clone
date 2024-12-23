import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../Product_detail_screen/screens/product_detail_screen.dart';

class CategorydealScreen extends StatefulWidget {
  static const String routeName ='/CategorySceen';
  final String category;
  const CategorydealScreen({super.key, required this.category});
  @override
  State<CategorydealScreen> createState() => _CategorydealScreenState();
}

class _CategorydealScreenState extends State<CategorydealScreen> {
  final HomeServices homeServices=HomeServices();
  List<Product>? productslist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }
  Future<List<Product>?> fetchCategoryProducts() async{
    List<Product>? _product=await  homeServices.fetchCategoryProduct(context: context, category: widget.category);
    setState(() {
      productslist=_product;
    });
    print(productslist);
  }
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
          title: Text(widget.category,style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
      ),
      body: productslist==null?Loader():Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep Shopping for ${widget.category}',style: TextStyle(fontSize: 20),),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              itemCount: productslist!.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.4,
              mainAxisSpacing: 10,
            ), itemBuilder: (context,index) {
                final product=productslist![index];
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: DecoratedBox(decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5
                        ),
                      ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.network(product!.images![0]!),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 0,top: 5,right: 15),
                      child: Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}