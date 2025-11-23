import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/home/data/repository/photo_query_factory.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';


abstract class HomeRepository {
  ResultFuture<List<Photo>> getPhotos({
    required int page,
    required PhotoType photoType,
  });
}
