class MsgRes {
  String? id, name, originalname, mimetype, link, created;
  int? size;

  MsgRes(
      {this.id,
      this.name,
      this.originalname,
      this.mimetype,
      this.link,
      this.created});

  factory MsgRes.fromJson(dynamic data) {
    return MsgRes(
      id: data['_id'],
      name: data['name'],
      originalname: data['originalname'],
      mimetype: data['_imimetyped'],
      link: data['link'],
      created: data['created'],
    );
  }
}
