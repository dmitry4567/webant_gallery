import 'package:webant_gallery/core/utils/typedef.dart';

abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
