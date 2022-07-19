
import 'dart:io';

import 'package:flutter/material.dart';

import '../pages/pdfViewPage.dart';
import '../widgets/pdf.widget.dart';


GetButtonNavigatBar(context,String path){
   File file;

  return BottomNavigationBar(
    currentIndex: 1,
    onTap: (index) async {
      file=await  PDFApi.loadAsset(path);
      if(index==0){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/inventer', (Route<dynamic> route) => false);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/home");
      }
      else{
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
        );
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