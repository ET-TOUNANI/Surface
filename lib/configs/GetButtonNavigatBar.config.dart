
import 'package:flutter/material.dart';

GetButtonNavigatBar(context){
  return BottomNavigationBar(
    currentIndex: 1,
    onTap: (index){
      if(index==0){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/inventer', (Route<dynamic> route) => false);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/");
      }
      else{
        Navigator.pushNamed(context, "/aide");
      }
    },
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color.fromARGB(255, 33, 33, 33),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    items: [
      BottomNavigationBarItem(

        icon: Icon(Icons.home),
        label: "Accueil",
      ),
      BottomNavigationBarItem(
        icon: Icon(
            Icons.help),
        label: "Aide",
      ),
    ],
  );
}