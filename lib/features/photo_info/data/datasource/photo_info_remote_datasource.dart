import 'package:dio/dio.dart';
import 'package:webant_gallery/core/api/api_client.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/features/home/data/model/photo_model.dart';

abstract class PhotoInfoRemoteDataSource {
  Future<PhotoModel> fetchPhotoInfo({required int photoId});
}

class PhotoInfoRemoteDataSourceImpl implements PhotoInfoRemoteDataSource {
  final ApiClient apiClient;

  const PhotoInfoRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<PhotoModel> fetchPhotoInfo({required int photoId}) async {
    final response = await apiClient.get(
      '${AppConstants.baseIp}/photos/$photoId',
      options: Options(),
    );

    if (response.statusCode != 200) {
      throw APIException(
        message: response.statusMessage!,
        statusCode: response.statusCode!,
      );
    }
    return PhotoModel.fromJson(response.data);
  }
}
