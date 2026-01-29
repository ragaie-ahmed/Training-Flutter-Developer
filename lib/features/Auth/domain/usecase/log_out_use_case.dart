import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Auth/domain/repo/repo_register.dart';

class LogOutUseCase{
  final RepoRegister repoRegister;

  LogOutUseCase({required this.repoRegister});
  Future<Either<String,void>>execute()async{
    return repoRegister.logOut();
  }
}