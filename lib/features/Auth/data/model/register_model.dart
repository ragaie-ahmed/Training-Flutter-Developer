class RegisterModel {
  RegisterModel({
      this.email, 
      this.image, 
      this.username, 
      this.otp,});

  RegisterModel.fromJson(dynamic json) {
    email = json['email'];
    image = json['image'];
    username = json['username'];
    otp = json['otp'];
  }
  String? email;
  String? image;
  String? username;
  num? otp;
RegisterModel copyWith({  String? email,
  String? image,
  String? username,
  num? otp,
}) => RegisterModel(  email: email ?? this.email,
  image: image ?? this.image,
  username: username ?? this.username,
  otp: otp ?? this.otp,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['image'] = image;
    map['username'] = username;
    map['otp'] = otp;
    return map;
  }

}