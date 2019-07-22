import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ocekoo/utils/classes.dart';


class Cst {
  //routes
  static const String BASE_PATH = "http://192.168.1.105/osekoo";
  static const String BASE_PUBLIC = BASE_PATH+"/public/";
  static const String URL_SEND = BASE_PATH+"/mobile/getaccident";
  static const String URL_SEND_LOGIN = BASE_PATH+"/mobile/login";


  static const String homeRoute = "/home";
  static const String R_LOGIN = "/login";
  static const String R_SIGNIN = "/signin";
  static const String R_ALERTE = "/alerte";
  static const String R_ROUTE_MAP = "/alerte";
  static const String R_INFO = "/info";
  static const String ACCOUNT_RT = "/account";
  static const String PROFILE_RT = "/profile";
  static const String ISLOGIN = "ISLOGIN";
  static const String USER_ID = "USER_ID";
  static const String USER_NAME = "USER_NAME";
  static const String USER_PRENOM = "USER_PRENOM";
  static const String USER_PHONE = "USER_PHONE";
  static const String USER_EMAIL = "USER_EMAIL";
  static const String USER_PHOTO = "USER_PHOTO";

  static const ApiKeyGoogle = "AIzaSyAg2JiVvGTq9PI5u5KF3B5VXBVkuhDPQak";

  static const String FACE_GROUP_LIMIT = '100';
  static const bool  IS_SECTEUR = false;

//  PREFERENCE CONST
  static const String IS_PHONE_SAVE = 'IS_PHONE_SAVE';
  static const String IS_FIRST_USE = 'IS_FIRST_USE';

  static const String URL_SEND_SMS = 'http://sms.biam-assist.com/message/sendsms';

  // MAIL
  static const String MAILING_USERNAME = 'senderinfo35@gmail.com';
  static const String MAILING_PASSWORD = 'sender@2019';


  //strings
  static const String appName = "O SECOO";


  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String CAMERA_SOURCE = 'CAMERA_SOURCE';
  static const String GALLERY_SOURCE = 'GALLERY_SOURCE';
  //login

//

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";

  static const MaterialColor ui_kit_color = Colors.grey;
  static const MaterialColor uired = Colors.red;

//colors
  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradientsOrange = [
    Colors.red.shade800,
    Colors.deepOrange,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
  static  gradiantFirst(){
    return  new BoxDecoration(
        gradient: new LinearGradient(colors: [Colors.blue[700],Colors.purple[500]],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp));
  }
  static  gradiantThoud(){
    return  new BoxDecoration(
        gradient: new LinearGradient(colors: [Colors.white,Colors.red[500]],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [1,1.0],
            tileMode: TileMode.clamp));
  }
  static  gradiantSecond(){
    return  new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color.fromRGBO(58, 66, 86, 1.0),
        const Color.fromRGBO(58, 66, 86, 0.9)],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.2, 0.1),
            stops: [0.5,1.0],
            tileMode: TileMode.clamp));
  }
  static  gradiantThird(){
    return  new BoxDecoration(
        gradient: new LinearGradient(colors: [Colors.blue,
        Colors.blue],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.2, 0.1),
            stops: [0.5,1.0],
            tileMode: TileMode.clamp));
  }
  static gradiantRedLinaer(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 0.9],
        colors: [
          Colors.red,
          Colors.deepOrange.shade300
        ]
    ));
  }
  static gradiantOrangeWhite(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.1, 0.9],
        colors: [
          Colors.deepOrange.shade400,
          Colors.white70
        ]
    ));
  }
  static gradiantgrey(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 0.9],
        colors: [
          Colors.grey,
          Colors.white
        ]
    ));
  }
  static gradiantblue(){
   return new BoxDecoration(
       gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        stops: [0.7, 0.2],
        colors: [
          Colors.blueGrey.shade700,
          Colors.white70
        ]
    ));
  }
  static gradiantgrey2(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 0.9],
        colors: [
          Colors.blue.shade300,
          Colors.blue.shade300
        ]
    ));
  }
  static gradiantRedLinaero(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 0.9],
        colors: [
          Colors.red,
          Colors.deepOrange.shade600
        ]
    ));
  }
  static gradiantBlue(){
   return new BoxDecoration(gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 0.9],
        colors: [
          Utils.TEXT_BLUE,
          Colors.blue.shade800
        ]
    ));
  }
  static gradiantBlueC(){
   return new BoxDecoration(gradient: new LinearGradient(
       begin: Alignment.centerLeft,
       end: Alignment.bottomRight,
       stops: [0.85, 0.2],
       colors: [
       Colors.blueGrey.shade700,
       Colors.white70]
    ));
  }
  static appBrDecoration(){
   return new Container(
     decoration: BoxDecoration(
       gradient: LinearGradient(
         colors: [
           Colors.red,
           Colors.orange,
         ],
       ),
     ),
   );
  }
   static  appDecoDecoration2(){
   return   BoxDecoration(
       gradient: LinearGradient(
         colors: [
           Colors.red,
           Colors.orange,
         ],
       ));
   }
   static  gradiantblueGry(){
   return   BoxDecoration(
       gradient: LinearGradient(
         colors: [
           Colors.blue,
           Colors.grey,
         ],
       ));
   }

}
