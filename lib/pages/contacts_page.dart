import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocekoo/models/users.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/database_hepler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ocekoo/utils/progres_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactSurPage extends StatefulWidget{
  @override
  _ContactSurPageState createState() => new _ContactSurPageState();

}
class _ContactSurPageState extends State<ContactSurPage> {
  var db = DatabaseHelper();
  int count = 0;
  @override
  void initState() {
    super.initState();
  }


  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;
    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text("Contact surs ",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddContactDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
      new AddContactDialog(context, false, null),
    );

    setState(() {});
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.group_add,
        ),
        onPressed: _openAddContactDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        //flexibleSpace: Cst.appBrDecoration(),
        title: _buildTitle(context),
        actions: _buildActions(),
      ),
      body:Container(
   // decoration:  Cst.gradiantblue(),
    child: new FutureBuilder<List<Users>>(
        future: db.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var secteurGroup = snapshot.data;
          return snapshot.hasData
              ?
          new ListView.builder(
              itemCount: secteurGroup == null ? 0 : secteurGroup.length,
              itemBuilder: (BuildContext context, int index) {
                return new Slidable(
                    delegate: new SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      new IconSlideAction(
                          caption: 'Modifier',
                          color: Utils.TEXT_GREEN,
                          icon: Icons.edit,
                          onTap: () {
                            edit(secteurGroup[index], context);
                          }
                        //_showSnackBar('Archive'),
                      ),
                      new IconSlideAction(
                          caption: 'Supprimer',
                          color: Utils.TEXT_RED,
                          icon: Icons.delete_forever,
                          onTap: () {
                            showDialogDelete(secteurGroup[index]);
                          }
                        //_showSnackBar('Share'),
                      ),
                    ],
                    child:  Container(
                        child: new Center(
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Chip(
                                              elevation: 2,
                                              avatar:  CircleAvatar(
                                                radius: 50.0,
                                                backgroundColor: Utils.TEXT_ORAGNGE,
                                                child: Text(Utils.getShortChar(secteurGroup[index].nom.toUpperCase()),style: TextStyle(
                                                    fontSize: Utils.TEXT_24_SIZE_BIG,color: Colors.white),),
                                                // backgroundImage: ,
                                              ),
                                              label: Container(child:Text(secteurGroup[index].nom.toUpperCase()+" "+secteurGroup[index].prenom,maxLines: 5,
                                                textAlign: TextAlign.justify,) ,padding: EdgeInsets.all(15.0),)
                                          ),
                                        ]
                                    )),
                              ),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)));
              })
              : new Center(child: new CircularProgressIndicator());
        },
      )),
    );
  }

  edit(Users user, BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) =>
      new AddContactDialog(context, true, user),
    );
    HomePresenter homePresenter;
    homePresenter.updateScreen();
  }

  @override
  void screenUpdate() {
    setState(() {});
  }

  showDialogDelete(Users userGroup) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("Voulez vous vraiment effectuer cette suppression ? "),
          //      backgroundColor: Colors.grey,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Supprimez",style: new TextStyle(
                  color:  Utils.TEXT_ORAGNGE)),
              onPressed: () async{
                int resul;
                resul = await db.deleteUsers(userGroup);
                if(resul == 1){
                  Utils.toasterblue("Suppression effectuée");
                  setState(() {
                    // DANIEL
                  });
                  Navigator.of(context).pop();
                }
              },
            ), new FlatButton(
              child: new Text("Fermer",style: new TextStyle(
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
class AddContactDialog extends StatefulWidget {
  BuildContext context;
  bool isEdit;
  Users users;
  AddContactDialog(this.context, this.isEdit, this.users);
  @override
  State<StatefulWidget> createState() {
    return _AddContactDialog();
  }

}
class _AddContactDialog extends State<AddContactDialog>{
  final tName = TextEditingController();
  final tprenom = TextEditingController();
  final ttel = TextEditingController();
  ProgressDialog pr;
  String uplaodfile  = "pk.jpg" ;
  SharedPreferences preferences;
  String user_id,param_id;
  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  @override
  void initState() {
    // TODO: implement initState
    if (widget.users != null) {
   //   this.secteur=widget.users;
      tName.text = widget.users.nom;
      tprenom.text = widget.users.prenom;
      ttel.text = widget.users.tel;
      param_id = widget.users.param_id;
    }
    SharedPreferences.getInstance().then((pref){
      this.preferences = pref;
      setState(() {
        this.user_id = pref.getString(Cst.USER_ID) != null ? pref.getString(Cst.USER_ID):false;
      });
    });

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Connexion ...');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new AlertDialog(
      title:  Text(widget.isEdit ? 'Modification': 'Nouveau'),
      backgroundColor: Colors.white,
      content: new SingleChildScrollView(
        child:Stack(
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
    child:
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
    InkWell(child:
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Material(
    elevation: 5.0,
    shape: CircleBorder(),
    child: uplaodfile != "pk.jpg" ?
    ClipRRect(
    borderRadius: BorderRadius.circular(40.0),
    child: new Image.file(
    new File(uplaodfile),
    scale: 1.0,
    repeat: ImageRepeat.noRepeat,
    fit: BoxFit.cover,
    matchTextDirection: true,
    gaplessPlayback: true,
    width: 65.0,
    height: 65.0,
    ),
    ) :
    CircleAvatar(
    radius: 40.0,
    backgroundImage: AssetImage('assets/images/cam1.jpg'),),
    ),
    ],
    ),
    onTap: () async {
    Map<PermissionGroup, PermissionStatus> permissions = await
    PermissionHandler().requestPermissions(
    [PermissionGroup.camera, PermissionGroup.storage]);
    //Permission.WriteExternalStorage
    if (permissions.length > 0) {
    onPickImageSelected(context);
    }
    },),
        getTextField("Entrer le nom ", tName,false),
        getTextField("Entrer le prenom ", tprenom,false),
        getTextField("Entrer le contact ", ttel,true),
    getAppBorderButton(),
      ],
    )
    ),

    ]),
      ),
    );

  }
  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController,bool indice) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
      //  maxLines: 5,
        keyboardType: indice? TextInputType.phone:TextInputType.text,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton() {
    var loginBtn =   new Padding(
      padding: EdgeInsets.only(
          left: 0.0, top: 45.0, bottom: 20.0),
      child: new RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius:
            new BorderRadius.circular(30.0)),
        onPressed: () {
          if (tName.text.length <1) {
            Fluttertoast.showToast(
                msg: "Entrez le nom svp !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1);
          }
          if (ttel.text.length <1) {
            Fluttertoast.showToast(
                msg: "Entrez le numero de téléphone !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1);
          } else {
            pr.show();
           // addRecord(widget.isEdit);
            sendUser(widget.isEdit, context);
            //Navigator.of(context).pop();


          }
        },
        child: new Text(
          widget.isEdit ? "Modifier" : "Enregistrer",
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
    );
    return loginBtn;
  }

  Future addRecord(bool isEdit) async {
    var db = new DatabaseHelper();
    var user = new Users(tName.text,tprenom.text,ttel.text,"",uplaodfile,param_id);
    if (isEdit) {
      user.setUsersId(this.widget.users.id);
      bool resul;
      resul = await db.updateUsers(user);
      if(resul){
        Utils.toasterblue("Modification effectuée");
        this.pr.hide();
        Navigator.of(context).pop();

      }
    } else {
      await db.saveUser(user);
      this.pr.hide();
      Navigator.of(context).pop();
    }
  }
  Future sendUser(bool isEdit,BuildContext context) async{

    String base64Image = "";
    if(this.uplaodfile != "pk.jpg") {
      File myFile = new File(this.uplaodfile);
      List<int> imageBytes = myFile.readAsBytesSync();
       base64Image = base64Encode(imageBytes);
    }

    String indice ;
    Map<String, dynamic> infosUser;
    var dio = Dio();

    dio.options.baseUrl = Cst.URL_SEND_USER;
    FormData formData = FormData.from({
      "nom": tName.text.toString(),
      "prenom":tprenom.text.toString(),
      "tel":ttel.text.toString(),
      "image":base64Image,
      "action":isEdit?"0":"1",
      "id":user_id,
     // "param_id":param_id != ""?param_id:"",
      "param_id":"fff",
      "token": "ocekoo",
    });
    Response response;
    try {
     // Utils.toasterblue(Cst.URL_SEND_USER);
      await dio.post(
        Cst.URL_SEND_USER,
        data: formData,
        options: new Options(contentType: ContentType.parse("application/x-www-form-urlencoded"),),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      ).then((respon) {
        Utils.dd("Response", respon.toString());
        var data = json.decode(respon.data);
        if(data['success'].toString() == "1"){
          Utils.toasterblue(data['message'].toString());
          infosUser = data['datas'];
          addRecord(isEdit);
        }else{
          Utils.toaster(data['message'].toString());
          pr.hide();
        }

      });

      if (response != null) {

      }

    }catch (e) {
      Utils.dd("Response", e.toString());
      print(e);
    }

  }
  void onPickImageSelected(BuildContext context) async {
    var imageSource;
    imageSource = ImageSource.camera;
    final scaffold = _scaffoldKey.currentState;
    try {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }
      setState(() {
        this.uplaodfile = file.path;

      });

    } catch (e) {
      Utils.toaster(e.toString());
      print(e.toString());
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
abstract class HomeContract {
  void screenUpdate();
}
class HomePresenter {
  HomeContract _view;
  HomePresenter(this._view);
  updateScreen() {
    _view.screenUpdate();

  }


}