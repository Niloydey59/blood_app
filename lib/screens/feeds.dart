import 'dart:convert';
import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/widgets/feed_widgets/feed_header.dart';
import 'package:blood_app/widgets/feed_widgets/feed_list.dart';
import 'package:blood_app/widgets/list_widgets/donor_header.dart';
import 'package:blood_app/widgets/list_widgets/donor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedListPage extends StatefulWidget {
  const FeedListPage({Key? key}) : super(key: key);

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
  @override

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          backgroundColor: Vx.red600,
          centerTitle: true,
          //title: "Request Blood".text.xl3.justify.semiBold.make(),
        ),*/
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
                const FeedHeader(),
                if(FirebaseFirestore.instance.collection("feeds").get()!=null)
                  const FeedList().py16().expand()
                else
                  const Center(child: CircularProgressIndicator(),).centered().py16().expand(),
              ],
            ),
          ),
        )
    );
  }
}
