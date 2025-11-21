import 'package:webant_gallery/core/usecase/usecase.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/photo_info/domain/repository/photo_info_repository.dart';

class GetPhotoInfo implements UseCaseWithParams<Photo, GetPhotoInfoParams> {
  final PhotoInfoRepository repository;

  const GetPhotoInfo({required this.repository});

  @override
  ResultFuture<Photo> call(GetPhotoInfoParams params) async {
    return await repository.getPhotoInfo(params.photoId);
  }
}

class GetPhotoInfoParams {
  final int photoId;

  const GetPhotoInfoParams({required this.photoId});
}
