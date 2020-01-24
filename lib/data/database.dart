import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sunshine/models/favorite_city.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  String cityId = 'id';
  String cityName = 'city_name';
  String tableName = 'cities';



  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialDatabase();
    }
    return _database;
  }

  Future<Database> initialDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, "database.db");
    var db = openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  void _createDB(Database db, int version) async {
    // create city table
    await db.execute(
        'CREATE TABLE $tableName($cityId INTIGER PRIMARY KEY,$cityName TEXT)');
  }

// start city CRUD functions/
  Future<List<Map<String, dynamic>>> getCities() async {
    Database database = await this.database;
    var result = await database.rawQuery('SELECT * FROM $tableName');
    return result;
  }

  Future<int> saveCity(FavoriteCity city) async {
    Database database = await this.database;
    var result = await database.insert(tableName, city.toMap());
    return result;
  }

  Future<int> deleteCity(FavoriteCity city) async {
    Database database = await this.database;
    var result =
        await database.delete(tableName, where: '$cityId', whereArgs: [cityId]);
    return result;
  }

  Future<List<FavoriteCity>> getCityList() async {
    var cityListMap = await getCities();
    int count = cityListMap.length;
    List<FavoriteCity> cityList = List<FavoriteCity>();
    for (int i = 0; i < count; i++) {
      cityList.add(FavoriteCity.fromMap(cityListMap[i]));
    }
    return cityList;
  }

// end city CRUD functions
//---------------------------------------------------------------//

}
