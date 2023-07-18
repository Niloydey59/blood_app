import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DonorImage extends StatelessWidget {
  const DonorImage({Key? key}) : super(key: key);
  //final String image;

  //const DonorImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Icon(
        CupertinoIcons.profile_circled,
      color: MyTheme.darkBluishColor,
    ).box.rounded.p16.white.make().p16().w40(context);
  }
}
