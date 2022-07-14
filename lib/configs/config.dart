import 'package:excel/excel.dart';
import 'package:exemple1/db/thales.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

// import file from device
import(context,Sqldb db) async {
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
          // condition of the extension of the file only excel file can be imported
          var bytes = File(result.files.single.path!)
              .readAsBytesSync(); // read the file as bytes
          var excel = Excel.decodeBytes(bytes); // decode the file
          for (var table in excel.tables.keys) {
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
              //print(row);
              //print("${row[0]}, ${row[1]}, ${row[2]}, ${row[3]} ${row[4]}");
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                  "les données sont bien ajouter",
                  style: TextStyle(color: Colors.green),
                )),
          );
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
