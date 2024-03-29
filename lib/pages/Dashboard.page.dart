import 'package:flutter/material.dart';

import 'package:exemple1/configs/AppBar.config.dart';

import 'package:exemple1/db/thales.dart';

import 'package:exemple1/configs/config.dart';

class Dashboard extends StatelessWidget {
   Dashboard({Key? key}) : super(key: key);
  Sqldb db = Sqldb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: GetAppBare(),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Padding(
                padding: EdgeInsets.all(1.0),
                child: Ink.image(
                  image:  AssetImage('assets/blem.png'),
                  height: 120,
                  //fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20.0,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSizedBox(context,"scan","Inventaire",1,"/inventer"),
                          SizedBox(
                            width: 154.0,
                            height: 160.0,
                            child: Material(
                              color: const Color.fromARGB(255, 21, 21, 21),
                              elevation: 8,
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.black26,
                                onTap: () {
                                  try{
                                    import(context,db);
                                  }catch(e){
                                    print(e);
                                  }

                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image:  const AssetImage('assets/importer.png'),
                                      height: 80,
                                      width: 64.0,
                                      //fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      "Importer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "2",
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //scan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSizedBox(context, "todo", "Lieu", 3, "/lieu"),
                          _getSizedBox(
                              context, "calendar", "Exporter", 4, "/exporter"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSizedBox(
                              context, "settings", "Famille", 5, "/famille"),
                          SizedBox(
                            width: 154.0,
                            height: 160.0,
                            child: Material(
                              color: const Color.fromARGB(255, 21, 21, 21),
                              elevation: 8,
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.black26,
                                onTap: () {

                                  reinitialiser(context);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image:  AssetImage('assets/note.png'),
                                      height: 80,
                                      width: 64.0,
                                      //fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Réinitialiser",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "6",
                                      style: const TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )// réinitialiser
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
   reinitialiser(BuildContext context) {
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
                     "Voullez-vous vraiment réinitialiser l'application ?",
                     style: TextStyle(fontSize: 20, color: Colors.black),
                   ),
                 ),
                 const SizedBox(height: 5),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     ElevatedButton(
                       style:
                       ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
                       child: const Text('Oui'),
                       onPressed: () async {
                         await db
                             .emptyTable("scan");
                         await db
                             .emptyTable("immo");
                         await db
                             .emptyTable("famille");
                         await db
                             .emptyTable("lieu");
                         await db
                             .emptyTable("situation");
                         await db
                             .emptyTable("agent");
                         await db.rawInsertData("INSERT INTO agent (id,nom,prenom) VALUES(1,'Agent','standard')");
                         await db.rawInsertData("INSERT INTO lieu (id,adresse,etage,champ1,code_bare) VALUES(1,'Lieu standard',0,'','0000')");
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                               content: Text(
                                 'L\'application est bien réinitialiser',
                                 style: TextStyle(color: Colors.green),
                               )),
                         );
                       },
                     ),
                     ElevatedButton(
                       style:
                       ElevatedButton.styleFrom(primary: Color.fromARGB(255,0, 118, 182)),
                       child: const Text('Annuler'),
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

//To avoid re-writing the same code in the menu buttons.
_getSizedBox(
    BuildContext context,
    image /*the image of the button*/,
    role /*the function of the button*/,
    number /*the number of the button*/,
    route /* what we will do when the button clicked */
    ) {
  return SizedBox(
    width: 154.0,
    height: 160.0,
    child: Material(
      color: const Color.fromARGB(255, 21, 21, 21),
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.black26,
        onTap: () {
          Navigator.pushNamed(context, "$route");
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image:  AssetImage('assets/$image.png'),
              height: 80,
              width: 64.0,
              //fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "$role",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "$number",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    ),
  );
}

