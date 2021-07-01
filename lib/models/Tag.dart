import 'package:app/util/Constants.dart';

class Tag {
  String? id, name, image;

  Tag({this.id, this.name, this.image});

  factory Tag.fromJSon(dynamic data) {
    var img = data["image"];
    img = "${Constants.BASE_URL}/$img";
    return Tag(id: data["_id"], name: data["name"], image: img);
  }
}

/*
 {
      "_id": "605c4c5e184b7b1136d4ec42",
      "name": "Latest",
      "image": "http://localhost:3000/uploads/4_1616648520907.png",
      "created": "2021-03-25T08:39:58.125Z",
      "updated": "2021-03-25T08:39:58.125Z"
    },
*/
