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

  // city table id
  String cityId = 'id';
  // city name table column
  String cityName = 'city_name';
  // table name
  String tableName = 'cities';


  // database singleton pattern
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

  // initialing database in application directory
  Future<Database> initialDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, "database.db");
    var db = openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  // create city table
  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($cityId INTIGER PRIMARY KEY,$cityName TEXT)');
  }

  // start city CRUD functions/
  //getting cities
  Future<List<Map<String, dynamic>>> getCities() async {
    Database database = await this.database;
    var result = await database.rawQuery('SELECT * FROM $tableName');
    return result;
  }
  // saving city object
  Future<int> saveCity(FavoriteCity city) async {
    Database database = await this.database;
    var result = await database.insert(tableName, city.toMap());
    return result;
  }
  // deleting city
  Future<int> deleteCity(FavoriteCity city) async {
    Database database = await this.database;
    var result = await database.rawDelete('DELETE FROM $tableName WHERE $cityId = ${city.id}');
    return result;
  }

  // getting city list
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
