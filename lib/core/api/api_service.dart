abstract class ApiService {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    // bool isFormData = false,
  });

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? headers,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
