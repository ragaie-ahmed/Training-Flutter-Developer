import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Auth/domain/repo/repo_register.dart';

class RegisterUseCase{
  final RepoRegister repoRegister;
  RegisterUseCase(this.repoRegister);
  Future<Either<String,void>>execute({
    required String name,
    required String email,
    required File image,
    required String passWord,
    required String confirmPassWord
})async
  {
    return repoRegister.register(name: name, email: email, image: image, passWord: passWord, confirmPassWord: confirmPassWord);
  }
}