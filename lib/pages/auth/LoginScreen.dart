import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/progres_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class LogInScreen extends StatefulWidget {
  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController phone_controller = new TextEditingController();
  final TextEditingController password_controller = new TextEditingController();
  SharedPreferences preferences;
  ProgressDialog pr;
  String nom ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((pref){
      this.preferences = pref;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Connexion ...');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new Scaffold(
      resizeToAvoidBottomPadding: true,
        body:  Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/bac2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                reverse: false,
                children: <Widget>[
                  new SizedBox(height: 20.0,),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: new Text("CONNEXION",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,color: Colors.white,
                                  fontSize: 15.0,
                                ),
                                textAlign: TextAlign.left),
                          )
                        ],
                      ),
                      new SizedBox(height: 15.0,),

                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/images/logo.png",
                            height: 150.0,
                            width: 210.0,
                            fit: BoxFit.scaleDown,
                          )
                        ],
                      ),
                      new Center(
                          child: new Center(
                            child: new Stack(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                    child: new Form(
                                      autovalidate: false,
                                      child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Padding(
                                            padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 40),
                                            child: new TextField(
                                              controller: phone_controller,
                                              autofocus: true,
                                              style: new TextStyle(color: Colors.white),
                                              decoration: new InputDecoration(
                                                labelText: "Contact téléphonique",
                                              hintText: 'Votre Contact téléphonique',
                                              hintStyle: TextStyle(color: Colors.white),
                                                labelStyle: TextStyle(color: Colors.white),
                                                prefixIcon: Padding(padding: EdgeInsets.only(right: 4.0),
                                                    child:Icon(Icons.phone,color: Colors.white)),
                                                  enabledBorder: new OutlineInputBorder(
                                                    borderSide: new BorderSide(color: Colors.white),),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                                    borderSide: BorderSide(width: 1,color: Color(0xFF54C5F8)),
                                                  ),

                                                fillColor: Color(0xFFF2F2F2),
                                                counterStyle: TextStyle(color: Colors.white)
                                              ),
                                              keyboardType: TextInputType.phone,
                                              cursorColor: Colors.white,
                                            ),
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, right: 10.0, top: 5.0),
                                              child: new TextField(
                                                obscureText: true,
                                                autofocus: false,
                                                controller: password_controller,
                                          style: new TextStyle(color: Colors.white),
                                          decoration: new InputDecoration(
                                          labelText: "Mot de passe",
                                          hintText: 'Entrer votre mot de passe',
                                          hintStyle: TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(color: Colors.white),
                                          prefixIcon: Padding(padding: EdgeInsets.only(right: 4.0),
                                          child:Icon(Icons.lock_open,color: Colors.white)),
                                          enabledBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(color: Colors.white),),
                                          focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          borderSide: BorderSide(width: 1,color: Color(0xFF54C5F8)),
                                          ),

                                          fillColor: Color(0xFFF2F2F2),
                                          counterStyle: TextStyle(color: Colors.white)
                                          ),

                                                keyboardType: TextInputType.text,
                                              )),
                                          new Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.0, top: 45.0, bottom: 20.0),
                                            child: new RaisedButton(
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                  new BorderRadius.circular(30.0)),
                                              onPressed: () {
                                                String phone = phone_controller.value.text.trim();
                                                String password = password_controller.value.text.trim();
                                                if (phone.length <1) {
                                                  Fluttertoast.showToast(
                                                      msg: "Entrez votre numero de téléphone svp !",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIos: 1);
                                                }
                                               if (password.length <1) {
                                                  Fluttertoast.showToast(
                                                      msg: "Entrez votre mot de passe svp !",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIos: 1);
                                                } else {
                                                 pr.show();
                                                 connect(phone,password,context);
                                                }
                                              },
                                              child: new Text(
                                                "Se connecter ",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              color: Color(0xFF54C5F8),
                                              textColor: Colors.white,
                                              elevation: 5.0,
                                              padding: EdgeInsets.only(
                                                  left: 80.0,
                                                  right: 80.0,
                                                  top: 15.0,
                                                  bottom: 15.0),
                                            ),
                                          ),
                                          new Column(
                                            children: <Widget>[
                                              new FlatButton(
                                                onPressed: () {
                                                  Navigator
                                                      .of(context)
                                                      .pushNamed(Cst.R_SIGNIN);
                                                },
                                                child: new Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: new Text(
                                                      "Vous êtes nouveau , Créer votre compte",
                                                      style: TextStyle(
                                                          decoration:
                                                          TextDecoration.underline,color: Colors.white,
                                                          fontSize: 15.0),
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ))
                    ],
                  )

                ],),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed

    super.dispose();
    phone_controller.dispose();
    password_controller.dispose();
  }
  Future connect(String phone,String password,BuildContext context) async{

   Map<String, dynamic> infosUser;
    var dio = Dio();
    dio.options.baseUrl = Cst.URL_SEND;

    FormData formData = FormData.from({
      "phone": phone,
      "password":password,
      "token": "ocekoo",
    });
    Response response;
    try {
      await dio.post(
        Cst.URL_SEND_LOGIN,
        data: formData,
        options: new Options(contentType: ContentType.parse("application/x-www-form-urlencoded"),),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      ).then((respon) {
        var data = json.decode(respon.data);
        if(data['success'].toString() == "1"){
          Utils.toasterblue(data['message'].toString());
          infosUser = data['datas'];
           preferences.setString(Cst.USER_ID, infosUser['id'].toString()).then((val){
             if(val){
              // preferences.setString(Cst.USER_ID, infosUser['id'].toString());
               preferences.setString(Cst.USER_NAME, infosUser['nom'].toString());
               preferences.setString(Cst.USER_PRENOM, infosUser['prennom'].toString());
               preferences.setString(Cst.USER_PHONE, infosUser['tel'].toString());
               preferences.setString(Cst.USER_EMAIL, infosUser['email'].toString());
               pr.hide();
               Navigator.of(context).pop();
             }
           });


        }else{
          Utils.toaster(data['message'].toString());
         // Utils.dd("Response", respon.toString());
          pr.hide();
        }
        //   developer.log('response 00', name: data['success']);
      });

      if (response != null) {

      }

    }catch (e) {
      Utils.dd("Response", e.toString());
      print(e);
    }

  }
}
