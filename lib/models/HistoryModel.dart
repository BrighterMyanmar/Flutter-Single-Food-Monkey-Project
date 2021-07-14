class HistoryModel {
  bool? status;
  int? count, total;
  List<Item>? items;
  String? created;

  HistoryModel({this.status, this.count, this.total, this.items, this.created});

  factory HistoryModel.fromJson(dynamic data) {
    var list = data['items'] as List;
    List<Item> items = list.map((e) => Item.fromJson(e)).toList();
    var ct = data["created"].split("T")[0];
    return HistoryModel(
        status: data["status"],
        count: data["count"],
        total: data["total"],
        created: ct,
        items: items);
  }
}

class Item {
  List<dynamic>? images;
  bool? status;
  int? count, price;
  String? name;

  Item({this.images, this.status, this.count, this.price, this.name});

  factory Item.fromJson(dynamic data) {
    List<dynamic> imgs = data['images'] as List;
    return Item(
        images: imgs,
        status: data['status'],
        count: data['count'],
        price: data['price'],
        name: data['name']);
  }
}
