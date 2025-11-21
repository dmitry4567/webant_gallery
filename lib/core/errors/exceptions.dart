import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:webant_gallery/core/errors/failures.dart';

class ServerException extends Equatable implements Failure {
  const ServerException({required this.message});

  @override
  final String message;

  @override
  List<Object?> get props => [message];
}

class APIException extends ServerException {
  const APIException({required super.message, required this.statusCode});

  final int statusCode;
}

class CacheException extends ServerException {
  const CacheException({required super.message});
}

class NoInternetException extends ServerException {
  const NoInternetException() : super(message: 'No internet connection');
}

APIException convertDioErrorToFailure(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return const APIException(message: 'Connection error', statusCode: 500);
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const APIException(message: 'Connection timeout', statusCode: 408);
    case DioExceptionType.badResponse:
      return APIException(
        message: _parseErrorMessage(e.response?.data),
        statusCode: e.response?.statusCode ?? 500,
      );
    case DioExceptionType.cancel:
      return const APIException(message: 'Request cancelled', statusCode: 499);
    case DioExceptionType.unknown:
      return APIException(message: "Unknown error", statusCode: 500);
    default:
      return APIException(
        message: 'Network error: ${e.message}',
        statusCode: 500,
      );
  }
}

String _parseErrorMessage(dynamic data) {
  if (data == null) return 'Unknown error';

  if (data is Map<String, dynamic>) {
    return data['hydra:description'] ?? 'Unknown server error';
  }

  if (data is String) {
    return data;
  }

  return 'Unknown error occurred';
}
