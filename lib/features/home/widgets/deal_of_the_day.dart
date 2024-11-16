import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left:10,top: 15,),
          child: Text("Deal of the Day",style: TextStyle(fontSize: 20,),),
        ),
        Image.network("https://plus.unsplash.com/premium_photo-1661915661139-5b6a4e4a6fcc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8SG91c2V8ZW58MHx8MHx8fDA%3D",
        fit: BoxFit.fitHeight,
        height: 235,),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15),
          child: Text("\$100",style: TextStyle(fontSize: 18,),),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 5,left: 15,right: 40),
          child: Text("Shriyansh",maxLines: 2,overflow: TextOverflow.ellipsis,),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network("https://plus.unsplash.com/premium_photo-1661962841993-99a07c27c9f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8SG91c2V8ZW58MHx8MHx8fDA%3D",fit: BoxFit.fitWidth,width: 100,height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1661962841993-99a07c27c9f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8SG91c2V8ZW58MHx8MHx8fDA%3D",fit: BoxFit.fitWidth,width: 100,height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1661962841993-99a07c27c9f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8SG91c2V8ZW58MHx8MHx8fDA%3D",fit: BoxFit.fitWidth,width: 100,height: 100,),
              Image.network("https://plus.unsplash.com/premium_photo-1661962841993-99a07c27c9f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8SG91c2V8ZW58MHx8MHx8fDA%3D",fit: BoxFit.fitWidth,width: 100,height: 100,),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text("See all Deals",style: TextStyle(color: Colors.cyan.shade800),),
        )
      ],
    );
  }

}