import 'package:exemple1/pages/Dashboard.page.dart';
import 'package:exemple1/pages/InventaireForm.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
      title: "Thalès Informatique",
      routes: {
        "/":(context)=>Dashboard(),
        "/inventer":(context)=>InventaireForm()
      },
    )
);

