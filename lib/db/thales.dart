import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initilDb();
    }
      return _db;
  }

  initilDb() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, "thales.db");

    Database? mydb = await openDatabase(path,
        version: 3, onCreate: _oncreate, onUpgrade: __onUpgade);

    return mydb;
  }

  __onUpgade(Database db, int oldversion, int newversion) async {
    // CallBack when version upgrade
    //  print("===============================") ;
    //  print("Upgrade new : $newversion") ;
    //  print("Upgrade old : $oldversion") ;
  }
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
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
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
    "code_bare"	TEXT NOT NULL , 
    "ancien_code_bare" TEXT  , 
    "etat" TEXT  , 
    "description"  TEXT ,
    "itemsid" INTEGER , 
    "is_exporte" INTEGER ,
    "is_importer" INTEGER , 
    "id_agent"  INTEGER ,
    "id_famille" INTEGER,
    "id_lieu" INTEGER,
    FOREIGN KEY("id_agent") REFERENCES agent("id"),
    FOREIGN KEY("id_famille") REFERENCES agent("id"),
    FOREIGN KEY("id_famille") REFERENCES famille("id"),
    FOREIGN KEY("id_lieu") REFERENCES lieu("id")
    )
    ''');


    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "groupitems" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    "subitemsid" INTEGER ,
    "name"	TEXT NOT NULL , 
    "namear"	TEXT NOT NULL , 
    "price" num REAL , 
    "groupid" INTEGER ,
    "groupname" TEXT NOT NULL ,
    "groupnamear" TEXT NOT NULL ,
    "groupitemsid" INTEGER ,
    "itemsid" INTEGER
    )
    ''');
    //
    // End Cart  ==============================================

    // Start Account Save  ==============================================
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "account" 
    (
    "id"	INTEGER                 ,
    "username" TEXT NOT NULL      ,
    "email"	TEXT NOT NULL         , 
    "phone"	INTEGER               , 
    "balance" num REAL            , 
    "type" TEXT NOT NULL          , 
    "deliveryservice" INTEGER     , 
    "token" TEXT NOT NULL    
    )
    ''');
    // End  Account Save  ==============================================
    List<dynamic> response = await batch.commit();
    // ==================== For one Table
    // await db.execute(
    //     'CREATE TABLE "notes" ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)');
    print("INSERT TABLE SUCCESS $response");
  }

  readData(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  readDataWithFilter(String table, String wheredata, List listvalue) async {
    Database? mydb = await db;
    List<Map> response =
    await mydb!.query(table, where: wheredata, whereArgs: listvalue);
    return response;
  }

  rawReadData(String sql) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }

  insertData(String table, Map<String, Object?> data) async {
    Database? mydb = await db;

    int response = await mydb!.insert(table, data);

    return response;
  }

  rawInsertData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);

    return response;
  }

  updateData(String table, Map<String, Object?> data, String wheredata,
      List listvalue) async {
    Database? mydb = await db;

    int response =
    await mydb!.update(table, data, where: wheredata, whereArgs: listvalue);

    return response;
  }

  rawUpdateData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawUpdate(sql);

    return response;
  }

  deleteData(String table, String wheredata, List listvalue) async {
    Database? mydb = await db;

    int response =
    await mydb!.delete(table, where: wheredata, whereArgs: listvalue);

    return response;
  }

  rawDeleteData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawDelete(sql);

    return response;
  }

  emptyTable(table) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table);
    return response;
  }

  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "thales.db");
    await deleteDatabase(path);
  }
}