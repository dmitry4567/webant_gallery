import 'package:dio/dio.dart';
import 'package:webant_gallery/core/api/api_client.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/data/model/photo_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotoModel>> getPhotos({
    required int page,
    required DataMap query,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PhotoModel>> getPhotos({
    required int page,
    required DataMap query,
  }) async {
    DataMap queryParams = {};

    queryParams['page'] = page;
    queryParams['itemsPerPage'] = 10;
    queryParams['order[id]'] = 'desc';

    queryParams.addAll(query);

    final response = await apiClient.get(
      '${AppConstants.baseIp}/photos',
      options: Options(),
      queryParameters: queryParams,
    );

    if (response.statusCode != 200) {
      throw APIException(
        message: response.statusMessage!,
        statusCode: response.statusCode!,
      );
    }

    return response.data["hydra:member"]
        .map<PhotoModel>((photo) => PhotoModel.fromJson(photo))
        .toList();
  }
}
