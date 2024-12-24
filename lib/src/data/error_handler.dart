class FamxPayException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  FamxPayException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'FamxPayException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends FamxPayException {
  NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class CacheException extends FamxPayException {
  CacheException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class ApiException extends FamxPayException {
  final int? statusCode;

  ApiException(String message, {
    this.statusCode,
    String? code,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);
}