import 'package:app/util/Api.dart';
import 'package:flutter/material.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  appVersionCheck() async {
    bool apiCheckPass = await Api.getAppVerstion();
    bool tags = await Api.getAllTags();
    bool cats = await Api.getAllCats();
    if (apiCheckPass && tags && cats) {
      Navigator.pushNamed(context, "/home");
    } else {
      print("Update Your Application!");
      
    }
  }

  @override
  void initState() {
    super.initState();
    appVersionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash"),
      ),
    );
  }
}
