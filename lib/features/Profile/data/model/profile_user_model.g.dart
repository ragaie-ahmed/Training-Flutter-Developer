

part of 'profile_user_model.dart';





class ProfileUserModelAdapter extends TypeAdapter<ProfileUserModel> {
  @override
  final int typeId = 0;

  @override
  ProfileUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileUserModel(
      id: fields[0] as num?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileUserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
