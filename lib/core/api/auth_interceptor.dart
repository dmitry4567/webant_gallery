import 'package:dio/dio.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final Dio dio;
  final TokenManager tokenManager;

  AuthInterceptor({required this.dio, required this.tokenManager});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = tokenManager.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != 401 || statusCode == null) {
      return handler.next(err);
    }

    final refreshToken = await tokenManager.getRefreshToken();

    final tokenRefreshDio = Dio(BaseOptions(baseUrl: AppConstants.baseIp));

    final response = await tokenRefreshDio.post(
      '/token',
      options: Options(),
      data: {
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
        "client_id": "123",
        "client_secret": "123",
      },
    );
    tokenRefreshDio.close();

    if (response.statusCode == null || response.statusCode! ~/ 100 != 2) {
      return handler.reject(err);
    }

    final body = response.data;

    final jwtToken = body['access_token'] as String;
    final newRefreshToken = body['refresh_token'] as String;

    await tokenManager.setAccessToken(jwtToken);
    await tokenManager.setRefreshToken(newRefreshToken);

    final retried = await dio.fetch(
      err.requestOptions..headers = {'Authorization': 'Bearer $jwtToken'},
    );

    if (retried.statusCode == null || retried.statusCode! ~/ 100 != 2) {
      return handler.reject(err);
    }

    return handler.resolve(retried);
  }
}
