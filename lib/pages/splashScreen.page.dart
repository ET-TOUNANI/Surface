import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:exemple1/pages/Dashboard.page.dart';
getSplashScreen(){
  return SplashScreen(
      seconds: 5,
      navigateAfterSeconds:Dashboard(),
      title: new Text(
        'Thalès Informmatique \n Copyright ©2022',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white),
      ),
      image: new Image.asset('assets/thales.png'),
      photoSize: 100.0,
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.white
  );
}
