import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/screens/donor_details.dart';
import 'package:blood_app/widgets/list_widgets/donor_image.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedList extends StatelessWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("feeds").snapshots(),
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
                  final req = Feed(
                      data["name"],
                      data["group"],
                      data["mobile"],
                      data["location"],
                    data["des"],
                  );
                  return InkWell(
                      /*onTap: () =>
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => DonorDetailsPage(donor: donor)
                          )
                          ),*/
                      child: PersonRequest(req: req)
                  );
                }
            );
          }
        }
    );
  }
}
class PersonRequest extends StatelessWidget {
  //const CatalogPerson({Key? key}) : super(key: key);

  final Feed req;

  const PersonRequest({super.key, required this.req}):
        assert(req!=null);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            "${req.name}".text.lg.color(MyTheme.darkBluishColor).bold.make(),

            Container(
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 3,
                      colors: [
                        Vx.red400,
                        Vx.red800,
                      ]
                  ),
              ),
              child: Text("Request For",
                style: TextStyle(
                  color: Colors.white,
                ),
              ).centered(),
            ).backgroundColor(Colors.red).h4(context),

            Expanded(child: Row(
              children: [
                Container(
                    color: Color.fromRGBO(136, 8, 8, 50),
                    child: "${req.group}".text.bold.white.xl.makeCentered()
                ).wh(40, 40).px16().centered(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    "Location: ${req.location}".text.bold.xl.color(MyTheme.darkBluishColor).make(),

                    10.heightBox,
                    "Amount: ${req.location}".text.bold.xl.color(MyTheme.darkBluishColor).make(),

                    10.heightBox,
                    "Mobile: ${req.mobile}".text.bold.xl.color(MyTheme.darkBluishColor).make(),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  //buttonPadding: Vx.mOnly(right: 16),
                  children: [
                    ElevatedButton(
                        onPressed: () async{
                          await FlutterPhoneDirectCaller.callNumber(req.mobile);
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
                    )
                  ],
                )
              ],
            )
            ),
            Text("${req.des}",
              textAlign: TextAlign.left,
              )
          ],
        )
    ).gray300.roundedLg.square(170).make().py16();
  }
}




