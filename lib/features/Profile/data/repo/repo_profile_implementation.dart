import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tharadtech/core/errors/exception.dart';
import 'package:tharadtech/features/Profile/data/data_source/local_data_source_profile.dart';
import 'package:tharadtech/features/Profile/data/data_source/remote_data_source_profile.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';
import 'package:tharadtech/features/Profile/domain/repo/base_repo_profile.dart';

class RepoProfileImplementation extends BaseRepoProfile {
  final RemoteDataSourceProfile remoteDataSourceProfile;
  final ProfileLocalDataSource localDataSource;

  RepoProfileImplementation(
       {
        required this.remoteDataSourceProfile,
         required this.localDataSource
      });
  @override
  Future<Either<String, ProfileUserModel>> getDataProfile() async {
    try {
      final profile = await remoteDataSourceProfile.getProfile();
      return Right(profile);
    } catch (e) {
      final cached = localDataSource.getLastProfile();
      if (cached != null) return Right(cached);

      return Left(e is ServerException ? e.errModel.toString() : "Connection Failed");
    }
  }

  @override
  Future<Either<String, void>> updateProfile({
    required String username,
    required String email,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    File? image,
  }) async {
    try {
      var profileUpdate = await remoteDataSourceProfile.updateProfileUser(
        username: username,
        email: email,
        password: password,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
        image: image,
      );


      await remoteDataSourceProfile.getProfile();

      return Right(profileUpdate);
    } on ServerException catch (e) {
      return Left(e.errModel.toString());
    } catch (e) {
      return Left('Failed to update profile: ${e.toString()}');
    }
  }
}