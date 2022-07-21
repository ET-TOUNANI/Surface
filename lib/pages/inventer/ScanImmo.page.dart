import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/pages/inventer/ResultCard.page.dart';
import 'package:exemple1/pages/inventer/addImmo.dart';
import 'package:exemple1/pages/inventer/chooseLieu.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'dart:async';
import 'package:exemple1/db/thales.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanImmo extends StatefulWidget {
  const ScanImmo(
      {super.key,
      required this.storage,
      required this.idAgent,
      required this.idLieu});

  final int idAgent;
  final int idLieu;
  final String storage;

  @override
  State<ScanImmo> createState() => _ScanImmoState();
}

class _ScanImmoState extends State<ScanImmo> {
  Sqldb db = Sqldb();
  var item = [];
  String barcodeScanRes = "";
  List<Widget> res = [];

  @override
  void initState() {
    item = widget.storage.split(";");
    setState(() {});
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
    String description = "";
    if (map['description'] != "" && map['description'] != null) {
      description =
          formatText(map['description']); //formater le text pour la description
    }
    return Center(
      /* Card Widget */
      child: Card(
        elevation: 50,
        shadowColor: Colors.white38,
        color: const Color.fromARGB(255, 33, 33, 33),
        child: SizedBox(
          width: 300,
          height: 580,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  '${map['code_bare']}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ),
                const SizedBox(
                  height: 10,
                ),
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
                  '${map['etat']}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ),
                Text(
                  "famille : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  '${map['libelle']}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "description : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "scanner par ${item[0]} le ${map['date']} à ${map['time']}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: Text(
                    "dans le lieu qui se trouve dans l'adresse : ${item[1]} ",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color.fromARGB(255,0, 118, 182))),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Center(
              child: Column(
                children: const [
                  SizedBox(
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
                        child: Text('${item[0]}'),
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
                        child: Text('${item[1]}'),
                      ),
                      shadowColor: Colors.black12,
                      avatar: Icon(Icons.place),
                      elevation: 20,
                      onPressed: () {
                        UpdateLieu(context, item[0], widget.idAgent);
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
                    color: Color.fromARGB(255,0, 118, 182),
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Color.fromARGB(255,0, 118, 182),
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
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
        )),
      ),
      bottomNavigationBar: GetButtonNavigatBar(context,'assets/inventer_aide.pdf'),
    );
  }

//scan the barre code
  Future<void> scanMe() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#2A79CF", "cancel", true, ScanMode.BARCODE); // scan the bare code
    if (barcodeScanRes != "" && barcodeScanRes != "-1") {
      String sql =
          "SELECT  code_bare,etat,libelle,description,date,time FROM immo,famille,scan where code_bare='$barcodeScanRes' and famille.id==immo.id_famille and scan.id_immo==immo.id";

      db.rawReadData(sql).then((listMap) {
        // see if the immo exist in the db
        if (listMap.isNotEmpty) {
          listMap.map((map) {
            return getCard(map);
          }).forEach((item) {
            res.add(item);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultCard(resWidget: res.first)));
        } else {
          // if not exist
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              "l'immo n'existe pas",
              style: TextStyle(color: Colors.red),
            )),
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddImmo(
                      idAgent: widget.idAgent,
                      idLieu: widget.idLieu,
                      barcodeScanRes: barcodeScanRes)));
        }
      });
    }
  }
}

// show the agent ship
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
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
                    child: const Text('Oui'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/inventer");
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
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

// show the lieu ship
UpdateLieu(BuildContext context, String item, int id) {
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
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
                    child: const Text('Oui'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLieu(
                                    storage: item,
                                    idAgent: id,
                                  )));
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
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
