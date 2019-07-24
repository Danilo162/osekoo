import 'package:flutter/material.dart';
import 'package:ocekoo/utils/constant.dart';

class MenuOption {
  String title;
  IconData icon;
  Color menuColor;
  String root;

  MenuOption(
      {this.title,
        this.icon,
        this.menuColor,
        this.root});
}
List<MenuOption> menuOptionData = [
  new MenuOption(
      title:"Profile",
      icon: Icons.person,
      menuColor: Colors.blue,
      root: ""

  ),
  new MenuOption(
      title:"Mes contacts surs",
      icon: Icons.add_alert,
      menuColor: Colors.green,
      root:Cst.R_CONTACT

  ),
  new MenuOption(
      title:"Paramètre",
      icon: Icons.settings,
      menuColor: Colors.deepOrange,
      root: ""

  ),
  new MenuOption(
      title:"Deconnexion",
      icon: Icons.close,
      menuColor: Colors.red,
      root: ""

  ),
//  new MenuOption(
//      title:"Compte utilisateurs",
//      icon: Icons.verified_user,
//      menuColor: Colors.blue,
//      root: Cst.ACCOUNT_RT
//
//  ),
];

List<MenuOption> menuOptionDataSave = [
  new MenuOption(
      title:"Appeler la police",
      icon: Icons.phone,
      menuColor: Colors.deepOrangeAccent,
      root: ""

  ),
  new MenuOption(
      title:"Sapeur pompier",
      icon: Icons.phone,
      menuColor: Colors.indigoAccent,
      root: Cst.ACCOUNT_RT

  ),
  new MenuOption(
      title:"Hopital plus proche",
      icon: Icons.phone,
      menuColor: Colors.green,
      root: ""

  ),

  new MenuOption(
      title:"Appeler CRS",
      icon: Icons.phone,
      menuColor: Colors.blueGrey,
      root: Cst.ACCOUNT_RT

  ),
];
