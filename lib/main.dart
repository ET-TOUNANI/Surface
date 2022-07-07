
import 'package:exemple1/pages/Dashboard.page.dart';
import 'package:exemple1/pages/inventer/InventaireForm.page.dart';
import 'package:exemple1/pages/inventer/ScanImmo.page.dart';
import 'package:exemple1/pages/famille.pages.dart';
import 'package:exemple1/pages/inventer/chooseLieu.dart';
import 'package:exemple1/pages/lieu.pages.dart';
import 'package:exemple1/pages/splashScreen.page.dart';
import 'package:flutter/material.dart';

import 'package:exemple1/configs/storage.dart';

void main() => runApp(
    MaterialApp(
      title: "Thalès Informatique",
      home: getSplashScreen(),
      routes: {
        "/home":(context)=>Dashboard(),
        "/inventer":(context)=>InventaireForm(storage: CounterStorage(),),
        "/etape3":(context)=>ScannImmo(),
        "/etape2":(context)=>ChooseLieu(storage: CounterStorage()),
        "/lieu":(context)=>GetLieu(),
        "/famille":(context)=>GetFamille(),
      },
    )
);

