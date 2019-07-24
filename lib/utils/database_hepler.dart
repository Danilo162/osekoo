import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:ocekoo/models/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }
  DatabaseHelper.internal();
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, tel TEXT, photo TEXT, email TEXT, param_id TEXT)");
    await db.execute("CREATE TABLE messages(id INTEGER PRIMARY KEY, room_id TEXT, idFrom TEXT, idTo TEXT, timestamp TEXT, content TEXT, type TEXT)");
  }

  // USERS
  Future<int> saveUser(Users users) async {
    var dbClient = await db;
    int res = await dbClient.insert("users", users.toMap());
    return res;
  }

  Future<List<Users>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM users');
    List<Users> usersList = new List();
    for (int i = 0; i < list.length; i++) {
      var users =  new Users(list[i]["nom"],list[i]["prenom"],list[i]["tel"],list[i]["email"],list[i]["photo"],list[i]["param_id"]);
      users.setUsersId(list[i]["id"]);
      usersList.add(users);
    }
    return usersList;
  }
  Future<List<Users>> getUserWithLimit(String limit) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM users ORDER BY id DESC LIMIT $limit');
    List<Users> usersList = new List();
    for (int i = 0; i < list.length; i++) {
      var users =  new Users(list[i]["nom"],list[i]["prenom"],list[i]["tel"],list[i]["email"],list[i]["photo"],list[i]["param_id"]);
      users.setUsersId(list[i]["id"]);
      usersList.add(users);
    }
    return usersList;
  }

  Future<int> deleteUsers(Users users) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM users WHERE id = ?', [users.id]);
    getUsers();
    return res;
  }
  Future<bool> updateUsers(Users users) async {
    var dbClient = await db;
    int res =   await dbClient.update("users", users.toMap(),
        where: "id = ?", whereArgs: <int>[users.id]);
    return res > 0 ? true : false;
  }

}
