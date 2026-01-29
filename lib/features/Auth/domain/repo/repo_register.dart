import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class RepoRegister {
  Future<Either<String, void>> register({
    required String name,
    required String email,
    required File image,
    required String passWord,
    required String confirmPassWord,
  });

  Future<Either<String, void>> otp({
    required String email,
    required String otp,
  });

  Future<Either<String, void>> logIn({
    required String email,
    required String passWord,
  });
Future<Either<String,void>>logOut();
}
