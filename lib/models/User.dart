class User {
  bool? status;
  String? id, name, email, phone, token;

  User({this.status, this.id, this.name, this.email, this.phone, this.token});

  factory User.fromJson(dynamic data) {
    return User(
      status: data['status'],
      id: data['_id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      token: data['token'],
    );
  }
}
