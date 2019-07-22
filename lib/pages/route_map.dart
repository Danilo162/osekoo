import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/customs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
class RouteMap extends  StatefulWidget{
  @override
  _RouteMap createState() => new _RouteMap();

}
class _RouteMap extends State<RouteMap>{

  double latitude,longitude;

  Completer<GoogleMapController> _controller = Completer();
  static  CameraPosition _kGooglePlex ;
  static  CameraPosition _kLake ;

  Position position ;
  double zoomVal=5.0;

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Cst.ApiKeyGoogle);
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;

//
@override
void initState() {
  // TODO: implement initState
  super.initState();

  getPosition();


}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Lieux les plus proches"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: new Container(
        child: Stack(
          children: <Widget>[
          Container(
            alignment: Alignment.center,
//           margin: EdgeInsets.only(top:10.0),
            child:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
//              margin: EdgeInsets.only(top: 8),
              child: this.latitude != null && this.longitude != null ?
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ):CircularProgressIndicator(backgroundColor: Colors.blue,),
            ),
          ),
          //  _buildContainer(),
          //  MyBackButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future getPosition () async{
    position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      _kGooglePlex = CameraPosition(target: LatLng(this.latitude, this.longitude),zoom: 14.4746,
      );
      _kLake =  CameraPosition(bearing: 192.8334901395799,target: LatLng(this.latitude, this.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);
    });


  }


}
