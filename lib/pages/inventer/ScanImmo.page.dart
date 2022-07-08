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
  final controller = TextEditingController();
  int current = 0;
  List<Widget> res = [];

  @override
  void initState() {
    item = widget.storage.split(";");
  }

  formatText(String resS) {
    String description = "";
    if (resS.length > 38) {
      //if the description contain less then 38 carctere no need to the format
      var tab = resS.split(" "); // split the text
      int i = 0;
      while (i != tab.length) {
        if (i % 38 == 0) {
          description += ' \n ';
        }
        description +=
            '${tab[i]} '; // rebuild the text in 38 carctere in the ligne
        i++;
      }
      return description;
    }
    return resS;
  }

  getCard(map) {
    String description =
        formatText(map['description']); //formater le text pour la description
    return Center(
      /* Card Widget */
      child: Card(
        elevation: 50,
        shadowColor: Colors.white38,
        color: Color.fromARGB(255, 33, 33, 33),
        child: SizedBox(
          width: 300,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green[500],
                  radius: 108,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage("hi.com"),
                    //NetworkImage
                    radius: 100,
                  ), //CircleAvatar
                ), //CircleAvatar
                const SizedBox(
                  height: 10,
                ), //SizedBox
                Text(
                  '${map['libelle']}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ),
                Text(
                  '${map['etat']}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ), //Text
                const SizedBox(
                  height: 10,
                ), //SizedBox
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ), //Textstyle
                  ),
                ), //Text
                const SizedBox(
                  height: 40,
                ), //SizedBox
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => setState(() {
                      current = 0;
                    }),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: const [
                          Icon(Icons.touch_app),
                          Text('Scan plus')
                        ],
                      ),
                    ),
                  ),
                ) //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      ), //Card
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: SingleChildScrollView(
        child: (current == 0)
            ? Column(
                children: [
                  Center(
                    child: Column(
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
                            avatar: Icon(Icons.place),
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
                      SizedBox(
                        width: 300,
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
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Scanner le code-barre de l'immo",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              )
            : res.first,
      ),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }

//scan the barre code
  Future<void> scanMe() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#2A79CF", "cancel", true, ScanMode.BARCODE); // scan the bare code
    if (barcodeScanRes != "" && barcodeScanRes != "-1") {
      String sql =
          "SELECT etat,libelle,description FROM immo,famille where code_bare='$barcodeScanRes' and famille.id==immo.id_famille";

      db.rawReadData(sql).then((listMap) {
        // see if the immo exist in the db
        if (listMap.isNotEmpty) {
          listMap.map((map) {
            return getCard(map);
          }).forEach((item) {
            res.add(item);
          });
          setState(() {
            current = 1;
          });
        } else {
          // if not exist
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              "l'immo n'existe pas",
              style: TextStyle(color: Colors.red),
            )),
          );
        }
      });

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
