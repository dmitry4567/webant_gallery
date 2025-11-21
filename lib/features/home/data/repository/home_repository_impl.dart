import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:webant_gallery/core/constants/enums.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/core/errors/failures.dart';
import 'package:webant_gallery/core/network/network_info.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/data/datasource/home_remote_datasource.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/home/domain/repository/home_repository.dart';


class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  ResultFuture<List<Photo>> getPhotos({
    required int page,
    required PhotoType photoType,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final result = await remoteDataSource.getPhotos(
        page: page,
        photoType: photoType,
      );

      return Right(result);
    } on DioException catch (e) {
      final error = convertDioErrorToFailure(e);
      return Left(ApiFailure.fromException(error));
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
