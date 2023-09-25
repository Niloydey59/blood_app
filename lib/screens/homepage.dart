import 'package:blood_app/utils/routes.dart';
import 'package:blood_app/widgets/drawer.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,

      appBar: AppBar(
          elevation: 3,
      ),
      body: SafeArea(
        child: Column(
          children:
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    HomeIcons(image: "assets/images/form.png", name: "Request Blood", route: 'Req',),
                    HomeIcons(image: "assets/images/feed.png", name: "Feed", route: 'Feed',),
                  ],
                ).py16(), //Icons

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    HomeIcons(image: "assets/images/list.png", name: "Donor List", route: 'List',),
                    HomeIcons(image: "assets/images/bank.png", name: "Blood Banks", route: 'Banks',),
                  ],
                ).py16(), //Icons
              ]
        ).py16(),
        ),

      drawer: const MyDrawer(),
      );
  }
}

class HomeIcons extends StatelessWidget {
  //const HomeIcons({Key? key}) : super(key: key);
  final String image,name;
  final String route;

  const HomeIcons({super.key, required this.image, required this.name, required this.route});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 15,
      borderRadius:BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          if(route=='Req')
            {Navigator.pushNamed(context, MyRoutes.RequestBloodRoute);}
          else if(route=='List')
            {Navigator.pushNamed(context, MyRoutes.DonorListRoute);}
          else if(route=='Feed')
          {Navigator.pushNamed(context, MyRoutes.FeedsRoute);}
          else if(route=='Banks')
          {Navigator.pushNamed(context, MyRoutes.BloodBanksRoute);}
        } ,
        child: AnimatedContainer(
          /*height: 120,*/
          /*width: 120,*/
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image,
                width: 70,
                height: 70,
                //fit: BoxFit.contain,
              ),
              name.text.color(Colors.red).size(16).justify.bold.make(),
            ],
          ),
        ),
      ),
    ).h16(context).w32(context);
  }
}


