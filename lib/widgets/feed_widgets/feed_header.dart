import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class FeedHeader extends StatelessWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:60 ,
          width: 220,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: MyTheme.darkBluishColor,
          ),
          child:"BLOOD REQUESTS".text.center.color(Colors.white).xl3.bold.make().centered(),
        )
      ],
    );
  }
}
