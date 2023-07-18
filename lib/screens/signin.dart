import 'package:blood_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String name="";
  bool changebutton=false;
  //bool login=false;
  bool user=true;
  bool pass=true;

  final _formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override

  void initState(){
    super.initState();
    //login();
  }

  movetohome(BuildContext context)async{
    print("moved");
    if(_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, MyRoutes.HomeRoute);
      setState(() {changebutton = false;});
    }
  }

  getUsername(username)  async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("persons").get();
    for(var docsnapshot in qn.docs){
      //print('${docsnapshot['username']}');
      if(docsnapshot['username']==username)
      {
        print(("Found"));
        user=true;
        print(user.toString());
        return;
      }
    }
    print(("Not Found"));
    user=false;
    //print(user.toString());
  }

  getpassword(username,password)async{
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("persons").get();
    for(var docsnapshot in qn.docs){
      //print('${docsnapshot['username']}');
      if(docsnapshot['username']==username && docsnapshot['password']==password)
      {
        print(("Found"));
        print("${docsnapshot['username']} = ${docsnapshot['password']}");
        pass=true;
        print(user.toString());
        return;
      }
    }
    print("Pass not found");
    pass=false;
    print(pass.toString());
  }

  isLogin(BuildContext context)async{
    print("In login");
    final username = usernameController.text;
    final password = passwordController.text;

    await getUsername(username);

    if(user==false)
      {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('No user Found.Please check username'),
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

    else
      {
        await getpassword(username, password);
        if(pass==false){
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: const Text('Wrong Password.'),
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
        else{
          await movetohome(context);
        }

      }

    /*if(login==false && username!=null){
      Widget okButton = TextButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: Text("OK"),
      );
      AlertDialog alert = AlertDialog(
        title: Text("My title"),
        content: Text("No user foundd."),
        actions: [
          okButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    print("Before moving");
    movetohome(context);*/
  }


  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome $name",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter username",
                  labelText: "Username",
                ),

                controller: usernameController,
                validator: (value){
                  if(value==null || value.isEmpty) {
                    return "Username required";
                  }
                  return null;
                },
                onChanged: (value){
                  name=value;
                  setState(() {});
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter password",
                  labelText: "Password",
                ),

                controller: passwordController,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Password required";
                  }
                  else if(value==null || value.length<6){
                    return "Password must be greater than 8 digit";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),

              Material(
                color: Colors.deepPurple,
                borderRadius:
                BorderRadius.circular(changebutton ? 50 : 8),
                child: InkWell(

                  onTap: () async =>await isLogin(context),

                  child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: changebutton ? 50:150,
                      height: 50,
                      alignment: Alignment.center,

                      child: changebutton ? const Icon(
                        Icons.done,
                        color: Colors.white,
                      ):const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
