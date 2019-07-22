import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocekoo/datas/menu_option.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ocekoo/pages/auth/LoginScreen.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';
import 'package:ocekoo/utils/database_hepler.dart';
import 'package:ocekoo/widgets/custom_float.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:rounded_modal/rounded_modal.dart';
class AccueilLayout extends StatefulWidget {
  @override
  _HomeLayout createState() => new _HomeLayout();
}
class _HomeLayout extends State<AccueilLayout>
   // with SingleTickerProviderStateMixin
{

  var db = new DatabaseHelper();
  var isLoading = false;
  Size deviceSize;


  _savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Cst.IS_FIRST_USE, "yes");
  }
  final List<String> categories = ['DarazMall', 'Flash Sales', 'Collection', 'Vouchers', 'Categories'];
  final List<String> images = ['assets/img/1.jpg','assets/img/3.jpg','assets/img/2.jpg',
    'assets/img/2_.jpg',
    'assets/img/4.jpg','assets/img/5.jpg','assets/img/6.jpg','assets/img/8.jpg',
    'assets/img/9.jpg','assets/img/10.jpg'];
  final List<String> flashSaleImages = ['assets/img/b1.jpg','assets/img/b3.jpg','assets/img/b2.jpg'];
  SharedPreferences preferences;
 String nom,prenom,phone,email ;
 String photo = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2CAw61fVws7Kyr0c-O-zB5Z7sFJfFwHgF4zwQ4FDAt4z4hw62";
 bool isLoging;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _savePref();
    SharedPreferences.getInstance().then((pref){
      this.preferences = pref;
      setState(() {
        this.nom = pref.getString(Cst.USER_NAME) != null ? pref.getString(Cst.USER_NAME):false;
        this.prenom = pref.getString(Cst.USER_PRENOM) != null ? pref.getString(Cst.USER_PRENOM):false;
        this.phone = pref.getString(Cst.USER_PHONE) != null ? pref.getString(Cst.USER_PHONE):false;
        this.isLoging = pref.getBool(Cst.ISLOGIN) != null ? pref.getString(Cst.ISLOGIN):false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
   body:Container(

     child: SafeArea(
       child: ListView.builder(
         itemBuilder: _buildListView,
         itemCount: 10,)
   ),)  ,
      floatingActionButton:  CustomFloat(
        icon: Icons.flash_on,
        qrCallback: () {}) ,
      floatingActionButtonLocation: true
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      //bottomNavigationBar: showBottomNav ? myBottomBar() : null,
      bottomNavigationBar: myBottomBar(),

    );
  }
  Widget appBarColumn() => SafeArea(
    child:Container(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              headTitle( "O Sekoo ", "Votre conseiller en lgne",),

            ],
          ),
        ],
      ),
    ),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 1.0),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: Utils.kitGradients,
            ))
    ),

  );


  Widget _buildListView(_,index) {
      if(index==0) return appBarColumn();
    if(index==1) return _buildSlider();
    if(index==2) return _specialisteGrid();
    if(index==3) return _buildFlashSales();
    if(index==4) return _buildPopular();
    if(index==5) return Center(child:
   Container( padding: EdgeInsets.all(10.0),child:
   Column(
     children: <Widget>[
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Row(
             children: <Widget>[
               Text('Conseils', style: TextStyle(fontWeight: FontWeight.bold),),
               SizedBox(width: 10.0,),

             ],
           ),
           Text('Voir plus >>', style: TextStyle(color: Colors.red),)
         ],
       ),
       SizedBox(width: 10.0,),
     ],
   ),)
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset(images[index%images.length]),
                SizedBox(height: 10.0,),
                Text('Top Quality fashion item', softWrap: true,),
                SizedBox(height: 10.0,),
               // Text('Rs.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
              ],
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset(images[(index - 1) %images.length]),
                SizedBox(height: 10.0,),
                Text('Top Quality fashion item', softWrap: true,),
                SizedBox(height: 10.0,),
               // Text('Rs.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopular() {
    return Container(
      height: 120,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                _buildPopularItem("Pharmacie de garde ","120",""),
                SizedBox(width: 5.0,),
                _buildPopularItem("Incident sur les routes","5",Cst.R_ROUTE_MAP),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Expanded _buildPopularItem(String title,String subTtile,String route) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border(left: BorderSide(
                color: Colors.red.shade200,
                style: BorderStyle.solid,
                width: 5
            ))
        ),
        child: ListTile(
          onTap: (){
            Navigator
                .of(context)
                .pushNamed(Cst.R_ROUTE_MAP);
          },
          title: Text(title),
          subtitle: Text(subTtile),
          trailing: Container(width: 50, child: Image.asset('assets/img/b2.jpg', fit: BoxFit.cover,)),
        ),
      ),
    );
  }
  Widget _buildFlashSales() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Centre les plus proches', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 10.0,),
                  Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                      child: Text('30', style: TextStyle(color: Colors.white), )
                  ),
                ],
              ),
              Text('Voir plus >>', style: TextStyle(color: Colors.red),)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              _buildFlashSaleItem(0),
              _buildFlashSaleItem(1),
              _buildFlashSaleItem(2),
            ],
          )
        ],
      ),
    );
  }
  Expanded _buildFlashSaleItem(int index) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              // color: Colors.blue,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(flashSaleImages[index]),fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 5.0,),
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: StadiumBorder(side: BorderSide(width: 1, style: BorderStyle.solid,color: Colors.red))
                  ),
                  child: Container(
                    height: 20,
                    color: Colors.red.shade200,
                  ),
                ),
                ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: StadiumBorder(side: BorderSide(width: 1, style: BorderStyle.solid,color: Colors.red))
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 20,
                    width: 70,
                    color: Colors.red,
                    child: Text('12 Sold', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSlider() {
    deviceSize = MediaQuery.of(context).size;
    final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Container(
      height:  hp(33.1),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DiagonalPathClipperOne(),
            child: Container(
              height: 200,
              color: Colors.deepPurple,
            ),
          ),
          Container(
           // padding: EdgeInsets.symmetric(horizontal: 20.0),
            child:
            Swiper(
              autoplay: true,
              control: new SwiperControl(color: Colors.white),
              itemBuilder: (BuildContext context,int index){
                return _buildFeaturedItem(image:images[index], title: "Kathmandu", subtitle: "90 places worth to visit");
              },
              itemCount: 4,
//              itemWidth: 400.0,
              pagination: new SwiperPagination(margin: const EdgeInsets.only(right: 0.0)),
            ),
          ),
        ],
      ),
    );
  }
  Container _buildFeaturedItem({String image, String title, String subtitle}) {
    // image : 1000/625
    return Container(
    //  padding: EdgeInsets.only(left:16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(1.0),
                child: Image.asset(image, fit: BoxFit.cover,)),

            Positioned(
              bottom: 20.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:16.0,vertical: 8.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(title, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
                    Text(subtitle, style: TextStyle(
                        color: Colors.white
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _specialisteGrid() {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
   Container( padding: EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0),
     child:
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Spécialistes', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: 10.0,),
            Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                child: Text('50', style: TextStyle(color: Colors.white), )
            ),

          ],
        ),
        Text('Voir plus >>', style: TextStyle(color: Colors.red),)
      ],
    ),),
      SizedBox(height: 10,),
      Container(
      height: 110.0,
      child: GridView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,

        ),
        itemBuilder: (_, int index){
          return GestureDetector(
            onTap: ()=>print(categories[index]),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30.0,
                  child: CircleAvatar(backgroundImage: AssetImage(images[index]), radius: 40,),
                ),
                SizedBox(height: 8.0,),
                Text(categories[index%categories.length])
              ],
            ),
          );
        },
        itemCount: categories.length,

      ),
    )
    ],);


  }
  Widget myBottomBar() =>
      BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 50.0,
          decoration: Cst.gradiantBlue(),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child:  this.nom != null ?
                new InkWell(
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  onTap: () {
                    _clickUserInfo(context,"liste");

               },
                  child: Center(
                    child:

                    Row(children: <Widget>[
                      CircleAvatar(
                        radius: 20.5,
                        backgroundImage:
                        NetworkImage(photo),
                        backgroundColor: Colors.transparent,

                      ),

                    ],)

                  ),
                )
                    :
                new InkWell(
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LogInScreen()));

                  },
                  child: Center(
                      child:
                      Row(children: <Widget>[
                        Icon(Icons.person, color: Colors.white,),
                        Text(
                          // "Liste de cartes",
                          "Mon compte",
                          style: new TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],)

                  ),
                ),
              ),
              new SizedBox(
                width: 20.0,
              ),
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  onTap: () {
           //     print("-----------------------");
             // print(await Utils.getCsv());
               // print();
                    _clickMenu(context,"share");
                  },
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  child: Center(
                    child:  Row(children: <Widget>[
                      Icon(Icons.info, color: Colors.white,),
                      Text(
                        // "Liste de cartes",
                        "Infos utils",
                        style: new TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],)
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _menuItem(context, item,icone,menuColor,root,String ispopu) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 1.0),
      //  decoration: BoxDecoration(gradient: Utils.greenPurple()),
        constraints: BoxConstraints.expand(height: 60.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(leading: Icon(icone,color: menuColor,),
              title:  Text(
                item,
                style: TextStyle(
                    color: Utils.TEXT_BLUE,
                    fontSize: Utils.TEXT_14_SIZE_NORMAL,
                    fontWeight: FontWeight.w700),
              ),)
             ,
            ]
//            Divider(
//              height: 1.0,
//              color: Colors.white,
//            )
//          ],
        ),
      ),
      onTap: () {

      if(root =="" && ispopu == "yes"){
     //   dialogMail();
       Utils.toasterblue("Envoie de mail");
      }else{
        Navigator.pushNamed(context, "$root");
      }
//        Navigator.pop(context);

      },
    );
  }

  Widget _menuList(String menuOpen) {
    if(menuOpen == "liste") {
      return ListView.builder(
        itemCount: menuOptionData.length,
        itemBuilder: (context, index) {
          return _menuItem(context, menuOptionData[index].title, menuOptionData[index].icon, menuOptionData[index].menuColor, menuOptionData[index].root,"no");
        },
      );
    }else{
      return ListView.builder(
        itemCount: menuOptionDataSave.length,
        itemBuilder: (context, index) {
          String ispopu;
          ispopu = index == 0 ?  "yes":"no";
          return _menuItem(context, menuOptionDataSave[index].title, menuOptionDataSave[index].icon, menuOptionDataSave[index].menuColor, menuOptionDataSave[index].root,ispopu);
        },
      );
    }
  }

  Widget _header() {
    return Ink(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        decoration:Cst.gradiantgrey2(),
        constraints: BoxConstraints.expand(height: 80.0),
        child: Padding(
          padding: EdgeInsets.all(1),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage("assets/images/pk.jpg"),
              ),
              SizedBox(width: 5,),
              Expanded(
            //fit: FlexFit.loose,
            child:
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(this.nom+this.prenom,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.white, fontSize:  Utils.TEXT_18_SIZE_BIG),
                    ),
                  )
                  ,

                  Text('$phone',
                    style: TextStyle(
                        color: Colors.white, fontSize:  Utils.TEXT_12_SIZE_NORMAL),
                  ),
                ],
              ),
          ),

            ],
          ),
        ),
      ),
    );
  }

  void _clickUserInfo(context,String menuopen) {
    showRoundedModalBottomSheet(
        context: context,
        radius: 20.0,  // This is the default
        color: Colors.white,
      builder: (context) => Material(
     //  color: Utils.GREEN,
       color: Colors.transparent,
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
            _header(),
            Expanded(
              child: Container(
                child: _menuList(menuopen),
              ),
            ),
//            Center(
//              child: Container(
//                decoration: Cst.gradiantgrey(),
//                child: AboutMeTitle(),
//              ),
//            ),

          ],
        ),
      ),
    );
  }
  void _clickMenu(context,String menuopen) {
    showRoundedModalBottomSheet(
        context: context,
        radius: 20.0,  // This is the default
        color: Colors.white,
      builder: (context) => Material(
     //  color: Utils.GREEN,
       color: Colors.transparent,
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
         //   _header(),
            Expanded(
              child: Container(
                child: _menuList(menuopen),
              ),
            ),
            Center(
              child: Container(
                decoration: Cst.gradiantgrey(),
                child: AboutMeTitle(),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

Widget headTitle(String title,String subtitle){
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      SizedBox(
        height: 5.0,
      ),
      Text(
        subtitle,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.white),
      ),
    ],
  );
}

}
class AboutMeTitle extends AboutListTile {
  AboutMeTitle()
      : super(
      icon: Image.asset(
        "assests/images/pk.jpg",
        width: 40.0,
        height: 40.0,
      ),
      applicationName: " Store carte",
      applicationVersion: "1.0",
      applicationLegalese: "MIT License 2.0",
      aboutBoxChildren: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
          child: Text(
           "Con7ptoo inc",
            style: TextStyle(color: Utils.TEXT_BLUE),
          ),
        )
      ]);

}