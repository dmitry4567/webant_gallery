import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/api/api_client.dart';
import 'package:path/path.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';

abstract class AddPhotoRemoteDataSource {
  Future<String> uploadPhoto({required XFile file});
  Future<void> createPhoto({
    required String fileId,
    required String userId,
    required String name,
    required String description,
    required bool isNew,
    required bool isPopular,
  });
}

class AddPhotoRemoteDataSourceImpl implements AddPhotoRemoteDataSource {
  final ApiClient apiClient;

  AddPhotoRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String> uploadPhoto({required XFile file}) async {
    try {
      FormData formData = FormData.fromMap({
        'originalName': basename(file.path),
        'file': await MultipartFile.fromFile(
          file.path,
          filename: basename(file.path),
        ),
      });

      final result = await apiClient.post(
        '/files',
        data: formData,
        options: Options(),
      );

      if (result.statusCode != 201) {
        throw APIException(
          message: result.statusMessage ?? 'Failed to upload file',
          statusCode: result.statusCode!,
        );
      }

      return result.data['@id'];
    } on DioException catch (e) {
      throw convertDioErrorToFailure(e);
    }
  }

  @override
  Future<void> createPhoto({
    required String fileId,
    required String userId,
    required String name,
    required String description,
    required bool isNew,
    required bool isPopular,
  }) async {
    try {
      final result = await apiClient.post(
        '/photos',
        data: {
          "file": fileId,
          "user": "/users/$userId",
          "description": description,
          "name": name,
          "new": isNew,
          "popular": isPopular,
        },
        options: Options(),
      );

      if (result.statusCode != 201) {
        throw APIException(
          message: result.statusMessage ?? 'Failed to create photo',
          statusCode: result.statusCode!,
        );
      }
    } on DioException catch (e) {
      throw convertDioErrorToFailure(e);
    }
  }
}
