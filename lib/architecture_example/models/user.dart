class User {
  String name;
  String username;
  String token;
  User({this.name,this.username,this.token});

  User.initial()
      : token = '',
        name = '',
        username = '';

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    username = json['username'];
  }
}