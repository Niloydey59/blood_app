import 'dart:convert';
import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/widgets/list_widgets/donor_header.dart';
import 'package:blood_app/widgets/list_widgets/donor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorListPage extends StatefulWidget {
  const DonorListPage({Key? key}) : super(key: key);

  @override
  State<DonorListPage> createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {
  @override

  void initState(){
    super.initState();
    //getData();
    //loadData();
  }

  /*getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("persons").get();
    setState(() {
    });
  }*/


  /*loadData()async{
    await Future.delayed(const Duration(seconds: 2));
    final catalogJason =
    await rootBundle.loadString("assets/files/catalog.json");
    final decodeData = jsonDecode(catalogJason);
    var personData = decodeData["persons"];
    Catalog.person = List.from(personData)
        .map<Person>((person) => Person.fromMap(person))
        .toList();
    setState(() {});
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Vx.red200,
                  Vx.pink700,
                ]
              )
            ),
            padding: Vx.m32,
            child: Column(
              children: [
                const DonorHeader(),
                if(FirebaseFirestore.instance.collection("persons").get()!=null)
                  const DonorList().py16().expand()
                else
                  const Center(child: CircularProgressIndicator(),).centered().py16().expand(),
              ],
            ),
          ),
        )
      );
  }
}
