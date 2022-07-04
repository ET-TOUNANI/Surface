import 'package:flutter/material.dart';

import 'package:exemple1/configs/AppBar.config.dart';

import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';

class GetLieu extends StatefulWidget {
  GetLieu({Key? key}) : super(key: key);

  @override
  State<GetLieu> createState() => _GetLieuState();
}

class _GetLieuState extends State<GetLieu> {
  Sqldb db = Sqldb();
  final formKey = GlobalKey<FormState>();
  int counter = 0;
  TextEditingController adresse = new TextEditingController();
  TextEditingController etage = new TextEditingController();
  TextEditingController champ1 = new TextEditingController();

  Future<List<Map>> _readData() async {
    List<Map> res = await db.rawReadData("SELECT * FROM lieu");
    return res;
  }

  //read all data from db

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: ListView(children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'La liste des lieux',
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
                            height: 300,
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
                                          controller: adresse,
                                          //  controller: controller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLines: null,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: 'Adresse',
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
                                        TextFormField(
                                          controller: etage,
                                          //  controller: controller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLines: null,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: 'Etage',
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
                                        TextFormField(
                                          controller: champ1,
                                          //  controller: controller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLines: null,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: 'Champ1',
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
                                              "INSERT INTO lieu (adresse,etage,champ1) VALUES('${adresse.text}',${etage.text},'${champ1.text}')");
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
                    Navigator.pushNamed(context, "/importLieu");
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
                          title: Text(
                              "${snapshot.data![i]['adresse']}    |   ${snapshot.data![i]['champ1']}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          subtitle: Text("${snapshot.data![i]['etage']}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          trailing: IconButton(
                            onPressed: () {
                              deleteLieu(context, snapshot.data![i]['id']);
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

  deleteLieu(BuildContext context, int id) {
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
                    "Voullez-vous vraiment supprimer ce lieu ?",
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
                        await db
                            .rawDeleteData("DELETE FROM lieu WHERE id=${id}");
                        setState(() {
                          _readData();
                          ++counter;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            'Lieu est bien supprimer',
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
