import 'package:dartz/dartz.dart';
import 'package:webant_gallery/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
typedef ResultBool = ResultFuture<bool>;

typedef DataMap = Map<String, dynamic>;
