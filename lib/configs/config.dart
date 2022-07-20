import 'package:excel/excel.dart';
import 'package:exemple1/db/thales.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';




showAlertDialog(BuildContext context,String operation){
  AlertDialog alert=AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 5),child:Text(operation)),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}







// export data from db to excel file
Future<void> export(Sqldb db, int totaliteOrNot) async {
  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];

  CellStyle cellStyle = CellStyle(
      backgroundColorHex: "#1AFF1A",
      fontFamily: getFontFamily(FontFamily.Calibri));

  cellStyle.underline = Underline.Single; // or Underline.Double

  var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
  cell1.value = "code_bare"; // dynamic values support provided;
  cell1.cellStyle = cellStyle;
  var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
  cell2.value = "description"; // dynamic values support provided;
  cell2.cellStyle = cellStyle;
  var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
  cell3.value = "état"; // dynamic values support provided;
  cell3.cellStyle = cellStyle;
  var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
  cell4.value = "famille"; // dynamic values support provided;
  cell4.cellStyle = cellStyle;
  var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
  cell5.value = "code_bare_lieu"; // dynamic values support provided;
  cell5.cellStyle = cellStyle;
  String sql = "";
  if (totaliteOrNot == 0) {
    // export all the immos or not
    sql =
    "SELECT i.code_bare,i.description,i.etat,f.id,l.code_bare as code_bareLieu "
        " FROM immo as i , famille as f,lieu as l "
        " WHERE i.id_famille==f.id and i.id_lieu==l.id ";
  } else {
    sql =
    "SELECT i.code_bare,i.description,i.etat,f.id,l.code_bare as code_bareLieu "
        " FROM immo as i , famille as f,lieu as l "
        " WHERE i.id_famille==f.id and i.id_lieu==l.id  and i.is_exporte==0";
  }

  // adding data to excel sheet frim db
  List<Map> res = await db.rawReadData(sql);
  int i = 2;
  for (var immo in res) {
    var cell1 = sheetObject.cell(CellIndex.indexByString("A$i"));
    cell1.value = "${immo['code_bare']}"; // dynamic values support provided;
    var cell2 = sheetObject.cell(CellIndex.indexByString("B$i"));
    cell2.value = "${immo['description']}"; // dynamic values support provided;
    var cell3 = sheetObject.cell(CellIndex.indexByString("C$i"));
    cell3.value = "${immo['etat']}"; // dynamic values support provided;
    var cell4 = sheetObject.cell(CellIndex.indexByString("D$i"));
    cell4.value = "${immo['id']}"; // dynamic values support provided;
    var cell5 = sheetObject.cell(CellIndex.indexByString("E$i"));
    cell5.value =
    "${immo['code_bareLieu']}"; // dynamic values support provided;
    i++;
  }

  ///
  /// Inserting and removing column and rows

  // insert column at index = 8
  //sheetObject.insertColumn(8);

  // remove column at index = 18
  //sheetObject.removeColumn(18);

  // insert row at index = 82
  //sheetObject.removeRow(82);

  // remove row at index = 80
  //sheetObject.removeRow(80);

  //saving excel
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if (await Permission.storage.request().isGranted) {
    try {
      DateTime d = DateTime.now(); //real time
      String date = "${d.day}${d.month}${d.year}"; // date
      String time = "${d.hour}${d.minute}${d.second}"; //time
      String name = "$date${time}_immos"; //name of file
      // await FileSaver.instance.saveAs(name, bytes, ext, mimeType);
      await File('./storage/emulated/0/Download/$name.xlsx')
          .writeAsBytes(List.from(await excel.encode()), flush: true)
          .then((value) => print('saved'));
    } catch (e) {
      print(e);
    }
  }
}

// import file from device
import(context, Sqldb db) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if (await Permission.storage.request().isGranted) {
    // ask for permission
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(); // import file from the device
      if (result != null) {

        if (result.files.first.extension == 'xlsx') {
          int nbrEnregistrements=0;
          showAlertDialog(context,"importing");
          // condition of the extension of the file only excel file can be imported
          var bytes = File(result.files.single.path!)
              .readAsBytesSync(); // read the file as bytes
          var excel = Excel.decodeBytes(bytes); // decode the file

          if (excel.sheets.length == 1) {
            // read by col
            // excel contain just the list of "immos"
            // add list of famille from db

            int maxRows = excel.sheets['Sheet1']!.maxRows;
            List<dynamic> immos = [];

            for (int row = 1; row < maxRows; row++) {
              excel.sheets['Sheet1']!.row(row).forEach((cell) {
                immos.add(cell.value);
                nbrEnregistrements++;
              });
              String idFamille= await db.isExist('select id from famille where id="${immos[3]}"');
              int idLieu= await db.isExist('select id from lieu where code_bare="${immos[4]}"');

              // add immo to db
              await db.rawInsertData(
                  'INSERT INTO immo (code_bare,ancien_code_bare,description,is_exporte,is_importer,etat,id_famille,id_lieu) VALUES("${immos[0]}","${immos[0]}","${immos[1]}",0,1,"${immos[2]}","$idFamille",$idLieu)');
              immos.clear();
            }
          } else {
            // initialisation of apk
            int maxRows = excel.sheets['famille']!.maxRows;
            // add famille from sheet 1
            for (int row = 1; row < maxRows; row++) {
              excel.sheets['famille']!.row(row).forEach((cell) {
                libelle = cell.value;
                nbrEnregistrements++;
              }); // add famille to db
              await db.rawInsertData(
                  'INSERT INTO famille (id,libelle) VALUES("${famille[0]}","${famille[1]}")');
            }
            List<dynamic> lieu = [];
            maxRows = excel.sheets['lieu']!.maxRows;

            // add lieu from sheet 2
            for (int row = 1; row < maxRows; row++) {
              excel.sheets['lieu']!.row(row).forEach((cell) {
                lieu.add(cell.value);
              }); // add lieu to db
              await db.rawInsertData(
                  'INSERT INTO lieu (adresse,etage,code_bare) VALUES("${lieu[0]}",${lieu[1]},"${lieu[2]}")');
              lieu.clear();
            }

            maxRows = excel.sheets['immos']!.maxRows;
            List<dynamic> immos = [];
            // add lieu from sheet 2
            for (int row = 1; row < maxRows; row++) {
              excel.sheets['immos']!.row(row).forEach((cell) {
                immos.add(cell.value);
              }); // add immo to db
              String idFamille= await db.isExist('select id from famille where id="${immos[3]}"');
              int idLieu= await db.isExist('select id from lieu where code_bare="${immos[4]}"');
              print(idFamille);
              print(idLieu);
              // add immo to db
              await db.rawInsertData(
                  'INSERT INTO immo (code_bare,ancien_code_bare,description,is_exporte,is_importer,etat,id_famille,id_lieu) VALUES("${immos[0]}","${immos[0]}","${immos[1]}",0,1,"${immos[2]}","${idFamille}",${idLieu})');
              immos.clear();
            }
          }
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                content: Text(
              "$nbrEnregistrements Enregistrement(s) Importés",
              style: TextStyle(color: Colors.green),
            )),
          );
          // read by row
          /*for (var table in excel.tables.keys) {
            for (var row in excel.tables[table]!.rows) {
              if(row[0]=='code_bare')
                continue;
              // add famille
              int idFamille= await db.rawInsertData(
                  'INSERT INTO famille (libelle) VALUES("${row[3]}")'
              );
              //add lieu
              int idLieu= await db.rawInsertData(
                  'INSERT INTO lieu (adresse,code_bare) VALUES("${row[4]}","${row[5]}")'
              );
              await db.rawInsertData(
                  'INSERT INTO immo (code_bare,ancien_code_bare,description,is_exporte,is_importer,etat,id_famille,id_lieu) VALUES("${row[0]}","${row[0]}","${row[1]}",0,1,"${row[2]}",$idFamille,$idLieu)'
              );
              print(row);

            }
          }*/

        } else {
          // not the right extension
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                  "Veuillez sélectionner une extension correcte !",
                  style: TextStyle(color: Colors.red),
                )),
          );
        }
      } else {
        // User canceled the picker

      }
    } catch (e) {
      print(e);
    }
  }
}



