import 'package:blood_app/utils/routes.dart';
import 'package:blood_app/widgets/drawer.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  //const HomePage({Key? key}) : super(key: key);
  @override
  void initState(){
    super.initState();
    _controller1 = AnimationController(
      value: 0,
      duration: Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
    _controller2 = AnimationController(
      value: 0.5,
      duration: Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }
  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      /*appBar: AppBar(
          elevation: 3,
      ),*/
      body: Column(
          children:
              [
                Stack(
                  alignment: Alignment.center,
                  children:[
                    AnimatedBuilder(
                        animation: _controller1,
                        child: Container(
                            height: size.height*0.3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]
                              ),
                            )
                        ),
                        builder: (context, child)
                        {
                          return ClipPath(
                            clipper: DrawClip(_controller1.value),
                            child: child,
                          );
                        }
                    ),

                    AnimatedBuilder(
                        animation: _controller2,
                        child: Container(
                            height: size.height*0.3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [Colors.redAccent, Color(0xFFFCDD89)]
                              ),
                            )
                        ),
                        builder: (context, child)
                        {
                          return ClipPath(
                            clipper: DrawClip(_controller2.value),
                            child: child,
                          );
                        }
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 46,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Donate Blood,Save Lives',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

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

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;

  DrawClip(this.move);

  @override
  Path getClip(Size size) {
    //print(move);
    Path path = Path();
    path.lineTo(0, size.height * 0.8);

    double xcenter =
        size.width * 0.5 + (size.width * 0.6) * math.sin(move * slice);
    double ycenter = size.height * 0.8 + 60 * math.cos(move * slice);

    path.quadraticBezierTo(xcenter, ycenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}


