import 'package:app/helper/TrianglePainter.dart';
import 'package:app/pages/Register.dart';
import 'package:app/util/Api.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var phoneController = TextEditingController(text: "09300300300");
  var passwordController = TextEditingController(text: "@123!Abc");
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(
                painter: TrianglePainter(msize),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Image.asset("assets/images/FoodMonkey.png"),
                    SizedBox(height: 40),
                    Text("Login", style: Constants.getTitleTextStyle(40)),
                    Form(
                        child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              labelText: "Phone",
                              labelStyle: TextStyle(
                                  color: Constants.normal, fontSize: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.normal)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.normal))),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Constants.normal, fontSize: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.normal)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants.normal))),
                        )
                      ],
                    )),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text("Not a member yet! \nRegister here!",
                              style: TextStyle(color: Colors.blue[400])),
                        ),
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            onPressed: () async {
                              var phone = phoneController.text;
                              var password = passwordController.text;
                              bool bol = await Api.loginUser(
                                  phone: phone, password: password);
                              if (bol) {
                                Constants.getSocket();
                                Navigator.pop(context);
                              }
                            },
                            color: Constants.accent,
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Constants.primary),
                                Text("Login",
                                    style: TextStyle(color: Constants.primary))
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
