import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'constants.dart';

class DioHelper {
  static late Dio dio;

  /// Initializes the Dio instance with default configurations.
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10), // Connection timeout
        receiveTimeout: const Duration(seconds: 15), // Response timeout
      ),
    );
  }

  /// Sets custom headers for Dio requests.
  void setHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }

  void resetHeaders() {
    // Preserve the Authorization header if it exists
    final authorization = dio.options.headers['Authorization'];

    dio.options.headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
    };

    // Reapply the Authorization header if it was set
    if (authorization != null) {
      dio.options.headers['Authorization'] = authorization;
    }
  }

  /// Performs a GET request.
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      resetHeaders(); // Ensure default headers are applied
      return await dio.get(
        url,
        queryParameters: query,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Performs a POST request.
  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool isFormData = false,
  }) async {
    try {
      resetHeaders(); // Ensure default headers are applied

      if (isFormData) {
        dio.options.headers['Content-Type'] = 'multipart/form-data';
        return await dio.post(
          url,
          queryParameters: query,
          data: FormData.fromMap(data),
        );
      } else {
        dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
        return await dio.post(
          url,
          queryParameters: query,
          data: data,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Sets the Bearer token for authorization
  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clears any existing token
  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Performs a DELETE request.
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      resetHeaders(); // Ensure default headers are applied

      return await dio.delete(
        url,
        queryParameters: query,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Handles Dio-specific errors and logs them for debugging.
  void _handleDioError(DioException e) {
    // Log the error (you can replace this with a logging library)
    if (kDebugMode) {
      print('Dio Error: ${e.message}');
    }
    if (e.response != null) {
      if (kDebugMode) {
        print('Response Data: ${e.response?.data}');
        print('Response Status Code: ${e.response?.statusCode}');
      }
    }
  }
}
