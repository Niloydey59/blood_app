import 'package:blood_app/widgets/request_widgets/request_form.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/widgets/list_widgets/donor_header.dart';
import 'package:blood_app/widgets/list_widgets/donor_list.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReqBlood extends StatefulWidget {
  const ReqBlood({Key? key}) : super(key: key);

  @override
  State<ReqBlood> createState() => _ReqBloodPageState();
}

class _ReqBloodPageState extends State<ReqBlood> {
  @override

  void initState(){
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.red600,
        centerTitle: true,
        title: "Request Blood".text.xl3.justify.semiBold.make(),
      ),
        body: SafeArea(
          child: Column(
              children: [
                //const DonorHeader(),
                ReqForm().py16().expand(),
                ],
            ),
          ),
        );
  }
}
