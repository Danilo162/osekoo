import 'dart:async';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ocekoo/datas/choix_list.dart';
import 'package:ocekoo/pages/place_detail.dart';
import 'package:ocekoo/utils/constant.dart';

const kGoogleApiKey =Cst.ApiKeyGoogle;
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class LocaliteMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocaliteMapState();
  }
}

class LocaliteMapState extends State<LocaliteMap> {
  final LocaliteMapScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
    CameraPosition _kGooglePlex ;
  static  CameraPosition _kLake ;
  Position position ;
   Set<Marker> markers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosition();
  }
  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    } else {
      expandedChild = Column(children: <Widget>[
          buildPlacesList()
      ],);

    }

    final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Scaffold(

        key: LocaliteMapScaffoldKey,
        appBar: AppBar(
          title: const Text("PLACE PLUS PROCHES"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refresh();
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body:

        new Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                color: Colors.transparent,
            height:  hp(35),
             // height: MediaQuery.of(context).size.height
//           margin: EdgeInsets.only(top:10.0),
                child:
                Stack(
                  children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: position != null ? GoogleMap(
                        onMapCreated: _onMapCreated,
                        mapType: MapType.hybrid,
                        initialCameraPosition: _kGooglePlex,
                        markers: markers,
                        compassEnabled: true,
                        myLocationButtonEnabled: true,

                      ):Text("Chargement")
                  ),
                  Positioned(
//                   right: 0,
//                    bottom: 5,
                    child:  listRubrique(),
                  ),
                ],),

              ),
       Container(
           decoration: BoxDecoration(
               color: Colors.red,
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(16.0),
                   topRight: Radius.circular( 16.0)
               )
           ),
            //  color: Colors.white,
//                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 350,
                child: Column(children: <Widget>[
                  expandedChild
                ],)

            ),

            ],
          ),
        ),
       );
  }

Widget listRubrique(){
  final Function hp = Screen(MediaQuery.of(context).size).hp;
  return
    Align(

    //  alignment: Alignment.bottomRight,
      child:
      Container(
       // color: Colors.red,
        height: hp(14),
        padding: EdgeInsets.all(2.0),
        child:
        Swiper(
          autoplay: false,
          control: new SwiperControl(color: Colors.white),
          itemBuilder: (BuildContext context,int index){
                return  Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(2),
                color: Colors.blue,
                child: Column(
                children: <Widget>[
                CircleAvatar(
                maxRadius: 20.0,
                child: mapRubrique[index].radioIcon,
                backgroundColor: mapRubrique[index].selectedColor,

                ),
                Text(mapRubrique[index].text,style: TextStyle(color: Colors.white),)
                ],
                ));
          },
          itemCount: mapRubrique.length,
//              itemWidth: 400.0,
        ),
//      GridView.builder(
//        //padding: EdgeInsets.all(20),
//        scrollDirection: Axis.horizontal,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 5,
////          mainAxisSpacing: 10.0,
//        ),
//        itemBuilder: (_, int index){
//          return GestureDetector(
//            onTap: ()async
//            {
//            },
//            child:Container(
//              margin: EdgeInsets.all(3.0),
//              padding: EdgeInsets.all(2),
//              color: Colors.blue,
//                child: Column(
//              children: <Widget>[
//                CircleAvatar(
//                  maxRadius: 20.0,
//                  child: mapRubrique[index].radioIcon,
//                  backgroundColor: mapRubrique[index].selectedColor,
//
//                ),
//                Text(mapRubrique[index].text,style: TextStyle(color: Colors.white),)
//              ],
//            )),
//          );
//        },
//        itemCount: mapRubrique.length,
//
//      ),
    )
  );


}
  void refresh() async {
    final center = await getUserLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng> getUserLocation() async {
      final lat = this.position.latitude;
      final lng = this.position.longitude;
      final center = LatLng(lat, lng);
      return center;
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });
    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          markers.add(Marker(
            markerId: MarkerId('newyork1'+f.id),
            position: LatLng(f.geometry.location.lat,f.geometry.location.lng),
            infoWindow: InfoWindow(title: "${f.name}"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          ));



        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    LocaliteMapScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "fr",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
  Future getPosition () async{
    position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _kGooglePlex = CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 14.4746,);
      this.position = position;
      this._kGooglePlex = _kGooglePlex;
    });
  }
  onpositionChange(){
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
         this.position = position;
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
        });

  }

  void _openBottomSheet(context,String menuopen) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        //  color: Utils.GREEN,
        color: Colors.white70,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          //  _header(),
            Expanded(
              child: Container(
                child: Text("dddfd")
            //menuList(menuopen),
              ),
            ),


          ],
        ),
      ),
    );
  }


}
