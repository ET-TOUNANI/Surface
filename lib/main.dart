import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
        home:Dashboard()
    )
);

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("App name",style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),),
                      Image.asset("assets/image.png",width: 52.0,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Welcome, chez  \n Thales informatique",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing:20,
                      runSpacing: 20.0,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/scan.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Inventaire",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "1",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/importer.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Importer",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "2",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/todo.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Lieu",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "3",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/settings.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Famille",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "4",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/calendar.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Exporter",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "5",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width:160.0,
                              height: 160.0,
                              child: Card(

                                color: Color.fromARGB(255,21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset("assets/note.png",width: 64.0,),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Réinitialiser",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "6",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}