class Delivery {
  String? id, name, duration, image;
  int? price;
  List<dynamic>? remarks;

  Delivery(
      {this.id,
      this.name,
      this.duration,
      this.image,
      this.price,
      this.remarks});

  factory Delivery.fromJson(dynamic data) {
    List<dynamic> rm = data["remarks"] as List;
    return Delivery(
        id: data["_id"],
        name: data["name"],
        duration: data["duration"],
        image: data["image"],
        price: data["price"],
        remarks: rm);
  }
}

/*
{
      "remarks": [
        "Two",
        "One"
      ],
      "_id": "605d472fb8452323b0a4c926",
      "name": "1 Week",
      "price": 800,
      "duration": "1 Week",
      "image": "http://localhost:3000/uploads/5_1616675052525.jpg"
    },
*/
