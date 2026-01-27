class LogInModel {
  LogInModel({
      this.token, 
      this.username, 
      this.email,});

  LogInModel.fromJson(dynamic json) {
    token = json['token'];
    username = json['username'];
    email = json['email'];
  }
  String? token;
  String? username;
  String? email;
LogInModel copyWith({  String? token,
  String? username,
  String? email,
}) => LogInModel(  token: token ?? this.token,
  username: username ?? this.username,
  email: email ?? this.email,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['username'] = username;
    map['email'] = email;
    return map;
  }

}