import 'package:flutter/material.dart';

import 'package:exemple1/configs/AppBar.config.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: GetAppBare(),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "logo  \n Thales informatique",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
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

                        _getSizedBox(
                            context, "importer", "Importer", 2, "/importer"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSizedBox(context, "todo", "Lieu", 3, "/lieu"),
                        _getSizedBox(
                            context, "settings", "Famille", 4, "/famille"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSizedBox(
                            context, "calendar", "Exporter", 5, "/exporter"),
                        _getSizedBox(context, "note", "Réinitialiser", 6,
                            "/reinitialiser"),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
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
