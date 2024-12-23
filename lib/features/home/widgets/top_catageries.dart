import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/home/screens/categoryDeal_screen.dart';
import 'package:flutter/material.dart';

class TopCatageries extends StatelessWidget{
  void NavigateToCategoryDealpage(BuildContext context, String category) {
    Navigator.pushNamed(context,CategorydealScreen.routeName,arguments: category);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariable.categoryImages.length,
          itemExtent: 78.5,
          itemBuilder:(context,index) {
          return GestureDetector(
            onTap: (){
              NavigateToCategoryDealpage(context,GlobalVariable.categoryImages[index]['title']!);
              print(GlobalVariable.categoryImages[index]['title']!);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(GlobalVariable.categoryImages[index]["image"]!,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,),
                  ),
                ),
                Text(GlobalVariable.categoryImages[index]["title"]!,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)
              ],
            ),
          );
      }),
    );
  }

}