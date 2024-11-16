import 'package:amazon_clone/common/widgets/custome_text_field.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/cutom_buttom.dart';

enum Auth{
  signIn,
  signUp,
}
class AuthScreen extends StatefulWidget {
  static const String routeName="Auth-Screen";
  @override
  State<StatefulWidget> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  final SignUpkey = GlobalKey<FormState>();
  final SignInkey = GlobalKey<FormState>();

  Auth _auth=Auth.signUp;

  final AuthServices authServices=AuthServices();

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();

  void signUpUser() {
    authServices.signUpUser(context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authServices.signInUser(context: context,
        email: _emailController.text,
        password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text("Welcome",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                ListTile(
                  tileColor: _auth==Auth.signUp?GlobalVariable.backgroundColor:GlobalVariable.greyBackgroundColor,
                  title: const Text("Create Account",style: TextStyle(fontWeight:FontWeight.bold ),),
                  leading: Radio(
                    value: Auth.signUp,
                    groupValue: _auth,
                    activeColor: GlobalVariable.secondaryColor,
                  onChanged: (Auth? val){
                      setState(() {
                        _auth=val!;
                      });
                  },),
                ),
                if(_auth==Auth.signUp)
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key:SignUpkey ,
                          child: Column(
                            children: [
                              CustomeTextField(hinttext:"Name",controller: _nameController),
                              SizedBox(height: 10,),
                              CustomeTextField(hinttext:"Email",controller: _emailController),
                              SizedBox(height: 10,),
                              CustomeTextField(hinttext:"Password",controller: _passwordController),
                              SizedBox(height: 10,),
                              CustomButton(text: "Sign-Up", onTap: (){
                                if(SignUpkey.currentState!.validate()) {
                                  signUpUser();
                                }
                              })
                            ],
                          )),
                    ),
                  ),
                ListTile(
                  tileColor: _auth==Auth.signIn?GlobalVariable.backgroundColor:GlobalVariable.greyBackgroundColor,
                  title: const Text("Sign-In.",style: TextStyle(fontWeight:FontWeight.bold ),),
                  leading: Radio(
                    value: Auth.signIn,
                    groupValue: _auth,
                    activeColor: GlobalVariable.secondaryColor,
                    onChanged: (Auth? val){
                      setState(() {
                        _auth=val!;
                      });
                    },),
                ),
                if(_auth==Auth.signIn)
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          key:SignInkey ,
                          child: Column(
                            children: [
                              CustomeTextField(hinttext:"Email",controller: _emailController),
                              SizedBox(height: 10,),
                              CustomeTextField(hinttext:"Password",controller: _passwordController),
                              SizedBox(height: 10,),
                              CustomButton(text: "Sign In", onTap: (){
                                if(SignInkey.currentState!.validate()) {
                                  signInUser();
                                }
                              })
                            ],
                          )),
                    ),
                  ),
                    ],
                  ),
          )),
    );
  }

}