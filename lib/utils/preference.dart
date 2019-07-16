import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{

  static const String PREF_LAST_GROUPEID = null;

  static  saveLastGoupId(String groupe_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString(PREF_LAST_GROUPEID, groupe_id.toString());
    prefs.commit();
  }
  static  getsaveLastGoupId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  return   prefs.getString(PREF_LAST_GROUPEID)??null;
  }
}