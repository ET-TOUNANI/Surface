import 'package:flutter/material.dart';

AppBar GetAppBare() {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 33, 33, 33),
    title: const Text(
      "App name",
      style: TextStyle(
          color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
    ),
  );
}
