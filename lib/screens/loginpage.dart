import 'dart:convert';
import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/screens/homepage.dart';
import 'package:blood_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:blood_app/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name="";
  @override


  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.red,
      body: Container(
        color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
              ), //Logo

              SizedBox(
                height: 20,
              ),

              /*Text(
                "Welcome $name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),*/

              SizedBox(
                height: 20,
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                  child: Column(
                    children: [

                      Material(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(50),
                        child: InkWell(
                          onTap: ()=>Navigator.pushNamed(context, MyRoutes.SigninRoute),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 220,
                            height: 80,
                            alignment: Alignment.center,
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ), //Signin Button

                      SizedBox(
                        height: 20,
                      ),

                      Material(
                        color: Colors.red,
                        borderRadius:
                        BorderRadius.circular(50),
                        child: InkWell(
                          onTap: ()=>Navigator.pushNamed(context, MyRoutes.AccountRoute),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 220,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white,width: 5)
                            ),
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ), //CreateAccount Button

                      SizedBox(
                        height: 50,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            borderRadius:
                            BorderRadius.zero,
                            child: InkWell(
                              //onTap: ()=>,
                              child: AnimatedContainer(
                                color: Colors.red,
                                duration: Duration(seconds: 1),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    FloatingActionButton.extended(
                                      onPressed: () async{
                                        Navigator.pushNamed(context, MyRoutes.HomeRoute);
                                      },
                                      backgroundColor: Colors.red,
                                      label: Text("Skip for now",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        )
                                    )
                                  ],
                                )
                              ),
                            ),
                          ),
                        ],
                      ) //Skip for now
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
