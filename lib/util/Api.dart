import 'dart:convert';

import 'package:app/models/Category.dart';
import 'package:app/models/Delivery.dart';
import 'package:app/models/Product.dart';
import 'package:app/models/Tag.dart';
import 'package:app/models/User.dart';
import 'package:app/util/Constants.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<bool> getAppVerstion() async {
    var url = "${Constants.API_URL}/appversion";
    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    return Constants.AppVersion == double.parse(responseData["result"]);
  }

  static Future<bool> registerUser({name, phone, password}) async {
    Uri url = Uri.parse("${Constants.BASE_URL}/user/register");
    var json = jsonEncode({
      "name": name,
      "phone": phone,
      "email": "email@email.com",
      "password": "@123!Abc"
    });
    var response = await http.post(url, body: json, headers: Constants.headers);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return responseData["con"];
  }

  static Future<bool> loginUser({phone, password}) async {
    Uri url = Uri.parse("${Constants.BASE_URL}/user");
    var json = jsonEncode({"phone": phone, "password": password});
    var response = await http.post(url, body: json, headers: Constants.headers);
    var responseData = jsonDecode(response.body);
    var userData = responseData["result"];
    Constants.user = User.fromJson(userData);
    return responseData["con"];
  }

  static Future<bool> getAllCats() async {
    var url = "${Constants.API_URL}/categories";
    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);

    if (responseData["con"]) {
      var catsList = responseData["result"] as List;
      Constants.cats = catsList.map((cat) => Category.fromJson(cat)).toList();
    }
    return responseData["con"];
  }

  static Future<bool> getAllTags() async {
    var url = "${Constants.API_URL}/tags";
    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      var tagsList = responseData["result"] as List;
      Constants.tags = tagsList.map((tag) => Tag.fromJSon(tag)).toList();
    }
    return responseData["con"];
  }

  static Future<bool> getAllDeliveries() async {
    var url = Uri.parse("${Constants.API_URL}/deliveries");
    var response = await http.get(url);
    var responseData = jsonDecode(response.body);

    if (responseData["con"]) {
      var deliList = responseData["result"] as List;
      List<Delivery> delis =
          deliList.map((deli) => Delivery.fromJson(deli)).toList();

      delis.forEach((deli) {
        print(deli.id);
        print(deli.name);
        print(deli.duration);
        print(deli.image);
        print(deli.price);
        print(deli.remarks);
      });
    }

    return true;
  }

  static Future<List<Product>> getPaginatedProducts({pageNo}) async {
    Uri uri = Uri.parse("${Constants.API_URL}/products/$pageNo");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    List<Product> products = [];
    if (response["con"]) {
      var pList = response["result"] as List;
      products = pList.map((product) => Product.fromJson(product)).toList();
    }
    return products;
  }
}
