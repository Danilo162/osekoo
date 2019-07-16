import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ocekoo/datas/choix_list.dart';
import 'package:ocekoo/pages/bodypart_list.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/customs.dart';
import 'package:ocekoo/utils/progres_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class IncidentList extends  StatefulWidget{
  @override
  _IncidentList createState() => new _IncidentList();

}
class _IncidentList extends State<IncidentList>{
   List<RadioModel> radioList;
   Map newMap = new Map();
   ProgressDialog pr;
  @override
  Widget build(BuildContext context) {


    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Partientez svp...');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: new Container(
        child: Stack(
          children: <Widget>[
        TopPrograssBar(
        progressBarImagePath: "assets/body/step_1.png",
        ),
            TopTitle(
              topMargin: 60.0,
              leftMargin: 50.0,
              title: "SELECTIONNEZ VOTRE MAL",
            ),
          Container(
            alignment: Alignment.center,
           margin: EdgeInsets.only(top: 50.0),
            child:Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80.0),
              child: _rubriqueList(),
            ),
          ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                onPressed: () {
                    Utils().showMyDialog(context, "Please Select A Option");
                },
              ),
            ),
            MyBackButton(),
          ],
        ),
      ),
    );
  }



   Widget _rubriqueList(){
    return  Container(
      child: GridView.builder(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
        ),
        itemBuilder: (_, int index){
          return GestureDetector(
            onTap: ()async
            {
              bool islocation = await Geolocator().isLocationServiceEnabled();

              if(islocation){
                pr.show();
                newMap['incident'] = incidentTypeList[index].text;

                Map<PermissionGroup, PermissionStatus> permissions = await
                PermissionHandler().requestPermissions([
                  PermissionGroup.location ,PermissionGroup.locationAlways]);

                if(permissions.length>1) {
                  Position position = await Geolocator().getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
                  if(placemark.length>0) {
                    setState(() {
                      newMap['lat'] = position.latitude.toString();
                      newMap['long'] = position.longitude.toString();
                      newMap['subLocality'] =
                          placemark[0].subLocality + " " + placemark[0].postalCode +
                              " "
                                  "" + placemark[0].subThoroughfare + " (" +
                              placemark[0].country + ")";
                      print(newMap);
                    });
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => FullPageHumanAnatomy(incidentTypeList[index].text,newMap)));
                  }

                }

              }else{
                Utils().showMyDialog(context,"Veuillez activez votre gps ou gélocalisation");
              }


            },
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30.0,
                  child: incidentTypeList[index].radioIcon,
                  backgroundColor: incidentTypeList[index].selectedColor,
                ),
                SizedBox(height: 8.0,),
                Text(incidentTypeList[index].text)
              ],
            ),
          );
        },
        itemCount: incidentTypeList.length,

      ),
    );
   }

    }