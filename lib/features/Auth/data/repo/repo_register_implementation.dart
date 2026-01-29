import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tharadtech/core/errors/exception.dart';
import 'package:tharadtech/features/Auth/data/data_source/remote_data_source.dart';
import 'package:tharadtech/features/Auth/domain/repo/repo_register.dart';

class RepoRegisterImplementation extends RepoRegister {
  final RemoteDataSourceRegister remoteDataSourceRegister;

  RepoRegisterImplementation({required this.remoteDataSourceRegister});

  @override
  Future<Either<String, void>> register(
      {required String name, required String email, required File image, required String passWord, required String confirmPassWord}) async {
    try {
      final result = await remoteDataSourceRegister.register(name: name,
          email: email,
          image: image,
          passWord: passWord,
          confirmPassWord: confirmPassWord);
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  @override
  Future<Either<String, void>> otp({required String email, required String otp}) async{
    try {
      final result = await remoteDataSourceRegister.otp(email: email, otp: otp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  @override
  Future<Either<String, void>> logIn({required String email, required String passWord}) async{
    try {
      final result = await remoteDataSourceRegister.logIn(email: email, passWord: passWord);
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  @override
  Future<Either<String, void>> logOut() async{
    try {
      final result = await remoteDataSourceRegister.logOut();
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}