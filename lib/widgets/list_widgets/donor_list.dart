import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/screens/donor_details.dart';
import 'package:blood_app/widgets/list_widgets/donor_image.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorList extends StatelessWidget {
  const DonorList({Key? key}) : super(key: key);

  /*Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("persons").get();
    return qn.docs;
  }*/
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("persons").snapshots(),
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
                final donor = Person(
                    data["name"],
                    data["group"],
                    data["mobile"],
                    data["username"],
                    data["password"],
                    data["email"],
                    data["location"]);
                return InkWell(
                    onTap: () =>
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => DonorDetailsPage(donor: donor)
                        )
                        ),
                    child: CatalogPerson(donor: donor)
                );
              }
          );
        }
      }
        );
      }
  }
class CatalogPerson extends StatelessWidget {
  //const CatalogPerson({Key? key}) : super(key: key);

  final Person donor;

  const CatalogPerson({super.key, required this.donor}):
  assert(donor!=null);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
            Hero(
              tag: Key(donor.username),
                child: DonorImage().w(110).h(120),
            ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              16.heightBox,
              "Name: ${donor.name}".text.lg.color(MyTheme.darkBluishColor).bold.make(),
              10.heightBox,
              "${donor.mobile}".text.bold.xl.color(MyTheme.darkBluishColor).make(),
              //"Blood Group: ${donor.group}".text.lg.color(MyTheme.darkBluishColor).bold.make(),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                //buttonPadding: Vx.mOnly(right: 16),
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        await FlutterPhoneDirectCaller.callNumber(donor.mobile);
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
                            size: 20,
                            CupertinoIcons.phone,
                          ),
                          4.widthBox,
                          "Call".text.make(),
                        ],
                      )
                  ),
                ],
              )
            ],
          ).wh(150, 150)
          ),
          Container(
            color: Color.fromRGBO(136, 8, 8, 50),
            child: "${donor.group}".text.bold.white.xl.makeCentered()
          ).wh(40, 40).px16()
        ],
      )
    ).gray300.roundedLg.square(150).make().py16();
  }
}




