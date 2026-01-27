import 'package:dartz/dartz.dart';
import 'package:tharadtech/features/Auth/data/model/log_in_model.dart';
import 'package:tharadtech/features/Auth/domain/repo/repo_register.dart';

class LogInUseCase {
  final RepoRegister repoRegister;

  LogInUseCase({required this.repoRegister});

  Future<Either<String, void>> execute({
    required String email,
    required String passWord,
  }) async {
    return await repoRegister.logIn(email: email, passWord: passWord);
  }
}
