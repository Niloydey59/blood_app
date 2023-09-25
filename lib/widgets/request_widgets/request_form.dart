import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ReqForm extends StatefulWidget {
  const ReqForm({Key? key}) : super(key: key);
  @override
  State<ReqForm> createState() => _ReqFormState();
}

class _ReqFormState extends State<ReqForm> {


  List<String> groups = [
    'A+','A-','B+','B-','O+','O-','AB+','AB-',
  ];
  String? groupvalue='A+';
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bagController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController desController = TextEditingController();

  createRequest(BuildContext context)async{
    final mobile  = mobileController.text;
    final group = groupvalue;
    final location = locationController.text;
    final name = nameController.text;
    final des = desController.text;

      final person = Feed(
        name, // Use the entered name
        group!, // Use the entered group
        mobile, // Use the entered mobile
        location,
        des,
      );
    if(_formkey.currentState!.validate()){
      await addFeedData(person);
    }
      await movetohome(context);
  }

  addFeedData(Feed req)async{
    final db = FirebaseFirestore.instance.collection("feeds").add({
      'name': req.name,
      'group':req.group,
      'mobile':req.mobile,
      'location':req.location,
      'des':req.des,
    });
  }

  movetohome(BuildContext context)async{
    print("moved");
    if(_formkey.currentState!.validate()) {
      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, MyRoutes.HomeRoute);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
            child: Column(
              children: [

                10.heightBox,

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

                      40.heightBox,

                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        hint: const Text("Chose a Blood Group"),
                        value: groupvalue,
                        items: groups.map((group) =>
                            DropdownMenuItem<String>(
                              value: group,
                                child: Text(group)
                            )).toList(),

                        onChanged: (group)=> setState(() {
                          groupvalue=group;
                        })
                      ), //Group

                      40.heightBox,

                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter amount of reqired blood",
                          labelText: "Amount",
                        ),

                        controller: bagController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Amount required";
                          }
                          return null;
                        },
                      ),//Amount

                      40.heightBox,

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

                      40.heightBox,

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

                      40.heightBox,

                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Provide Description",
                            labelText: "Why Do You Need Blood",
                        ),
                        controller: desController,
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return "Reason required";
                          }
                          return null;
                        },
                      ), //Description

                      40.heightBox,

                      Material(
                        color: Vx.pink700,
                        child: InkWell(
                          onTap: ()=> createRequest(context),

                          child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 150,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Submit Request",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ),
                      ) //Create Request Button
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
