import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tharadtech/core/api/api_end_points.dart';
import 'package:tharadtech/core/api/api_service.dart';
import 'package:tharadtech/core/errors/exception.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';

abstract class RemoteDataSourceRegister {
  Future<void> register({
    required String name,
    required String email,
    required File? image,
    required String passWord,
    required String confirmPassWord,
  });

  Future<void> otp({required String email, required String otp});
  Future<void>logOut();

  Future<void> logIn({required String email, required String passWord});
}

class RemoteDataSourceRegisterImplementation extends RemoteDataSourceRegister {
  final ApiService apiService;

  RemoteDataSourceRegisterImplementation({required this.apiService});

  @override
  Future<void> register({
    required String name,
    required String email,
    required File? image,
    required String passWord,
    required String confirmPassWord,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': name,
        'email': email,
        'password': passWord,
        'password_confirmation': confirmPassWord,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      await apiService.post(ApiEndPoints.signUp, data: formData);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<void> otp({required String email, required String otp}) async {
    try {
      await apiService.get(
        ApiEndPoints.otp,

        queryParameters: {'email': email, 'otp': otp},
      );
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<void> logIn({required String email, required String passWord}) async {
    try {
      final formData = FormData.fromMap({"email": email, "password": passWord});
      var response = await apiService.post(ApiEndPoints.logIn, data: formData);

      await SharedPrefService.setSecuredString(
        SharedPrefService.storedToken,
        response["data"]['token'],
      );
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<void> logOut()async {
    try {
     await apiService.delete(ApiEndPoints.logout,headers: {
       'Authorization':
       "Bearer ${await SharedPrefService.getSecuredString(SharedPrefService.storedToken)}",
       'Accept': 'application/json',
      });

    } on DioException catch (e) {
      handleDioException(e);
    }
  }


}
