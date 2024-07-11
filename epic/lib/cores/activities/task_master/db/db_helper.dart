import 'package:epic/cores/activities/task_master/model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("not null db");
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      debugPrint("in database path");
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          debugPrint("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );

      // delete the table
      // await _db!.execute("DROP TABLE IF EXISTS $_tableName");
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task task) async {
    print("insert function called");
    return await _db!.insert(_tableName, task.toJson());
  }

  static Future<int> delete(Task task) async =>
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    // return _db!.query(_tableName);
    try {
      return await _db!.query(
        _tableName,
      );
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<int> update(int? id) async {
    print("update function called");
    return await _db!.rawUpdate('''
    UPDATE tasks   
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
