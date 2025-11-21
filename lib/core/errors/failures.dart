import 'package:equatable/equatable.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required this.statusCode});

  final int statusCode;

  ApiFailure.fromException(APIException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  CacheFailure.fromException(CacheException exception)
    : this(message: exception.message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super(message: 'No internet connection');
}
