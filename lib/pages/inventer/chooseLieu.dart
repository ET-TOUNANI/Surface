import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/pages/inventer/ScanImmo.page.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'dart:async';

import 'package:exemple1/db/thales.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class ChooseLieu extends StatefulWidget {
  const ChooseLieu({super.key, required this.storage});

  final String storage;

  @override
  State<ChooseLieu> createState() => _FormsPageState();
}

class _FormsPageState extends State<ChooseLieu> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  Sqldb db = Sqldb();
  String category = "Lieu standard";
  List<DropdownMenuItem<String>> lieux = [];

  @override
  void initState() {
    // create a list of dropdownItems coming in the db
    db.rawReadData("SELECT * FROM lieu").then((listMap) {
      listMap.map((map) {
        return getDropDownWidget(map);
      }).forEach((dropDownItem) {
        lieux.add(dropDownItem);
      });

      setState(() {});
    });
  }

  //dropDownItem modal
  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${map['adresse']} ${(map['etage'] == 0) ? '' : '\nétage : ${map['etage']}'}",
            ),
            Divider(
              color: Colors.green,
              indent: 10,
              endIndent: 10,
            )
          ],
        ),
      ),
      value: map['adresse'],
    );
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
                  "2/3",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Etape 2",
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
                  children: [

                    InputChip(
                      label: Semantics(
                        child:  Text('Agent : ${widget.storage}'),
                      ),
                      shadowColor: Colors.black12,
                      avatar: Icon(Icons.boy),
                      elevation: 20,
                      onPressed: () {
                        UpdateAgent(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 190,
                      width: 156,
                      child: Material(
                        color: Color.fromARGB(255, 33, 33, 33),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white70),
                                      child: DropdownButtonFormField<String>(
                                        value: category,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              category = newValue;
                                            });
                                          }
                                        },
                                        items: lieux,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "      Veuillez \n choisir un lieu \n   pour le scan",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "OU",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 148,
                      child: Material(
                        color: Color.fromARGB(255, 33, 33, 33),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: () {
                            scanMe();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Ink.image(
                                image: const AssetImage('assets/scanner.png'),
                                height: 120,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                "     Scanner \n le code-barre \n      du lieu",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 6,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                String value ="${widget.storage};$category";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanImmo(storage: value,)));
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
          "SELECT * FROM lieu where code_bare='$barcodeScanRes' "); // see if the lieu exist in the db
      if (res != -1) {
        // if exist
        String value ="${widget.storage};$res";
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanImmo(storage: value,)));
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
                    style:
                    ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
                    child: const Text('Oui'),
                    onPressed: ()  {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/inventer");
                    },
                  ),
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Color(0xff5F59E1)),
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