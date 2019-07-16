import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocekoo/pages/auth/LoginScreen.dart';
import 'package:ocekoo/pages/auth/SignUpScreen.dart';
import 'package:ocekoo/pages/home_page.dart';
import 'package:ocekoo/pages/notfound_page.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async{
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());}

class MyApp extends StatelessWidget {

  final materialApp = MaterialApp(
      title: Cst.appName,
      theme: ThemeData(
          primaryColor: Colors.black54,
          fontFamily: Utils.fontTitleBold,
          primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: HomePages(),// initialRoute: Cst.notFoundRoute,
      //routes
      routes: <String, WidgetBuilder>{
        Cst.homeRoute: (BuildContext context) => HomePages(),
        Cst.R_LOGIN: (BuildContext context) => LogInScreen(),
        Cst.R_SIGNIN: (BuildContext context) => SignUpScreen(),

      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
            appTitle: Cst.coming_soon,
            icon: FontAwesomeIcons.solidSmile,
            title: Cst.coming_soon,
            message: "Under Development",
            iconColor: Colors.orange,
          )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}