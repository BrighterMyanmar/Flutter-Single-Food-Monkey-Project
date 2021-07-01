import 'package:app/util/Constants.dart';

class Category {
  String? id, name, image;
  List<dynamic>? subs;

  Category({this.id, this.name, this.image, this.subs});

  factory Category.fromJson(dynamic data) {
    List<dynamic> sbs = data["subs"] as List;
    var img = data["image"];
    img = "${Constants.BASE_URL}/$img";
    return Category(id: data["_id"], name: data["name"], image: img, subs: sbs);
  }
}
/*
 {
      "subs": [
        "605c19aae63e4d10fddf511e",
        "605c19b0e63e4d10fddf511f",
        "605c1d7d184b7b1136d4ec3b"
      ],
      "_id": "605c195ce63e4d10fddf511b",
      "name": "Machine",
      "image": "http://localhost:3000/uploads/4_1616648520907.png",
      "created": "2021-03-25T05:02:20.387Z",
      "updated": "2021-03-25T05:02:20.387Z"
    },
*/
