import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocekoo/datas/choix_list.dart';
import 'package:ocekoo/pages/layout/body_layout.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/customs.dart';

import 'incident_page.dart';

class FullPageHumanAnatomy extends StatelessWidget {
  var _finalBodyPartList = [];
  final Map mapData;
  final String title;

  FullPageHumanAnatomy(this.title,this.mapData);
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
          //  container != null ? container : Container(),
        TopPrograssBar(
        progressBarImagePath: "assets/body/step_2.png",
        ),
            TopTitle(
              topMargin: 60.0,
              leftMargin: 50.0,
              title: "les partis du corps humain",
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50.0),
              child: HumanAnatomy(
                onChanged: bodyPartList,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                onPressed: () {
                  mapData['bodyPart'] = _finalBodyPartList.toString();
                  _finalBodyPartList.length == 0
                      ? Utils().showMyDialog(
                      context, "Sélectionnez une partie du corps concernée")
                      :
                      print(mapData);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => IncidentPage(mapData)));
                },
              ),
            ),
            MyBackButton(),
          ],
        ),
      ),
    );
  }

  void bodyPartList(List value) {
    _finalBodyPartList = value;
  }
}