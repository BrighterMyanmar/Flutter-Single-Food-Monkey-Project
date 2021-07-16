import 'package:app/models/Category.dart';
import 'package:app/models/Product.dart';
import 'package:app/models/Tag.dart';
import 'package:app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Constants {
  static const double AppVersion = 1.0;
  static const Color primary = Color(0xFFF6F6F6);
  static const Color secondary = Color(0xFFFFBB91);
  static const Color accent = Color(0xFFFF8E6E);
  static const Color normal = Color(0xFF515070);

  static const Color yellow = Color(0xffFDC054);
  static const Color darkGrey = Color(0xff202020);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);

  static const String sampleText = """ 
  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatem, esse vero sequi veniam voluptate at iure aut dolor deleniti molestiae temporibus sint doloribus, assumenda dolore quas, nostrum ea aperiam enim!
  """;
  static User? user;
  static const BASE_URL = "http://192.168.8.100:3000";
  static String SOCKET_END_POINT = "$BASE_URL/chat?token=${user?.token}";
  static const String GALLERY_URL = "$BASE_URL/gallery";
  static const String sampleImage = "$BASE_URL/uploads/8_1616675537280.png";
  static const String sampleImage2 = "$BASE_URL/uploads/9_1616675537285.png";

  static List<List<String>> orders = [
    [
      "Order One",
      "Order One",
      "Order One",
    ],
    [
      "Order One",
      "Order One",
      "Order One",
      "Order One",
    ],
    [
      "Order One",
      "Order One",
      "Order One",
      "Order One",
      "Order One",
    ],
  ];

  static const API_URL = "$BASE_URL/api";
  static const shopId = "605c19163bac7310fb16aabc";

  static Map<String, String> headers = {
    "content-type": "application/json",
  };
  static Map<String, String> tokenHeader = {
    "content-type": "application/json",
    "authorization": "Bearer ${user?.token}"
  };

  static List<Category> cats = [];
  static List<Tag> tags = [];
  static IO.Socket? socket;

  static getSocket() {
    socket = IO.io(SOCKET_END_POINT, <String, dynamic>{
      'transports': ['websocket']
    });
    socket?.onConnect((_) {
      print('connect');
    });
  }

  static String changeImageLink(image) {
    var img = "$BASE_URL/uploads" + image.split("uploads")[1];
    print(img);
    return img;
  }

  static List<Product> cartProducts = [];

  static addToCart(product) {
    bool exist = false;
    if (cartProducts.length > 0) {
      cartProducts.forEach((prds) {
        if (prds.id == product.id) {
          prds.count++;
          exist = true;
        }
      });
      if (!exist) {
        cartProducts.add(product);
      }
    } else {
      cartProducts.add(product);
    }
  }

  static removeProduct(product) {
    cartProducts.removeWhere((prds) => prds.id == product.id);
  }

  static addProductCount(product) {
    cartProducts.forEach((prds) {
      if (prds.id == product.id) {
        prds.count++;
      }
    });
  }

  static reduceProductCount(product) {
    cartProducts.forEach((prds) {
      if (prds.id == product.id) {
        if (prds.count > 1) {
          prds.count--;
        }
      }
    });
  }

  static TextStyle getTitleTextStyle(double fsize) {
    return TextStyle(
        fontSize: fsize, fontWeight: FontWeight.bold, color: Constants.normal);
  }

  static Center getShoppingCardWidget(context, Color color) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 10),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/cart");
              },
              child: Icon(
                Icons.shopping_cart,
                size: 40,
                color: color,
              ),
            ),
            Positioned(
              right: 0,
              top: -10,
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text("${Constants.cartProducts.length}",
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  static int getCartTotal() {
    int total = 0;
    cartProducts.forEach((prod) {
      total += prod.count * int.parse(prod.price.toString());
    });
    return total;
  }

  static generateOrder() {
    List<Map> cartList = [];
    cartProducts.forEach((prod) {
      var map = new Map();
      map["productId"] = prod.id;
      map["count"] = prod.count.toString();
      cartList.add(map);
    });
    return cartList;
  }
}
