import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';

abstract class BaseRepoProfile{
  Future<Either<String,ProfileUserModel>>getDataProfile();
  Future<Either<String, void>> updateProfile({
    required String username,
    required String email,
    required String password,
    required String  newPassword,
    required String  newPasswordConfirmation,
     File ? image,
  });
}