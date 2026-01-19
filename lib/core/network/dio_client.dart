// lib/core/network/api_service.dart
import 'package:dio/dio.dart';
import '../../config/environment.dart';
import 'network_exceptions.dart';


class ApiService {
  late final Dio _dio;

  /// Constructor
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Optional: Logging for requests and responses
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
    ));
  }

  /// GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      throw NetworkException(e.message.toString());
    }
  }

  /// POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      throw NetworkException(e.message.toString());
    }
  }

  /// PUT request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioError catch (e) {
      throw NetworkException(e.message.toString());
    }
  }

  /// DELETE request
  Future<Response> delete(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      throw NetworkException(e.message.toString());
    }
  }
}
