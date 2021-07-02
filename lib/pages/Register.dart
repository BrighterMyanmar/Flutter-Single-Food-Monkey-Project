import 'package:app/helper/TrianglePainter.dart';
import 'package:app/util/Api.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(
                painter: TrianglePainter(msize),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset("assets/images/FoodMonkey.png"),
                    SizedBox(height: 40),
                    Text("Register", style: Constants.getTitleTextStyle(40)),
                    Form(
                        child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: "Name",
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            onPressed: () async {
                              var name = nameController.text;
                              var phone = phoneController.text;
                              var password = passwordController.text;
                              bool bol = await Api.registerUser(
                                  name: name, phone: phone, password: password);
                              if (bol) {
                                Navigator.pop(context);
                              } else {
                                print("Registration Fail!");
                              }
                            },
                            color: Constants.accent,
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Constants.primary),
                                Text("Register",
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
