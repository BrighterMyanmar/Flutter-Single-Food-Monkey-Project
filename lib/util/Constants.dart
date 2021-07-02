import 'package:app/models/Category.dart';
import 'package:app/models/Product.dart';
import 'package:app/models/Tag.dart';
import 'package:app/models/User.dart';
import 'package:flutter/material.dart';

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

  static const BASE_URL = "http://192.168.8.103:3000";
  // static const BASE_URL = "http://localhost:3000";
  static const API_URL = "$BASE_URL/api";

  static User? user = null;

  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static List<Category> cats = [];
  static List<Tag> tags = [];

  static String changeImageLink(image) {
    var img = "http://192.168.8.103:3000" + image.split("3000")[1];
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
}
