import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ocekoo/pages/incident_list.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
class CustomFloat extends StatefulWidget {
  final IconData icon;
  final Widget builder;
  final VoidCallback qrCallback;
  final isMini;

  CustomFloat({this.icon, this.builder, this.qrCallback, this.isMini = false});
  @override
  _CustomFloatState createState() => new _CustomFloatState();
}

class _CustomFloatState extends State<CustomFloat> {
  static const platform_ml = const MethodChannel ('com.con7ptoo.cardstore.ml');

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      mini: widget.isMini,
      onPressed:
          () async{

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => IncidentList()),);

           // _scanneMode(context);
        //   onPickImageSelected(context);
      },
      child: Ink(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: Cst.kitGradientsOrange)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.white,
            ),
            widget.builder != null
                ? Positioned(
                    right: 2.0,
                    top: 2.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: widget.builder,
                      radius: 10.0,
                    ),
                  )
                : Container(),
            // builder
          ],
        ),
      ),
    );
  }
  Widget _scanneheader() {
    return Ink(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        decoration:Cst.gradiantblueGry(),
        constraints: BoxConstraints.expand(height: 40.0),
        child: Center(
          child: Row(
            children: <Widget>[
             Icon(Icons.info,size: 24.0,color: Colors.red,),
              SizedBox(
                width: 20.0,
              ),
              Text("CHOISISSEZ VOTRE MODE DE SCANNE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize:  Utils.TEXT_14_SIZE_NORMAL,),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _scanneMode(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        //  color: Utils.GREEN,
        color: Colors.white70,
        height: 180.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           _scanneheader(),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(child: Card(
                    elevation: 1.0,
                    child: Container(
                        height: 80.0,
                        width: 100.0,
                        child:
                        Column(children: <Widget>[
                          Icon(Icons.group_work,size: 60.0,color: Colors.green,),
                          Text("Groupe Existant",style: TextStyle(fontSize: Utils.TEXT_10_SIZE_SMALL,
                              fontFamily: Utils.fontSubtitle),)
                        ],))) ,
                    onTap: (){
//              Navigator.push(
//            context,
//            new MaterialPageRoute(
//            builder: (context) => ScannePage("00")),);
                      //_groupeSelected(context);
                    },),
              InkWell(child:
                    Card (
                        elevation: 1.0,
                        child: Container(
                            height: 80.0,
                            width: 100.0,
                            child:
                            Column(children: <Widget>[
                              Icon(Icons.group_add,size: 60.0,color: Colors.blue,),
                              Text("Nouveau Groupe",style: TextStyle(fontSize: Utils.TEXT_10_SIZE_SMALL,
                                  fontFamily: Utils.fontSubtitle),)
                            ],))),
                  onTap: (){
                   // _openAddGroupeSmallDialog();
            }),
              InkWell(child:
                    Card (
                        elevation: 1.0,
                        child: Container(
                            height: 80.0,
                            width: 100.0,
                            child:
                            Column(children: <Widget>[
                              Icon(Icons.group_work,size: 60.0,color: Colors.grey,),
                              Text("Aucun Groupe",style: TextStyle(fontSize: Utils.TEXT_10_SIZE_SMALL,
                                  fontFamily: Utils.fontSubtitle),)
                            ],))),
                onTap: (){
//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (context) => ScannePage("0")),
//
//                  );
                },
              ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


}
