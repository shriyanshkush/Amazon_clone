import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class PostsScreen extends StatefulWidget {
  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices=AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async{
    List<Product>_product=await adminServices.fetchAllProducts(context);
    setState(() {
      products=_product;
    });
  }

  void deleteProduct(Product product,int index) async{
    adminServices.deleteProduct(context: context, product: product, onSucess: (){
      products!.removeAt(index);
      setState(() {

      });
    });
  }
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return products==null ? Loader():Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index) {
        final productdata=products![index];
        return Column(
          children: [
            SizedBox(
              height: 140,
              child: SingleProduct(image: productdata.images[0]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Text(productdata.name,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                IconButton(onPressed: ()=>deleteProduct(productdata,index), icon: Icon(Icons.delete_outlined)),
              ],
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade500,
        tooltip: "Add a Product",
        onPressed: navigateToAddProduct,
      child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}