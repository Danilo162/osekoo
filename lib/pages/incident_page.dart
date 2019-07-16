import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;
import 'package:async/async.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/customs.dart';
import 'package:ocekoo/utils/progres_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as Img;

class IncidentPage extends StatefulWidget {
  final Map mapData;

  IncidentPage(this.mapData);

  @override
  _IncidentPage createState() => _IncidentPage();
}

class _IncidentPage extends State<IncidentPage> {
  Map<String, String> _map = new Map();
  Future<File> _imageFile;
  Image image1;
  ProgressDialog pr;


  @override
  void initState() {
    super.initState();
  //  currentPosition();
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Partientez svp...');
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
              progressBarImagePath: "assets/body/step_3.png",
            ),
            TopTitle(
              topMargin: 60.0,
              leftMargin: 50.0,
              title: "Dernière étape",
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildRecap(),
                  _buildPicText(),
                  _imageContainer()
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed:  () async {
                  pr.show();

               await upload(context);
                 // getHttp();

//                  Navigator.of(context).pushNamedAndRemoveUntil(
//                      Cst.homeRoute, (Route<dynamic> route) => false);

                 // Utils().showMyDialog(context, "Please Select A Option");
                },
              ),
            ),
            MyBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecap() => Container(
        padding: EdgeInsets.only(left: 50.0, bottom: 30.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.mapData['incident'],style: TextStyle(fontSize: Utils.TEXT_22_SIZE_BIG),),
            Text(widget.mapData['bodyPart'],style: TextStyle(fontSize: Utils.TEXT_16_SIZE_BIG)),
            Text(widget.mapData['subLocality'],style: TextStyle(fontSize: Utils.TEXT_16_SIZE_BIG)),
          ],
        ),
      );

  Widget _buildPicText() => new Container(
        padding: EdgeInsets.only(left: 50.0, bottom: 30.0, top: 50.0),
        child: Text(
          "Image de l'incident (facultatif)",
          style: TextStyle(fontSize: 16.0, ),
        ),
      );

  Widget _imageContainer() {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 3.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
              border: new Border.all(width: 1.0, color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            width: 200.0,
            height: 150.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
              child: _previewImage(),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    Map<PermissionGroup, PermissionStatus> permissions =
                        await PermissionHandler()
                            .requestPermissions([PermissionGroup.storage]);
                    if (permissions.length > 0) {
                      _onImageButtonPressed(ImageSource.gallery);
                    }
                  },
                  heroTag: 'image0',
                  tooltip: 'Choisir une image de la galerie',
                  child: const Icon(
                    Icons.photo_library,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      Map<PermissionGroup, PermissionStatus> permissions =
                          await PermissionHandler().requestPermissions([
                        PermissionGroup.camera,
                        PermissionGroup.storage
                      ]);
                      if (permissions.length > 1) {
                        _onImageButtonPressed(
                          ImageSource.camera,
                        );
                      }
                    },
                    heroTag: 'image1',
                    tooltip: 'Prendre une Photo',
                    child: const Icon(Icons.camera_alt, color: Colors.white),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            this._map['image'] = snapshot.data.path;
            return Image.file(
              snapshot.data,
              fit: BoxFit.cover,
            );
          } else if (snapshot.error != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: const Text(
                'Error picking image.',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: const Text(
                'You have not yet picked an image.',
                textAlign: TextAlign.center,
              ),
            );
          }
        });
  }

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }
  Future upload( BuildContext context) async {
    var dio = Dio();
    dio.options.baseUrl = Cst.URL_SEND;

    File myFile = new File(this._map['image']);
    List<int> imageBytes =  myFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);


    FormData formData = FormData.from({
      "incident": widget.mapData['incident'],
      "bodyPart": widget.mapData['bodyPart'],
      "subLocality": widget.mapData['subLocality'],
      "latitude": widget.mapData['lat'],
      "longitude": widget.mapData['long'],
      "image": base64Image,
     // "file": new UploadFileInfo(myFile, "photo.jpg"),
    });
    Response response;
    try {

      await dio.post(
        Cst.URL_SEND,
        data: formData,
        options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      ).then((respon) {
        var data = json.decode(respon.data);
        developer.log('response 0', name: data['success'].toString());
        this.pr.hide();
        if(data['success'].toString() == "1"){
          Utils.toasterblue(data['message'].toString());
          Navigator.of(context).pushNamedAndRemoveUntil(
         Cst.homeRoute, (Route<dynamic> route) => false);
        }else{
          Utils.toaster(data['message'].toString());
        }
     //   developer.log('response 00', name: data['success']);
      });
      developer.log('response 1', name: response.toString());
      developer.log('response 2', name: response.data.toString());
      // && response.statusCode == 200
      if (response != null) {
        developer.log('response', name: response.toString());
        print(response.data);
        //response = convert.jsonDecode(response.body));

      }

    }catch (e) {
      developer.log('response _error', name: e.toString());
      print(e);
    }

  }


  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
