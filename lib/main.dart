import 'package:blood_app/screens/accountcreate.dart';
import 'package:blood_app/screens/donor_list_page.dart';
import 'package:blood_app/screens/feeds.dart';
import 'package:blood_app/screens/homepage.dart';
import 'package:blood_app/screens/loginpage.dart';
import 'package:blood_app/screens/request_blood.dart';
import 'package:blood_app/screens/signin.dart';
import 'package:blood_app/utils/routes.dart';
import 'package:blood_app/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: "/login",
      routes: {
        MyRoutes.HomeRoute: (context)=> HomePage(),
        MyRoutes.LoginRoute: (context)=> const LoginPage(),
        MyRoutes.AccountRoute: (context)=> const AccountCreate(),
        MyRoutes.SigninRoute:(context)=> const Signin(),
        MyRoutes.DonorListRoute:(context) => const DonorListPage(),
        MyRoutes.RequestBloodRoute:(context) => const ReqBlood(),
        MyRoutes.FeedsRoute:(context) => const FeedListPage(),
      }
    );
  }
}


