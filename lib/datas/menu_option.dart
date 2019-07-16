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
      title:"Connecter-vous",
      icon: Icons.lock_open,
      menuColor: Colors.blue,
      root: ""

  ),
  new MenuOption(
      title:"Secteurs d'activités",
      icon: Icons.local_activity,
      menuColor: Colors.green,
      root: ""

  ),
  new MenuOption(
      title:"Paramètre",
      icon: Icons.settings,
      menuColor: Colors.deepOrange,
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
      title:"Envoyer email ",
      icon: Icons.email,
      menuColor: Colors.deepOrangeAccent,
      root: ""

  ),
  new MenuOption(
      title:"Envoyer Sms",
      icon: Icons.sms,
      menuColor: Colors.indigoAccent,
      root: Cst.ACCOUNT_RT

  ),
  new MenuOption(
      title:"Historique des mails",
      icon: Icons.history,
      menuColor: Colors.green,
      root: ""

  ),

  new MenuOption(
      title:"Envoyer vers cloud",
      icon: Icons.cloud_upload,
      menuColor: Colors.blueGrey,
      root: Cst.ACCOUNT_RT

  ),
];
