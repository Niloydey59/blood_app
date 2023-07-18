import 'package:blood_app/models/catalog.dart';
import 'package:blood_app/widgets/list_widgets/donor_image.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:velocity_x/velocity_x.dart';

class DonorDetailsPage extends StatelessWidget {
  //const DonorDetailsPage({Key? key}) : super(key: key);

  final Person donor;
  const DonorDetailsPage({super.key, required this.donor}):
  assert(donor!=null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
      ),

      backgroundColor: MyTheme.creamColor,

      bottomNavigationBar: Container(
        color: Colors.white,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          //buttonPadding: Vx.mOnly(right: 16),
          children: [
            "${donor.mobile}".text.bold.xl4.red800.make(),
            ElevatedButton(
                onPressed: () async{
                  await FlutterPhoneDirectCaller.callNumber(donor.mobile);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      MyTheme.darkBluishColor,
                    ),
                    shape: MaterialStateProperty.all(
                        const StadiumBorder()
                    )
                ),
                child: "Call".text.make()
            ).wh(100, 50)
          ],
        ).p16(),
      ), //Call Button

      body: SafeArea(
        bottom:false,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin:Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Vx.red300,
                    Vx.red800,
                  ]
              )
          ), //Color  Gradiant
          
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Hero(
                    tag: Key(donor.username),
                    child: const DonorImage(),
                ).h32(context),

                Expanded(
                    child:VxArc(
                        height: 30,
                        edge: VxEdge.TOP,
                        arcType: VxArcType.CONVEY,
                        child: Container(
                          color: Colors.white,
                          width: context.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Donor Name: ${donor.name}".text.xl2.color(MyTheme.darkBluishColor).bold.make(),
                              "Blood Group: ${donor.group}".text.xl2.color(MyTheme.darkBluishColor).bold.make(),
                              "Email: ${donor.email}".text.xl2.color(MyTheme.darkBluishColor).bold.make(),
                              "Location: ${donor.location}".text.xl2.color(MyTheme.darkBluishColor).bold.make(),
                            ],
                          ).py32().px16(),
                        )
                    )
                ) //Details
              ],
            ),
          ),
        ),
      ),
    );
  }
}
