import 'package:webant_gallery/core/usecase/usecase.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/data/repository/photo_query_factory.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/home/domain/repository/home_repository.dart';


class GetPhotos implements UseCaseWithParams<List<Photo>, GetPhotosParams> {
  final HomeRepository repository;

  const GetPhotos({required this.repository});

  @override
  ResultFuture<List<Photo>> call(GetPhotosParams params) async {
    return await repository.getPhotos(
      page: params.page,
      photoType: params.photoType,
    );
  }
}

class GetPhotosParams {
  final int page;
  final PhotoType photoType;

  const GetPhotosParams({required this.page, required this.photoType});
}
