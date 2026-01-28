import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';
import 'package:tharadtech/features/Profile/domain/repo/base_repo_profile.dart';

class GetProfileUseCase {
  final BaseRepoProfile baseRepoProfile;

  GetProfileUseCase({required this.baseRepoProfile});

  Future<Either<String, ProfileUserModel>> execute() async {
    return await baseRepoProfile.getDataProfile();
  }
}
