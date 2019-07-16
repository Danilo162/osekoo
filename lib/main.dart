import 'package:flutter/material.dart';
import 'package:ocekoo/pages/home_page.dart';
import 'package:ocekoo/pages/notfound_page.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final materialApp = MaterialApp(
      title: Cst.appName,
      theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: Utils.fontTitleBold,
          primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: HomePages(),// initialRoute: Cst.notFoundRoute,
      //routes
      routes: <String, WidgetBuilder>{
        Cst.homeRoute: (BuildContext context) => HomePages(),
        //  Cst.CARDFRM_RT: (BuildContext context) => CardForm(t),

      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
            appTitle: Cst.coming_soon,
            icon: FontAwesomeIcons.solidSmile,
            title: Cst.coming_soon,
            message: "Under Development",
            iconColor: Colors.green,
          )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}