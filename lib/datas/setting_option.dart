import 'package:flutter/material.dart';

class SettingOption {
  String title;
  String subTitle;
  IconData icon;
  Color menuColor;
  int action;

  SettingOption({this.title,this.subTitle,this.icon,this.menuColor,this.action});
}
List<SettingOption> SettingEmail = [
  new SettingOption(
      title:"Enregistrement automatique",
      subTitle:"Enregistrer automatiquement le contact dans les contacts du téléphone après scanne",
      icon: Icons.save,
      menuColor: Colors.redAccent,
      action: 1

  ),
  new SettingOption(
      title:"Ne pas enregistrer ",
      subTitle:"Ne pas enregistrer  les contact dans les contacts du téléphone après le scanne",
      icon: Icons.select_all,
      menuColor: Colors.redAccent,
      action: 0

  ),
  new SettingOption(
      title:"Toujours démander ",
      subTitle:"Demande a chaque scanne pour l'enregistrement automatique  des contacts dans dans le repertoire téléphone ",
      icon: Icons.save_alt,
      menuColor: Colors.redAccent,
      action: 10

  ),
];

