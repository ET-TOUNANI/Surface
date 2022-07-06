import 'package:flutter/material.dart';

import 'package:exemple1/configs/AppBar.config.dart';

import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';

class GetFamille extends StatefulWidget {
  GetFamille({Key? key}) : super(key: key);

  @override
  State<GetFamille> createState() => _GetFamilleState();
}

class _GetFamilleState extends State<GetFamille> {
  Sqldb db = Sqldb();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  int counter = 0;
  String sql = 'SELECT * FROM famille';
  TextEditingController famile = new TextEditingController();
  TextEditingController search = new TextEditingController();

  // search famille by libelle
  Search(searchValue) {
    setState(() {
      sql = "SELECT * FROM famille where libelle like '$searchValue%'";
    });
  }

  //read all data from db
  Future<List<Map>> _readData() async {
    List<Map> res = await db.rawReadData(sql);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: ListView(children: <Widget>[
        Container(
          height: 100,
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
                            hintText: "Recherche par libelle ...",
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
                  icon: Icon(Icons.search,color: Colors.white,size: 40,),
                  onPressed: () => Search(search.text),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'La liste des Familles',
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
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          controller: famile,
                                          //  controller: controller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLines: null,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: 'Famille',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.green),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff5F59E1)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Color(0xff5F59E1)),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            labelStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                            ),
                                            isDense: true,
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Champ vide';
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff5F59E1)),
                                      child: const Text('Enregistrer'),
                                      onPressed: () async {
                                        var formValid =
                                            formKey.currentState?.validate() ??
                                                false;
                                        var message =
                                            'Le formulaire n\'est pas valide';
                                        if (formValid) {
                                          int response = await db.rawInsertData(
                                              "INSERT INTO famille (libelle) VALUES('${famile.text}')");
                                          setState(() {
                                            _readData();
                                            ++counter;
                                          });
                                          (response != 0)
                                              ? message =
                                                  'la famille est bien ajouter $response'
                                              : message =
                                                  'Le formulaire n\'est pas valide';
                                        }

                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: (message ==
                                                    'Le formulaire n\'est pas valide')
                                                ? Text(
                                                    message,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                : Text(
                                                    message,
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff5F59E1)),
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
              const SizedBox(
                width: 16,
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
                    Navigator.pushNamed(context, "/importFamille");
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
                        color: Color.fromARGB(255, 52, 52, 52),
                        child: ListTile(
                          title: Text("${snapshot.data![i]['libelle']}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          trailing: IconButton(
                            onPressed: () {
                              deleteFamille(context, snapshot.data![i]['id']);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
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

  deleteFamille(BuildContext context, int id) {
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
                    "Voullez-vous vraiment supprimer cette famille ?",
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
                      onPressed: () async {
                        await db.rawDeleteData(
                            "DELETE FROM famille WHERE id=${id}");
                        setState(() {
                          _readData();
                          ++counter;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            'famille est bien supprimer',
                            style: TextStyle(color: Colors.green),
                          )),
                        );
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
}
