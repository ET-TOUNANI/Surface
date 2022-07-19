import 'package:exemple1/configs/AppBar.config.dart';
import 'package:exemple1/pages/inventer/chooseLieu.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';


class InventaireForm extends StatefulWidget {
  const InventaireForm({super.key}) ;
  @override
  State<InventaireForm> createState() => _FormsPageState();
}

class _FormsPageState extends State<InventaireForm> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final agentController=TextEditingController();

  Sqldb db = Sqldb();
  String agentChois = "1- Agent standard";
  List<DropdownMenuItem<String>> agens = [];

  @override
  void initState() {
    super.initState();
    // create a list of dropdownItems coming in the db
    db.rawReadData("SELECT * FROM agent").then((listMap) {
      listMap.map((map) {
        return getDropDownWidget(map);
      }).forEach((dropDownItem) {
        agens.add(dropDownItem);
      });

      setState(() {
        agens.add(DropdownMenuItem<String>(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Autre",
                ),
                Divider(
                  color: Colors.green,
                  indent: 10,
                  endIndent: 10,
                )
              ],
            ),
          ),
          value: "Autre",
        ));
      });
    });
  }

  //dropDownItem modal
  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      value: "${map['id']}- ${map['nom']} ${map['prenom']}",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${map['id']}- ${map['nom']} ${map['prenom']}",
            ),
            const Divider(
              color: Colors.green,
              indent: 10,
              endIndent: 10,
            )
          ],
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
        child: Column(
          children: [
            Column(
              children: const [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "1/3",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Etape 1",
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
              child:
                  (agentChois != "Autre")?Column(
                    children: [
                      SizedBox(
                        height: 190,
                        width: 300,
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
                                          value: agentChois,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                agentChois = newValue;
                                              });
                                            }
                                          },
                                          items: agens,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Veuillez choisir un agent qui vas scanner",
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputChip(
                        label: Semantics(
                          child: const Text('Suivant'),
                        ),
                        shadowColor: Colors.white38,
                        avatar: Icon(Icons.next_plan),
                        elevation: 20,
                        onPressed: () {
                          var tab = agentChois.split("- ");
                          int id=int.parse(tab[0]);
                          String agent = tab[1];
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseLieu(storage: agent,idAgent: id,)));
                        },
                      )
                    ],
                  ):
                  Column(
                    children: [
                      TextFormField(
                        controller: agentController,
                        //  controller: controller,
                        autovalidateMode: AutovalidateMode
                            .onUserInteraction,
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Nom et Prénom',
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
                          hintText: "Entrer votre nom et votre prénom",
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
                        height: 20,
                      ),
                      InputChip(
                        label: Semantics(
                          child: const Text('Suivant'),
                        ),
                        shadowColor: Colors.white38,
                        avatar: Icon(Icons.next_plan),
                        elevation: 20,
                        onPressed: () async{
                          if (agentController.text.isNotEmpty) {
                            var nom=agentController.text.split(" ");
                            int rep = await db.rawInsertData("INSERT INTO agent (nom,prenom) VALUES('${nom[0]}','${nom[1]}')");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseLieu(storage: agentController.text,idAgent: rep,)));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                    "il existe un problème",
                                    style: TextStyle(color: Colors.red),
                                  )
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
            
            ),

          ],
        ),
      ),
      bottomNavigationBar: GetButtonNavigatBar(context,'assets/inventer_aide.pdf'),
    );
  }
}
