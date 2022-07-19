import 'package:exemple1/configs/AppBar.config.dart';
import 'package:flutter/material.dart';
import 'package:exemple1/configs/GetButtonNavigatBar.config.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.resWidget});
  final Widget resWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: GetAppBare(),
      body: SingleChildScrollView(
        child: resWidget, // show the card details of the immo
      ),
      bottomNavigationBar: GetButtonNavigatBar(context,'assets/inventer_aide.pdf'),
    );
  }
}
