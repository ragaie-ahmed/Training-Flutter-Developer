import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Profile/domain/repo/base_repo_profile.dart';

class UpdateProfileUseCase{
  final BaseRepoProfile baseRepoProfile;

  UpdateProfileUseCase({required this.baseRepoProfile});

  Future<Either<String, void>> execute( {
    required String username,
    required String email,
    required String password,
    required String  newPassword,
    required String  newPasswordConfirmation,
     File ? image,
  }) async {
    return await baseRepoProfile.updateProfile(username: username, email: email, password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation, image: image);
  }
}
