import 'package:hive/hive.dart';
import 'package:tharadtech/core/utils/constant.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';

abstract class ProfileLocalDataSource {
  ProfileUserModel? getLastProfile();
  Future<void> cacheProfile(ProfileUserModel profile);
  Future<void> clearCache();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  ProfileUserModel? getLastProfile() {
    try {
      var box = Hive.box<ProfileUserModel>(Constant.kProfileBox);
      return box.get(Constant.kProfileKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheProfile(ProfileUserModel profile) async {
      var box = Hive.box<ProfileUserModel>(Constant.kProfileBox);
      await box.put(Constant.kProfileKey, profile);

  }

  @override
  Future<void> clearCache() async {
      var box = Hive.box<ProfileUserModel>(Constant.kProfileBox);
      await box.delete(Constant.kProfileKey);

  }
}