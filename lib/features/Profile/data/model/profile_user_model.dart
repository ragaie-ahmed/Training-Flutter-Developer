import 'package:hive/hive.dart';
part 'profile_user_model.g.dart';
@HiveType(typeId: 0)
class ProfileUserModel extends HiveObject {
  ProfileUserModel({
      this.id, 
      this.username, 
      this.email, 
      this.image,});

  ProfileUserModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
  }
  @HiveField(0)
  num? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? image;

  ProfileUserModel copyWith({  
    num? id,
    String? username,
    String? email,
    String? image,
  }) => ProfileUserModel(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    image: image ?? this.image,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['image'] = image;
    return map;
  }

  @override
  String toString() {
    return 'ProfileUserModel(id: $id, username: $username, email: $email, image: $image)';
  }
}