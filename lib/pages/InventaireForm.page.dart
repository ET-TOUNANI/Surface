import 'dart:ffi';
import 'dart:ui';

import 'package:exemple1/configs/AppBar.config.dart';
import 'package:flutter/material.dart';

import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';

class InventaireForm extends StatefulWidget {
  const InventaireForm({Key? key}) : super(key: key);

  @override
  State<InventaireForm> createState() => _FormsPageState();
}

class _FormsPageState extends State<InventaireForm> {

  int currentIndex=1;
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  String category = 'Category1';
  String agent = 'agent1';
  String famille = 'fourniture';
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                DropdownButtonFormField<String>(
                  value: category,
                  elevation: 16,
                  key: Key("categprie"),
                  dropdownColor: Colors.black38,
                  style: TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down),
                  isDense: true,
                  decoration: InputDecoration(
                    labelText: 'Lieu',
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
                      color: Colors.white38,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Catégorie vide';
                    }
                  },//recherche point d'amelioration
                  // code + designa+famille les infos oblog de l immo
                  // agent standard 1 + lieu standard 2 + divert
                  // GUEST
                  // default value of "etat " is "bonne etat"
                  // test storage 
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        category = newValue;
                      });
                    }
                  },
                  items:  [
                    DropdownMenuItem(
                      value: 'Category1',
                      child: Text('Category1'),
                    ),
                    DropdownMenuItem(
                      value: 'Category2',
                      child: Text('Category2'),
                    ),
                    DropdownMenuItem(
                      value: 'Category3',
                      child: Text('Category3'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: 'abc',
                //  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'étage',
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
                      color: Colors.white38,
                    ),
                   isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                 // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'N Salle',
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                 // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Code-barres Local',
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Code-barres ',
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Ancien Code inv',
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                DropdownButtonFormField<String>(
                  value: famille,
                  elevation: 16,
                  key: Key("famille"),
                  dropdownColor: Colors.black38,
                  style: TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down),
                  isDense: true,
                  decoration: InputDecoration(
                    labelText: 'Famille',
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
                      color: Colors.white38,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Famille vide';
                    }
                  },
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        famille = newValue;
                      });
                    }
                  },
                  items:  [

                    DropdownMenuItem(
                      value: 'fourniture',
                      child: Text('fourniture'),
                    ),
                    DropdownMenuItem(
                      value: 'famille2',
                      child: Text('Ordinateur'),
                    ),
                    DropdownMenuItem(
                      value: 'famille3',
                      child: Text('television'),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Quantite',
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  // controller: controller,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                DropdownButtonFormField<String>(
                  value: agent,
                  elevation: 16,
                  key: Key("agent"),
                  dropdownColor: Colors.black38,
                  style: TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down),
                  isDense: true,
                  decoration: InputDecoration(
                    labelText: 'Agent',
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
                      color: Colors.white38,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Agent vide';
                    }
                  },
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        agent = newValue;
                      });
                    }
                  },
                  items:  [
                    DropdownMenuItem(
                      value: 'agent1',
                      child: Text('Ahmed Said'),
                    ),
                    DropdownMenuItem(
                      value: 'agent2',
                      child: Text('yassin Rida'),
                    ),
                    DropdownMenuItem(
                      value: 'agent3',
                      child: Text('Ibtissam Hani'),
                    ),
                    DropdownMenuItem(
                      value: 'autre',
                      child: Text('autre'),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  // controller: controller,

                  style: TextStyle(color: Colors.white,),

                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      color: Colors.white38,
                    ),
                    isDense: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'champ vide';
                    }
                  },
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff5F59E1),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  child: const Text('Enregistrer'),
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    var message = 'Le formulaire n\'est pas valide';
                    if (formValid) {
                      message = 'Le formulaire est valide ${controller.text}';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message,style: TextStyle(color: Colors.green),),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GetButtonNavigatBar(context),
    );
  }
}