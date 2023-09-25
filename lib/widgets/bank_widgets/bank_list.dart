import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/screens/donor_details.dart';
import 'package:blood_app/widgets/list_widgets/donor_image.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BankList extends StatelessWidget {
  const BankList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("blood_banks").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  final bank = Banks(
                    data["name"],
                    data["district"],
                    data["address"],
                    data["mobile"],
                  );
                  return InkWell(
                    /*onTap: () =>
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => DonorDetailsPage(donor: donor)
                          )
                          ),*/
                      child: Blood_Banks(bank: bank)
                  );
                }
            );
          }
        }
    );
  }
}
class Blood_Banks extends StatelessWidget {
  //const CatalogPerson({Key? key}) : super(key: key);

  final Banks bank;

  const Blood_Banks({super.key, required this.bank}):
        assert(bank!=null);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${bank.name}".text.bold.xl.make(),
                    "District: ${bank.district}".text.make(),
                    "Address: ${bank.address}".text.make(),
                    "Mobile: ${bank.mobile}".text.make(),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  //buttonPadding: Vx.mOnly(right: 16),
                  children: [
                    ElevatedButton(
                        onPressed: () async{
                          await FlutterPhoneDirectCaller.callNumber(bank.mobile);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              MyTheme.darkBluishColor,
                            ),
                            shape: MaterialStateProperty.all(
                                StadiumBorder()
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              size: 13,
                              CupertinoIcons.phone,
                            ),
                            //4.widthBox,
                            "Call".text.make(),
                          ],
                        )
                    )
                  ],
                )
              ],
            ),
    ).gray300.roundedLg.size(200, 170).make().py16();
  }
}




