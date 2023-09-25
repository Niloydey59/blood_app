import 'package:blood_app/widgets/bank_widgets/bank_header.dart';
import 'package:blood_app/widgets/bank_widgets/bank_list.dart';
import 'package:blood_app/widgets/list_widgets/donor_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BloodBanks extends StatefulWidget {
  const BloodBanks({Key? key}) : super(key: key);

  @override
  State<BloodBanks> createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  @override

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            /*decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin:Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Vx.red200,
                      Vx.pink700,
                    ]
                )
            ),*/
            padding: Vx.m32,
            child: Column(
              children: [
                const BankHeader(),
                if(FirebaseFirestore.instance.collection("blood_banks").get()!=null)
                  const BankList().py16().expand()
                else
                  const Center(child: CircularProgressIndicator(),).centered().py16().expand(),
              ],
            ),
          ),
        )
    );
  }
}
