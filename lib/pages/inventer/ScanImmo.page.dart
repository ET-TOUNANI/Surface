import 'package:exemple1/configs/AppBar.config.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'dart:async';

import 'package:exemple1/db/thales.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class ScannImmo extends StatefulWidget {
  const ScannImmo({Key? key}) : super(key: key);

  @override
  State<ScannImmo> createState() => _FormsPageState();
}

class _FormsPageState extends State<ScannImmo> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  Sqldb db = Sqldb();
  String category = "Lieu standard";
  List<DropdownMenuItem<String>> immox = [];

  @override
  void initState() {
    // create a list of dropdownItems coming in the db
    db.rawReadData("SELECT * FROM immo").then((listMap) {
      listMap.map((map) {
        return getDropDownWidget(map);
      }).forEach((dropDownItem) {
        immox.add(dropDownItem);
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
              "${map['id']}",
            ),
            Divider(
              color: Colors.green,
              indent: 10,
              endIndent: 10,
            )
          ],
        ),
      ),
      value: map['code_barre'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: Column(
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
            height: 160,
          ),
          Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 190,
                        width: 152,
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
                                          items: immox,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "      Veuillez \n choisir l'immo \n   pour le scan",
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
                        width: 152,
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
                                  "     Scanner \n le code-barre \n      de l'immo",
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
            onPressed: (){},
          )
        ],
      ),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }
  Future<void> scanMe() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#2A79CF", "cancel", true, ScanMode.BARCODE);// scan the bare code
    if (barcodeScanRes != "" && barcodeScanRes!="-1" ) {
      int res= await db.isExist("SELECT * FROM immo where code_bare='$barcodeScanRes' ");// see if the lieu exist in the db
      if (res !=0) { // if exist
        Navigator.pushNamed(context, "/scan");
      } else {// if not exist
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
              content:  Text(
                "l'immo n'existe pas",
                style: TextStyle(
                    color: Colors.red),
              )
          ),
        );
      }
    }
  }
}

