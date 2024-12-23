import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/widgets/adress_box.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/search_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product_model.dart';
import '../../Product_detail_screen/screens/product_detail_screen.dart';

class SearchScreen extends StatefulWidget{
  static const String routeName='/searchScreen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  List<Product>? products;
  final SearchServices searchServices=SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProducts();

  }
  void fetchSearchedProducts() async{
    products= await searchServices.fetchSearchedProduct(context: context, searchQuery: widget.searchQuery);
    setState(() {

    });
    }
  @override
  Widget build(BuildContext context) {
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
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body:products==null?Loader():Column(
        children: [
          AdressBox(),
          Expanded(child: ListView.builder(
            itemCount: products!.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,ProductDetailScreen.routeName,arguments: products![index]);
                },
                  child: SearchProduct(product: products![index]));
            },
          ),
          ),
        ],
      )
    );
  }
}