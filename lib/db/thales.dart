import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  // call database if exist . if not call initDb
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initilDb();

    }

    return _db;
  }
  _onConfigure(Database db)async{
    await db.execute("PRAGMA foreign_keys=ON");
  }
  // create thales db
  initilDb() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, "thales.db");

    Database? mydb = await openDatabase(path,
        version: 9, onCreate: _oncreate, onUpgrade: __onUpgade,onConfigure: _onConfigure);

    return mydb;
  }
  // upgrade the db ( adding some table without losing the last data )
  // to call it just change the number of the version in the method above
  __onUpgade(Database db, int oldversion, int newversion) async {
    // CallBack when version upgrade
    //  print("===============================") ;
    //  print("Upgrade new : $newversion") ;
    //  print("Upgrade old : $oldversion") ;
  }
  // create tables of the db using Batch
  _oncreate(Database db, int version) async {
    // CallBack only  once

    // For ====================== MultiTables
    Batch batch = db.batch();
    // Start ============================================ Cart
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "agent" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "nom"	TEXT NOT NULL , 
    "prenom" TEXT
    )
    ''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "famille" 
    ("id"	TEXT NOT NULL PRIMARY KEY UNIQUE,
    "libelle"	TEXT NOT NULL 
    )
    ''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "situation" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "alias"	TEXT NOT NULL,
    "champ" TEXT
    )
    ''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "lieu" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "adresse"	TEXT NOT NULL,
    "etage" INTEGER,
    "code_bare" TEXT NOT NULL UNIQUE,
    "champ1" TEXT,
    "champ2" TEXT,
    "champ3" TEXT,
    "champ4" TEXT,
    "id_situation" INTEGER ,
    FOREIGN KEY("id_situation") REFERENCES situation("id")
    )
    ''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "immo" 
    (
    "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "code_bare"	TEXT NOT NULL UNIQUE , 
    "ancien_code_bare" TEXT  , 
    "etat" TEXT  DEFAULT 'Bonne qualité', 
    "description"  TEXT ,
    "is_exporte" INTEGER ,
    "is_importer" INTEGER , 
    "id_famille" TEXT NULL,
    "id_lieu" INTEGER,
    FOREIGN KEY("id_famille") REFERENCES famille("id"),
    FOREIGN KEY("id_lieu") REFERENCES lieu("id")
    )
    ''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "scan" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "time"	TEXT ,
    "Quantity" TEXT DEFAULT '1',
    "date" TEXT,
    "id_agent"	INTEGER,
    "id_immo"	INTEGER,
    FOREIGN KEY("id_immo") REFERENCES immo("id"),
    FOREIGN KEY("id_agent") REFERENCES agent("id")
    )
    ''');

    // End  Account Save  ==============================================
    List<dynamic> response = await batch.commit();
    int res1=await db.rawInsert(
        "INSERT INTO lieu (adresse,etage,champ1,code_bare) VALUES('Lieu standard',0,'','0000')");
    await db.rawInsert(
        "INSERT INTO agent (nom,prenom) VALUES('Agent','standard')");
    // ==================== For one Table
    // await db.execute(
    //     'CREATE TABLE "notes" ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)');
    print("INSERT TABLE SUCCESS  | $response | $res1 ");
  }
  // read data from db (we write just the name of the table)
  readData(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }
  // read data with filter for exemple  (we write the name of the table and the where option)
  readDataWithFilter(String table, String wheredata, List listvalue) async {
    Database? mydb = await db;
    List<Map> response =
    await mydb!.query(table, where: wheredata, whereArgs: listvalue);
    return response;
  }
  // we write all the query sql ( select * from .... where ....)
  rawReadData(String sql) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }
  //if the field exist or not in the db
  isExist(String sql) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.rawQuery(sql);
    if(response.isNotEmpty){
      for (var value in response) {
        return value['id'];
      }
    }

    return -1;
  }
  // insert data to db by giving the name of the table and the list of values
  insertData(String table, Map<String, Object?> data) async {
    Database? mydb = await db;

    int response = await mydb!.insert(table, data);

    return response;
  }
// insert data by writing all the query ( insert into .. values ...)
  rawInsertData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);

    return response;
  }
  // update the data by giving the table , the new values , the where condition
  updateData(String table, Map<String, Object?> data, String wheredata,
      List listvalue) async {
    Database? mydb = await db;

    int response =
    await mydb!.update(table, data, where: wheredata, whereArgs: listvalue);

    return response;
  }
  // update data by write all the query ( update ..set ... where..)
  rawUpdateData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawUpdate(sql);

    return response;
  }
  // delete data by giving the table the where condition
  deleteData(String table, String wheredata, List listvalue) async {
    Database? mydb = await db;

    int response =
    await mydb!.delete(table, where: wheredata, whereArgs: listvalue);

    return response;
  }
  // delete data by giving all the query
  rawDeleteData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawDelete(sql);

    return response;
  }
  // empty all the tables
  emptyTable(table) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table);
    return response;
  }
// delete database completely (be careful)
  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "thales.db");
    await deleteDatabase(path);
  }
}