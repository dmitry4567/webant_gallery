import 'package:hive/hive.dart';
import 'package:webant_gallery/core/errors/exceptions.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';

abstract class PhotoInfoLocalDataSource {
  Future<Photo?> getPhotoInfo({required int photoId});
  Future<void> savePhotoInfo({required Photo photo});
}

class PhotoInfoLocalDataSourceImpl implements PhotoInfoLocalDataSource {
  final Box<Photo> box;

  PhotoInfoLocalDataSourceImpl({required this.box});

  @override
  Future<Photo?> getPhotoInfo({required int photoId}) async {
    try {
      return box.get(photoId);
    } catch (e) {
      throw CacheException(message: 'Failed to get photo');
    }
  }

  @override
  Future<void> savePhotoInfo({required Photo photo}) async {
    try {
      await box.put(photo.id, photo);
    } catch (e) {
      throw CacheException(message: 'Failed to save photo');
    }
  }
}
