import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/pages/inventer/chooseLieu.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'dart:async';
import 'package:exemple1/db/thales.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanImmo extends StatefulWidget {
  const ScanImmo({super.key, required this.storage});

  final String storage;

  @override
  State<ScanImmo> createState() => _ScanImmoState();
}

class _ScanImmoState extends State<ScanImmo> {
  Sqldb db = Sqldb();
  var item = [];

  @override
  void initState() {
    item = widget.storage.split(";");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "3/3",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Etape 3",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InputChip(
                      label: Semantics(
                        child: Text('Agent : ${item[0]}'),
                      ),
                      shadowColor: Colors.black12,
                      avatar: Icon(Icons.boy),
                      elevation: 20,
                      onPressed: () {
                        UpdateAgent(context);
                      },
                    ),
                    InputChip(
                      label: Semantics(
                        child: Text('Lieu : ${item[1]}'),
                      ),
                      shadowColor: Colors.black12,
                      avatar: Icon(Icons.boy),
                      elevation: 20,
                      onPressed: () {
                        UpdateLieu(context, item[0]);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            InputChip(
              label: Semantics(
                child: Text('Suivant'),
              ),
              shadowColor: Colors.white38,
              avatar: Icon(Icons.next_plan),
              elevation: 20,
              onPressed: () {
                //String value ="${widget.storage};$category";
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannImmo(storage: value,)));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }

  Future<void> scanMe() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#2A79CF", "cancel", true, ScanMode.BARCODE); // scan the bare code
    if (barcodeScanRes != "" && barcodeScanRes != "-1") {
      int res = await db.isExist(
          "SELECT * FROM immo where code_bare='$barcodeScanRes' "); // see if the lieu exist in the db
      if (res != -1) {
        // if exist
        // String value ="${widget.storage};$res";
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannImmo(storage: value,)));
      } else {
        // if not exist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            "le lieu n'existe pas",
            style: TextStyle(color: Colors.red),
          )),
        );
      }
    }
  }
}

UpdateAgent(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 5),
              Center(
                child: Text(
                  "Voullez-vous modifier l'agent ?",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
                    child: const Text('Oui'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/inventer");
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

UpdateLieu(BuildContext context, String item) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 5),
              Center(
                child: Text(
                  "Voullez-vous modifier le lieu ?",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
                    child: const Text('Oui'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLieu(
                                    storage: item,
                                  )));
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
