import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper{

  static Future<sql.Database> database() async{

    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'placesDB.db'), onCreate: (db,version){
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT , loc_lat REAL , loc_lon REAL, loc_address TEXT , image TEXT)');
    }, version: 1);

  }


  static Future<void> insert (String tableName , Map<String,Object> data) async {
    final db = await DBHelper.database();
    db.insert(tableName, data , conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,Object>>>  getData (String tableName) async {
    final db = await DBHelper.database();
    return db.query(tableName);
  }


}