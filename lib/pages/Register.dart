import 'package:app/util/Api.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FlatButton(
                  color: Colors.pinkAccent,
                  onPressed: () async {
                    
                    bool bol = await Api.getAllDeliveries();

                    // bool bol = await Api.registerUser(
                    //     name: "Superman",
                    //     phone: "0800500500",
                    //     email: "superman@gmail.com",
                    //     password: "@123!Abc");
                    // if (bol) {
                    //   print("Register Success");
                    //   //Navigator.pushNamed(context, "/login");
                    // } else {
                    //   print("Register Fail");
                    // }
                  },
                  child:
                      Text("Register", style: TextStyle(color: Colors.white))),
            )
          ],
        ));
  }
}
