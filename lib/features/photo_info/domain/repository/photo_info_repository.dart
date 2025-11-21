import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';

abstract class PhotoInfoRepository {
  ResultFuture<Photo> getPhotoInfo(int photoId);
}