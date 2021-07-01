import 'package:app/pages/Cart.dart';
import 'package:app/pages/Detail.dart';
import 'package:app/pages/Flash.dart';
import 'package:app/pages/Home.dart';
import 'package:app/pages/Login.dart';
import 'package:app/pages/Preview.dart';
import 'package:app/pages/ProductPage.dart';
import 'package:app/pages/Register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Flash(),
      "/home": (context) => Home(),
      "/products": (context) => ProductPage(),
      "/preview": (context) => Preview(),
      "/detail": (context) => Detail(),
      "/cart": (context) => Cart(),
      "/register": (context) => Register(),
      "/login": (context) => Login()
    },
    theme: ThemeData(fontFamily: "English"),
  ));
}
