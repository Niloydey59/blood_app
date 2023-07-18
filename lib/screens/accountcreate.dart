import 'package:blood_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blood_app/models/catalog.dart';
import 'package:flutter/services.dart';

class AccountCreate extends StatefulWidget {
  const AccountCreate({Key? key}) : super(key: key);

  @override
  State<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {

  bool user = true;

  String? groupvalue='A+';
  var _groups = [
    'A+','A-','B+','B-','O+','O-','AB+','AB-',
  ];

  final _formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  /*TextEditingController groupController = TextEditingController();*/
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override

  void initState(){
    super.initState();
    //login();
  }

  movetohome(BuildContext context)async{
    print("moved");
    if(_formkey.currentState!.validate() && user==false) {
      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, MyRoutes.HomeRoute);
      setState(() {});
    }
  }

  getUsername(username)  async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("persons").get();
    for(var docsnapshot in qn.docs){
      //print('${docsnapshot['username']}');
      if(docsnapshot['username']==username)
        {
          //print(("Found"));
            user=true;
            //print(user.toString());
            return;
        }
    }
      user=false;
    //print(user.toString());
  }

  createAccount(BuildContext context)async{
    final username = usernameController.text;
    final password = passwordController.text;
    final email = emailController.text;
    final mobile  = mobileController.text;
    final group = groupvalue;
    final location = locationController.text;
    final name = nameController.text;

    await getUsername(username);
    //print("found ${user.toString()}");

      if(user==true){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Account Creation Failed'),
                content: const Text('Username already exists. Please choose a different username.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                  )
                ],
              );
            },
        );
      }
      else if(email.isEmpty || mobile.isEmpty || group==null)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(

                  title: const Text("Account Creation Failed"),
                  content: const Text("Please enter all required fields"),

                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"),
                    )
                  ],

                );
              },
          );
        }

      else if(user==false){
        final person = Person(
          name, // Use the entered name
          group, // Use the entered group
          mobile, // Use the entered mobile
          username, // Use the entered username
          password, // Use the entered password
          email,
          location,
        );

        await addPersonData(person);
        await movetohome(context);
      }
  }

  addPersonData(Person user)async{
    final db = FirebaseFirestore.instance.collection("persons").add({
      'name': user.name,
      'group':user.group,
      'mobile':user.mobile,
      'username':user.username,
      'password':user.password,
      'email':user.email,
      'location':user.location
    });
  }

  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/blood.jpg",
                  fit: BoxFit.fitWidth,
                ),//logo

                const SizedBox(
                  height: 50,
                ),

                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),//Welcome

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter your full name",
                          labelText: "Name",
                        ),

                        controller: nameController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Name required";
                          }
                          return null;
                        },
                      ),//Name

                      const SizedBox(
                        height: 40,
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter username",
                          labelText: "Username",
                        ),

                        controller: usernameController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Username required";
                          }
                          return null;
                        },
                      ),//Username

                      const SizedBox(
                        height: 40,
                      ),

                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password"
                        ),

                        controller: passwordController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Password required";
                          }
                          else if(value==null || value.length<8) {
                            return "Password must be greater than 8 digit";
                          }
                          return null;
                        },
                      ), //Password

                      const SizedBox(
                        height: 40,
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter Email Address",
                            labelText: "Email"
                        ),

                        controller: emailController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Email address required";
                          }
                          return null;
                        },
                      ), //Email

                      const SizedBox(
                        height: 40,
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter Mobile Number",
                            labelText: "Number"
                        ),

                        controller: mobileController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Mobile number required";
                          }
                          return null;
                        },
                      ), //Number

                      const SizedBox(
                        height: 40,
                      ),

                      DropdownButton(
                        dropdownColor: Colors.white,
                        hint: const Text("Chose a Blood Group"),
                        items: _groups.map((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        value: groupvalue,
                        onChanged: (String? newValueSelected) {
                          setState(() {
                            groupvalue=newValueSelected;
                          });
                        },
                      ), //Group

                      const SizedBox(
                        height: 40,
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter your location",
                          labelText: "Location",
                        ),

                        controller: locationController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Location required";
                          }
                          return null;
                        },
                      ), //Location

                      const SizedBox(
                        height: 40,
                      ),

                      Material(
                        color: Colors.deepPurple,
                        child: InkWell(
                          onTap: ()=> createAccount(context),

                          child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 150,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ),
                      ) //Create Account Button
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
