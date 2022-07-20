import 'package:flutter/material.dart';

AppBar GetAppBare() {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 33, 33, 33),
    title:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "S",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "U",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "R",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "F",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "A",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "C",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "E",
          style: TextStyle(
              color: Color.fromARGB(255,0, 118, 182), fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
//https://onlinepngtools.com/change-png-color