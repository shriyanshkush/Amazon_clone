import 'dart:io';

import 'package:amazon_clone/common/widgets/custome_text_field.dart';
import 'package:amazon_clone/common/widgets/cutom_buttom.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variable.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName="/add-product";
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final AdminServices adminServices=AdminServices();

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
  List<File> images=[];
  final _addProductKey= GlobalKey<FormState>();
  String category="Mobiles";
  List<String> productCategories=["Mobiles","Essentials","Appliances","Books","Fashion"];

  void sellProduct() {
    if(_addProductKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(context: context, name: _productNameController.text, description: _descriptionController.text,
          price: double.parse(_priceController.text), quantity: double.parse(_quantityController.text), category: category, images: images);
    }
  }

  void selectImages() async{
    var res= await pickImages();
    setState(() {
      images=res;
    });
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
          title:Text("Add Product",style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductKey,
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  images.isNotEmpty?CarouselSlider(
                    items: images.map((i){
                      return Builder(
                          builder: (BuildContext context)=> Image.file(i,fit: BoxFit.cover,height: 200,));
                    }).toList(),
                    options: CarouselOptions(
                      //autoPlay: true,
                      viewportFraction: 1,
                      height: 200,
                    ),
                  ) : GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [10,4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open,size: 40,),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Select Product Images",style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
                          ),)
                        ],
                      ),
                    ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomeTextField(
                      controller: _productNameController,
                      hinttext: "Product Name"),
                  SizedBox(height: 10,),
                  CustomeTextField(
                      controller: _descriptionController,
                      maxLines: 7,
                      hinttext: "Description"),
                  SizedBox(height: 10,),
                  CustomeTextField(
                      controller: _priceController,
                      hinttext: "Price"),
                  SizedBox(height: 10,),
                  CustomeTextField(
                      controller: _quantityController,
                      hinttext: "Quantity"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),);
                        }).toList(),
                        onChanged: (String? newVal) {
                        setState(() {
                          category=newVal!;
                        });
                        }),
                  ),
                  SizedBox(height: 10,),
                  CustomButton(text: "Sell",
                      onTap:sellProduct),
                ],
              ),
            ) ),
      ),
    );
  }
}