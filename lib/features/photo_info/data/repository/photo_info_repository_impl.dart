import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/core/errors/failures.dart';
import 'package:webant_gallery/core/network/network_info.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/photo_info/data/datasource/photo_info_local_datasource.dart';
import 'package:webant_gallery/features/photo_info/data/datasource/photo_info_remote_datasource.dart';
import 'package:webant_gallery/features/photo_info/domain/repository/photo_info_repository.dart';

class PhotoInfoRepositoryImpl implements PhotoInfoRepository {
  final NetworkInfo networkInfo;
  final PhotoInfoRemoteDataSource remoteDataSource;
  final PhotoInfoLocalDataSource localDataSource;

  const PhotoInfoRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  ResultFuture<Photo> getPhotoInfo(int photoId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final localPhoto = await localDataSource.getPhotoInfo(photoId: photoId);
      if (localPhoto != null) return Right(localPhoto);

      final result = await remoteDataSource.fetchPhotoInfo(photoId: photoId);
      await localDataSource.savePhotoInfo(photo: result);

      return Right(result);
    } on DioException catch (e) {
      final error = convertDioErrorToFailure(e);
      return Left(ApiFailure.fromException(error));
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
