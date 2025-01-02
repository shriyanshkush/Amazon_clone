import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custome_text_field.dart';
import '../../../constants/global_variable.dart';
import '../services/adress_services.dart';

class AdressScreen extends StatefulWidget {
  final String totalamount;
  AdressScreen({required this.totalamount});
   static const String routeName="/adressScreen";
  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  final _adressScreenState =GlobalKey<FormState>();
  final _flatBuildingController =TextEditingController();
  final _areaController =TextEditingController();
  final _pincodeController =TextEditingController();
  final _cityController =TextEditingController();
  final AddressServices addressServices=AddressServices();
  String addressTobeUsed="";


  void onGooglePayResult(paymentResult) {
    try {
      if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
        addressServices.saveUserAdress(context: context, address: addressTobeUsed);
      }
      addressServices.placeOrder(context: context, address: addressTobeUsed, totalSum: double.parse(widget.totalamount));
    } catch (e) {
      showSnackBar(context, "Error processing payment: $e");
    }
  }


  final Future<PaymentConfiguration> _googlePayConfigFuture =
  PaymentConfiguration.fromAsset('googlepay.json');


  List<PaymentItem> _paymentItems = [
  ];

  void payPressed(String adressFromProvider) {
    addressTobeUsed="";

    bool isFrom=_flatBuildingController.text.isNotEmpty ||_areaController.text.isNotEmpty||_pincodeController.text.isNotEmpty||_cityController.text.isNotEmpty;

    if(isFrom) {
      if(_adressScreenState.currentState!.validate()) {
        addressTobeUsed='${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text}, ${_pincodeController.text}';
      } else {
        throw Exception("please enter all values");
      }
    } else if(adressFromProvider.isNotEmpty) {
      addressTobeUsed=adressFromProvider;
    } else{
      showSnackBar(context, "Error");
    }
    print("adress to be used:${addressTobeUsed}");
  }

  @override
  void initState() {
    super.initState();
    _paymentItems.add(PaymentItem(amount: widget.totalamount,label: "Total amount",status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var adress =context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
            decoration: BoxDecoration(
            gradient: GlobalVariable.appBarGradient
                ),
              ),
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(adress.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(adress,style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("OR",style: TextStyle(fontSize: 18),),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key:_adressScreenState ,
                  child: Column(
                    children: [
                      CustomeTextField(hinttext:"Flat, house no, Building",controller: _flatBuildingController),
                      SizedBox(height: 10,),
                      CustomeTextField(hinttext:"Area, Street",controller: _areaController),
                      SizedBox(height: 10,),
                      CustomeTextField(hinttext:"Pincode",controller: _pincodeController),
                      SizedBox(height: 10,),
                      CustomeTextField(hinttext:"Town/City",controller: _cityController),
                      SizedBox(height: 10,),

                    ],
                  )),

              FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? GooglePayButton(
                    onPressed: ()=> payPressed(adress),
                    width: double.infinity,
                    theme: GooglePayButtonTheme.light,
                    paymentConfiguration: snapshot.data!,
                    paymentItems: _paymentItems,
                    type: GooglePayButtonType.buy,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: onGooglePayResult,
                    height: 50,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : const SizedBox.shrink()),
    ],
          ),
        ),
      ),
    );
  }
}