import 'package:exemple1/configs/AppBar.config.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';
import 'package:exemple1/db/thales.dart';

class AddImmo extends StatefulWidget {
  const AddImmo(
      {super.key,
      required this.idAgent,
      required this.idLieu,
      required this.barcodeScanRes});

  final int idAgent;
  final int idLieu;
  final String barcodeScanRes;

  @override
  State<AddImmo> createState() => _ScanImmoState();
}

class _ScanImmoState extends State<AddImmo> {
  Sqldb db = Sqldb();
  final formKey = GlobalKey<FormState>();
  String famille = "";
  TextEditingController etatController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String famChois = " ";
  List<DropdownMenuItem<String>> familys = [];

  @override
  void initState() {
    super.initState();
    // create a list of dropdownItems coming in the db
    db.rawReadData("SELECT * FROM famille").then((listMap) {
      listMap.map((map) {
        return getDropDownWidget(map);
      }).forEach((dropDownItem) {
        familys.add(dropDownItem);
      });
      familys.add(DropdownMenuItem<String>(
        value: " ",
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text(
                " ",
              ),
              Divider(
                color: Colors.green,
                indent: 10,
                endIndent: 10,
              )
            ],
          ),
        ),
      ));
      setState(() {});
    });
  }

  //dropDownItem modal
  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      value: "${map['id']}- ${map['libelle']}",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${map['id']}- ${map['libelle']}",
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
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Ajouter un immo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  value: famChois,
                  elevation: 14,
                  icon: const Icon(Icons.arrow_drop_down),
                  isDense: true,
                  decoration: InputDecoration(
                    labelText: 'Famille *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value == " ") {
                      return 'Champ vide';
                    }
                  },
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != " ") {
                      setState(() {
                        famChois = newValue;
                      });
                    }
                  },
                  items: familys,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: etatController,
                  //  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Etat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
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
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descriptionController,
                  //  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xff5F59E1)),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xff5F59E1)),
                  child: const Text('Ajouter'),
                  onPressed: () async {
                    var formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var tab = famChois.split("- ");
                      int idFamille = int.parse(tab[0]);
                      //insert the immo to db
                      String sql =
                          "INSERT INTO immo (code_bare,ancien_code_bare,description,is_exporte,is_importer,etat,id_famille,id_lieu) VALUES('${widget.barcodeScanRes}','${widget.barcodeScanRes}',${(descriptionController.text != "") ? '"${descriptionController.text}"' : "'pas de description'"},0,0,${(etatController.text != "") ? '"${etatController.text}"' : "'Bonne qualité'"},$idFamille,${widget.idLieu})";
                      DateTime d=DateTime.now();
                      String date="${d.day}/${d.month}/${d.year}";
                        String time="${d.hour}:${d.minute}:${d.second}";
                      int idImmo = await db.rawInsertData(sql);
                      String sql2 =
                          "INSERT INTO scan (Quantity,time,date,id_agent,id_immo) VALUES(1,'$time','$date',${widget.idAgent},$idImmo)";

                      await db.rawInsertData(sql2);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'L\'immo est bien ajouter',
                          style: TextStyle(color: Colors.green),
                        )),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'Le formulaire n\'est pas valide',
                          style: TextStyle(color: Colors.red),
                        )),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }
}
