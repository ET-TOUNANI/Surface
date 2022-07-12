import 'package:exemple1/pages/Dashboard.page.dart';
import 'package:exemple1/pages/Exporte.page.dart';
import 'package:exemple1/pages/inventer/InventaireForm.page.dart';
import 'package:exemple1/pages/famille.pages.dart';
import 'package:exemple1/pages/lieu.pages.dart';
import 'package:exemple1/pages/splashScreen.page.dart';
import 'package:flutter/material.dart';
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Thalès Informatique",
      home: getSplashScreen(),
      routes: {
        "/home":(context)=>Dashboard(),
        "/inventer":(context)=>InventaireForm(),
        "/lieu":(context)=>GetLieu(),
        "/famille":(context)=>GetFamille(),
        "/exporter":(context)=>Export(),
      },
    )
);

