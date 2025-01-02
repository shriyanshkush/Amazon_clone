
import 'package:amazon_clone/common/widgets/cutom_buttom.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../search/screen/search_screen.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget{
  static const String routeName="Orderdetails";

  final Order order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final AdminServices adminServices=AdminServices();
  int currentStep=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep=widget.order.status;
  }
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  //only for admin
  void changeOrder(int status) {
    adminServices.changeOrderStatus(context: context, status: status+1, order: widget.order, onSucess: (){
      currentStep+=1;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar:  PreferredSize(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("View Order Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Data :   ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                    Text("Order ID :       ${widget.order.id}"),
                    Text("Total Price :   \$${widget.order.totalPrice}")
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Purchase Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i=0;i<widget.order.products.length;i++)
                      Row(
                        children: [
                          Image.network(widget.order.products[i].images[0],width: 120,height: 120,),
                          SizedBox(height: 5,),
                          SizedBox(height: 5,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.order.products[i].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,),
                              Text("Qty: ${widget.order.quantity[i]}"),
                            ],
                          )),

                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Tracking",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context,details) {
                    if(user.type=='admin') 
                      return CustomButton(text: "Done", onTap: (){
                        changeOrder(details.currentStep);
                      });
                    return SizedBox();
                  },
                    steps:[
                  Step(title: Text("Pending"), content: Text("Your odrder is yet to be delivered."),isActive: currentStep>0,state: currentStep>0?StepState.complete:StepState.indexed),
                  Step(title: Text("Completed"), content: Text("Your odrder has delivered, You are yet to sign."),isActive: currentStep>1,state: currentStep>1?StepState.complete:StepState.indexed),
                  Step(title: Text("Recieved"), content: Text("Your odrder has delivered and signed by you"),isActive: currentStep>2,state: currentStep>2?StepState.complete:StepState.indexed),
                  Step(title: Text("Delevered"), content: Text("Your odrder has delivered and signed by you"),isActive: currentStep>=3,state: currentStep>=3?StepState.complete:StepState.indexed),
                ] ),
              )
            ],
          ),
        ),
      ),
    );
  }
}