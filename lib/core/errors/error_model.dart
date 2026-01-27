class ErrorModel {
  final dynamic status;
  final String errorMessage;

  ErrorModel({
    this.status,
    required this.errorMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    String msg = jsonData['message'] ?? 'حدث خطأ غير متوقع';

    if (jsonData['errors'] != null && jsonData['errors'] is Map) {
      final errors = jsonData['errors'] as Map<String, dynamic>;
      final firstErrorKey = errors.keys.first;
      final firstErrorList = errors[firstErrorKey];
      if (firstErrorList is List && firstErrorList.isNotEmpty) {
        final firstError = firstErrorList.first;
        if (firstError is Map<String, dynamic> && firstError['message'] != null) {
          msg = firstError['message'].toString();
        } else if (firstError is String) {
          msg = firstError;
        }
      }
    }

    return ErrorModel(
      errorMessage: msg,
      status: jsonData['status'],
    );
  }
}
