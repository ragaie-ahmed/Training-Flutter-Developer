import 'package:dio/dio.dart';
import 'package:tharadtech/core/api/api_end_points.dart';
import 'package:tharadtech/core/api/api_interceptor.dart';
import 'package:tharadtech/core/api/api_service.dart';
import 'package:tharadtech/core/errors/exception.dart';




class DioConsumer extends ApiService {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ApiEndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true));
  }
  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(path,
          options: Options(headers: headers),
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future get(String path,
      {Object? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      if (queryParameters != null) {
        path =
            '$path?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      }
      final response =
          await dio.get(path, data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
        Map<String, dynamic>? headers,

        Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(String path,
      {Object? data, Map<String, dynamic>? headers}) async {
    try {
      final response =
          await dio.post(path, data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? headers,
      Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.put(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
