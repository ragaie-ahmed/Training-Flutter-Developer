import 'package:dio/dio.dart';
import 'package:tharadtech/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

Never handleDioException(DioException e) {
  ErrorModel getErrorModel() {
    if (e.response?.data != null && e.response!.data is Map<String, dynamic>) {
      return ErrorModel.fromJson(e.response!.data);
    } else {
      return ErrorModel(errorMessage: 'Unexpected error format');
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      throw ServerException(errModel: getErrorModel());

    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errModel: ErrorModel(errorMessage: 'Receive timeout'));

    case DioExceptionType.connectionError:
      throw ServerException(
          errModel: ErrorModel(errorMessage: 'No Internet Connection'));

    case DioExceptionType.badResponse:
      throw ServerException(errModel: getErrorModel());
  }
}
