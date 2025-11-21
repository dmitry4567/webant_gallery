import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/core/errors/failures.dart';
import 'package:webant_gallery/core/network/network_info.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/add_photo/data/datasource/add_photo_remote_datasource.dart';
import 'package:webant_gallery/features/add_photo/domain/repository/add_photo_repository.dart';

class AddPhotoRepositoryImpl implements AddPhotoRepository {
  final NetworkInfo networkInfo;
  final AddPhotoRemoteDataSource remoteDataSource;

  AddPhotoRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  ResultVoid uploadPhoto({
    required XFile file,
    required String name,
    required String description,
    required bool isNew,
    required bool isPopular,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure());
      }

      final fileId = await remoteDataSource.uploadPhoto(file: file);

      await remoteDataSource.createPhoto(
        fileId: fileId,
        userId: "110",
        name: name,
        description: description,
        isNew: isNew,
        isPopular: isPopular,
      );

      return Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    } on DioException catch (e) {
      return Left(ApiFailure.fromException(convertDioErrorToFailure(e)));
    }
  }
}
