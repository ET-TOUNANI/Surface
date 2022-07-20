import 'package:flutter/material.dart';
import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';
import 'package:exemple1/configs/config.dart';


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
      "WHERE f.id==i.id_famille and i.id_lieu==l.id limit 20 ";
  TextEditingController famile = new TextEditingController();

  // search immo by libelle
  Search(searchValue) {
    setState(() {
      sql =
          "SELECT f.libelle , i.etat , i.code_bare, l.adresse , l.etage  , i.is_exporte "
          "FROM immo as i, famille as f , lieu as l  "
          "WHERE f.libelle like '%$searchValue%' and  f.id==i.id_famille and i.id_lieu==l.id ";
    });
  }

  //read all data from db
  Future<List<Map>> _readData() async {
    List<Map> res = await db.rawReadData(sql);
    initState();
    return res;
  }

  @override
  void initState() {
    setState(() {
      db.rawReadData("SELECT * FROM famille").then((listMap) {
        nbrFamille = listMap.length;
      });
      db.rawReadData("SELECT * FROM immo").then((listMap) {
        nbrImmo = listMap.length;
      });
    });
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
        SizedBox(
          height: 70,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey2,
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
                IconButton(
                  icon: const Icon(
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
                      "WHERE f.id==i.id_famille and i.id_lieu==l.id   ${(newVal == true) ? 'and i.is_exporte == 0' : ' '} limit 20";
                });
              }),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            '      La liste des immo',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  child: const Text('la totalité'),
                                  onPressed: ()  {
                                    Navigator.pop(context);
                                    exprt(0);
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  child: const Text('les nouveaux immos'),
                                  onPressed: ()  {
                                    Navigator.pop(context);
                                    exprt(1);
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
                    physics: const NeverScrollableScrollPhysics(),
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
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            ListTile(
                              title: Text(
                                  "famille: ${snapshot.data![i]['libelle']}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              trailing: Text("${snapshot.data![i]['etat']}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            ListTile(
                              title: Text(
                                  "Adresse: ${snapshot.data![i]['adresse']} étage ${(snapshot.data![i]['etage'] != null) ? snapshot.data![i]['etage'] : 0} ",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
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
      bottomNavigationBar: GetButtonNavigatBar(context,'assets/export_aide.pdf'),
    );
  }

  void exprt(int i) async{
    showAlertDialog(context,"exporting");
    try{

      await export(db,i,context);
      Navigator.pop(context);
      await db.rawUpdateData("UPDATE immo SET is_exporte=1");

    }catch(e){
      print(e);
    }

  }
}
