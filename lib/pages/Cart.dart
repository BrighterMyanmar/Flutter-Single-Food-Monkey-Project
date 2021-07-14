import 'package:app/models/Product.dart';
import 'package:app/pages/History.dart';
import 'package:app/pages/Login.dart';
import 'package:app/util/Api.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primary,
        appBar: AppBar(
          title: Text("Your Cart"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: Constants.cartProducts.length,
                    itemBuilder: (context, index) =>
                        _buildCartProduct(Constants.cartProducts[index]))),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Constants.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Sub Total  ",
                            style: TextStyle(
                                color: Constants.primary, fontSize: 30)),
                        Text("${Constants.getCartTotal()} Ks ",
                            style: TextStyle(
                                color: Constants.normal, fontSize: 30)),
                      ],
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        color: Constants.normal,
                        onPressed: () async {
                          if (Constants.user == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          } else {
                            bool bol = await Api.updateOrder(
                                total: Constants.getCartTotal(),
                                items: Constants.generateOrder());

                            if (bol) {
                              Constants.cartProducts = [];
                              Navigator.pushNamed(context, "/home");
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => History()));
                          }
                        },
                        child: Text("Order Now",
                            style: TextStyle(
                                color: Constants.primary, fontSize: 30)))
                  ]),
            )
          ],
        ));
  }

  Widget _buildCartProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(color: Constants.primary, boxShadow: [
                // BoxShadow(
                //     color: Color(0xffA22447).withOpacity(1),
                //     offset: Offset(0, 0),
                //     blurRadius: 20,
                //     spreadRadius: 3)
              ]),
              child: Row(
                children: [
                  Image.network(Constants.changeImageLink(product.images?[0]),
                      width: 120, height: 120),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(product.name ?? "",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Constants.normal)),
                      ),
                      SizedBox(height: 10),
                      Row(children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Constants.normal,
                                    fontFamily: "English"),
                                children: [
                              TextSpan(text: "Price ${product.price}\n"),
                              TextSpan(
                                  text:
                                      "Total ${(product.price ?? 0) * product.count}"),
                            ])),
                        SizedBox(width: 30),
                        Row(children: [
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.normal),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Constants.reduceProductCount(product);
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Constants.primary,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                                product.count.toString().padLeft(2, "0"),
                                style: TextStyle(fontSize: 20)),
                          ),
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.normal),
                              child: InkWell(
                                onTap: () {
                                  Constants.addProductCount(product);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Constants.primary,
                                ),
                              )),
                        ]),
                      ]),
                    ]),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -10,
              top: -10,
              child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Constants.accent, shape: BoxShape.circle),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          Constants.removeProduct(product);
                        });
                      },
                      child: Icon(Icons.clear, color: Constants.primary))),
            )
          ],
        ),
      ),
    );
  }
}
