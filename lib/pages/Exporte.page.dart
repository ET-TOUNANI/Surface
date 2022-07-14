import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Export extends StatefulWidget {
  Export({Key? key}) : super(key: key);

  @override
  State<Export> createState() => _GetFamilleState();
}

class _GetFamilleState extends State<Export> {
  Sqldb db = Sqldb();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController search = new TextEditingController();
  int counter = 0;
  bool checkboxVal = false;
  int nbrImmo = 0;
  int nbrFamille = 0;
  String sql =
      "SELECT f.libelle , i.etat , i.code_bare, l.adresse , l.etage , i.is_exporte "
      "FROM immo as i, famille as f , lieu as l  "
      "WHERE f.id==i.id_famille and i.id_lieu==l.id ";
  TextEditingController famile = new TextEditingController();

  // search immo by libelle
  Search(searchValue) {
    setState(() {
      sql =
          "SELECT f.libelle , i.etat , i.code_bare, l.adresse , l.etage  , i.is_exporte "
          "FROM immo as i, famille as f , lieu as l  "
          "WHERE f.libelle like '$searchValue%' and  f.id==i.id_famille and i.id_lieu==l.id ";
    });
  }

  //read all data from db
  Future<List<Map>> _readData() async {
    List<Map> res = await db.rawReadData(sql);

    return res;
  }

  @override
  void initState() {
    db.rawReadData("SELECT * FROM famille").then((listMap) {
      nbrFamille = listMap.length;
    });
    db.rawReadData("SELECT * FROM immo").then((listMap) {
      nbrImmo = listMap.length;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: ListView(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Chip(
              label: Semantics(
                child: Text('Les familles : $nbrFamille '),
              ),
              shadowColor: Colors.black12,
              elevation: 5,
            ),
            Chip(
              label: Semantics(
                child: Text('Les immos : $nbrImmo '),
              ),
              shadowColor: Colors.black12,
              elevation: 5,
            ),
          ],
        ),
        Container(
          height: 70,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: 305,
                      child: TextFormField(
                        controller: search,
                        //  controller: controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Recherche par famille ...",
                          hintStyle: TextStyle(color: Colors.white38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Color(0xff5F59E1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Color(0xff5F59E1)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Search(search.text),
                )
              ],
            ),
          ),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.amber),
          child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: const Icon(
                Icons.warning_amber,
                color: Colors.red,
              ),
              title: const Text("Afficher les Non-exporter ?",
                  style: TextStyle(color: Colors.white, fontSize: 17.5)),
              value: checkboxVal,
              activeColor: Colors.green,
              onChanged: (newVal) {
                setState(() {
                  checkboxVal = newVal!;
                  sql =
                      "SELECT f.libelle , i.etat , i.code_bare, l.adresse , l.etage , i.is_exporte "
                      "FROM immo as i, famille as f , lieu as l  "
                      "WHERE f.id==i.id_famille and i.id_lieu==l.id   ${(newVal == false) ? ' ' : 'and i.is_exporte == 1'}";
                });
              }),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text(
                '      La liste des immo',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white38,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.import_export),
                  color: Colors.white,
                  onPressed: () {
                    showModalBottomSheet<void>(
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
                                const Center(
                                  child: Text(
                                    "Voullez-vous exporter la totalité ou seulement les nouveaux immos ?",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      child: const Text('la totalité'),
                                      onPressed: () async {
                                        await createExcel();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      child: const Text('les nouveaux immos'),
                                      onPressed: () async {
                                        await createExcel();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey),
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
                  },
                ),
              ),
            ],
          )
        ]),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder(
            future: _readData(),
            builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        color: (snapshot.data![i]['is_exporte'] == 1)
                            ? Colors.teal
                            : const Color.fromARGB(255, 52, 52, 52),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  "Code: ${snapshot.data![i]['code_bare']}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            ListTile(
                              title: Text(
                                  "famille: ${snapshot.data![i]['libelle']}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              trailing: Text("${snapshot.data![i]['etat']}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            ListTile(
                              title: Flexible(
                                child: Text(
                                    "Adresse: ${snapshot.data![i]['adresse']} étage ${(snapshot.data![i]['etage'] != null) ? snapshot.data![i]['etage'] : 0} ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ]),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }

  Future<void> createExcel() async {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Sheet1'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: ${cell.cellType}");

    ///
    /// Inserting and removing column and rows

    // insert column at index = 8
    sheetObject.insertColumn(8);

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
        await File('/storage/emulated/0/Download/$name.xlsx')
            .writeAsBytes(List.from(await excel.encode()), flush: true)
            .then((value) => log('saved'));
      } catch (e) {
        print(e);
      }
    }
  }
}
