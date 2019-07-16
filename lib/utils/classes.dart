import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

 static void showAlertDialog(String title, String message,BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
     showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
 static void showAlertDlgAction(String title, String message,
     BuildContext context,String widgetgroupe_id) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        new FlatButton(onPressed: (){


        }, child: Text("Accueil")),
        new FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child:  Text("Liste"))
      ],
    );
     showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
 showMyDialog(context, String text) {
   // flutter defined function

   showDialog(
       context: context,
       // return object of type AlertDialog
       child: new CupertinoAlertDialog(
         title: new Text("Massage"),
         content: new Text(text),
         actions: <Widget>[
           new FlatButton(
               onPressed: () {
                 Navigator.of(context).pop();
               },
               child: new Text("OK"))
         ],
       ));
 }
  static toaster(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static toasterblue(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
 static saveFileFromServer() async{
//   var filePath = await ImagePickerSaver.saveFile(
//       fileData: response.bodyBytes);
//
//   var savedFile= File.fromUri(Uri.file(filePath));
    //   _imageFile = Future<File>.sync(() => savedFile);

 }


  // COLORS
  static const TEXT_ORAGNGE = Colors.deepOrange;
  static const TEXT_RED = Colors.red;
  static const TEXT_GREEN = Colors.green;
  static const TEXT_BLUE= Colors.blue;
  static const TEXT_BLUE_ACCENT= Colors.blueAccent;


  // FONT SIZE
 static const TEXT_28_SIZE_BIG = 28.0;
 static const TEXT_24_SIZE_BIG = 24.0;
 static const TEXT_22_SIZE_BIG = 22.0;
 static const TEXT_20_SIZE_BIG = 20.0;
 static const TEXT_18_SIZE_BIG = 18.0;
 static const TEXT_16_SIZE_BIG = 16.0;
  static const TEXT_14_SIZE_NORMAL = 14.0;
  static const TEXT_12_SIZE_NORMAL = 14.0;
 static const TEXT_10_SIZE_SMALL = 10.0;

 // FONT
  static const String fontTitleBold = "times_new_roman_bold.ttf";
  static const String fontSubtitle = "times_new_roman.ttf";
  static const String fontSubtitleItalic = "times_new_roman_italic.ttf";

  static LinearGradient _getLinearGradient(Color left, Color right,
      {begin = AlignmentDirectional.centerStart,
        end = AlignmentDirectional.centerEnd,
        opacity = 1.0}) =>
      LinearGradient(
        colors: [
          left.withOpacity(opacity),
          right.withOpacity(opacity),
        ],
        begin: begin,
        end: end,
      );
// WIDTH
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static String getShortChar(String value) {
    String shortName = "";
    if (value.isNotEmpty) {
      shortName = value.substring(0, 1);
    }
    return shortName;
  }

static getNumber(int nb){
 return nb != null?nb.toString():"0";
}
 static String getStringValue(String val,String defaut){
    return val != null?val:defaut;
  }

}