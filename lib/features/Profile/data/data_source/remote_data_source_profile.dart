import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tharadtech/core/api/api_end_points.dart';
import 'package:tharadtech/core/api/api_service.dart';
import 'package:tharadtech/core/errors/exception.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';
import 'package:tharadtech/core/utils/constant.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';

abstract class RemoteDataSourceProfile {
  Future<ProfileUserModel> getProfile();

  Future<void> updateProfileUser({
    required String username,
    required String email,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    File? image,
  });
}

class RemoteDataSourceProfileImplementation extends RemoteDataSourceProfile {
  final ApiService apiService;

  RemoteDataSourceProfileImplementation({required this.apiService});

  @override
  Future<ProfileUserModel> getProfile() async {
    try {
      var response = await apiService.get(
        ApiEndPoints.profileDetails,
        headers: {
          'Authorization':
              "Bearer ${await SharedPrefService.getSecuredString(SharedPrefService.storedToken)}",
        },
      );
      var responseBody = response["data"];
      var data = ProfileUserModel.fromJson(responseBody);
      var box = Hive.box<ProfileUserModel>(Constant.kProfileBox);
      await box.put(Constant.kProfileKey, data);
      return data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<void> updateProfileUser({
    required String username,
    required String email,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    File? image,
  }) async {
    final Map<String, dynamic> data = {
      'username': username,
      'email': email,
      'password': password,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
      '_method': 'PUT',
    };

    if (image != null) {
      data['image'] = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
    }

    await apiService.post(
      ApiEndPoints.updateProfile,
      data: FormData.fromMap(data),
      headers: {
        'Authorization':
            "Bearer ${await SharedPrefService.getSecuredString(SharedPrefService.storedToken)}",
        'Accept': 'application/json',
      },
    );
  }
}
