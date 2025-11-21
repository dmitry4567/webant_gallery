import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  Future<void> initialize(String baseUrl) async {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/ld+json',
      }
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    required Options options,
  }) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    required Options options,
  }) async {
    return dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) async {
    return dio.put(path, data: data, options: options);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }
}