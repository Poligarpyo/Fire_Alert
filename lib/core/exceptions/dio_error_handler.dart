// lib/core/exceptions/dio_error_handler.dart

import 'package:dio/dio.dart';

/// Centralized Dio error handler.
/// Throws a human-readable [Exception] based on status code or [DioException].
///
/// Usage:
///   DioErrorHandler.handle(e);                          // from catch block
///   DioErrorHandler.handleStatusCode(statusCode);       // from response
class DioErrorHandler {
  DioErrorHandler._();

  /// Call this inside a `on DioException catch (e)` block.
  static Exception handle(DioException e) {
    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      return handleStatusCode(statusCode);
    }
    return switch (e.type) {
      DioExceptionType.connectionTimeout => Exception('Connection timed out. Check your internet.'),
      DioExceptionType.receiveTimeout    => Exception('Server took too long to respond.'),
      DioExceptionType.sendTimeout       => Exception('Request timed out. Try again.'),
      DioExceptionType.connectionError   => Exception('No internet connection.'),
      DioExceptionType.cancel            => Exception('Request was cancelled.'),
      _                                  => Exception(e.message ?? 'Something went wrong.'),
    };
  }

  /// Call this after checking `response.statusCode` from a successful Dio call.
  static Exception handleStatusCode(int statusCode, {String? context}) {
    final prefix = context != null ? '[$context] ' : '';
    return switch (statusCode) {
      400 => Exception('${prefix}Invalid request details.'),
      401 => Exception('${prefix}Unauthorized. Please log in again.'),
      403 => Exception('${prefix}Access denied.'),
      404 => Exception('${prefix}Resource not found.'),
      409 => Exception('${prefix}Account already exists. Please login instead.'),
      422 => Exception('${prefix}Validation failed. Please check your details.'),
      429 => Exception('${prefix}Too many requests. Please slow down.'),
      500 => Exception('${prefix}Server error. Please try again later.'),
      503 => Exception('${prefix}Service unavailable. Try again later.'),
      _   => Exception('${prefix}Unexpected error ($statusCode).'),
    };
  }
}