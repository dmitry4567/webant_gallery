import 'package:webant_gallery/core/utils/typedef.dart';

enum PhotoType { newPhoto, popularPhoto, all }

abstract class PhotoQueryFactory {
  DataMap get query;

  factory PhotoQueryFactory(PhotoType photoType) {
    switch (photoType) {
      case PhotoType.all:
        return AllPhotosQuery();
      case PhotoType.newPhoto:
        return NewPhotosQuery();
      case PhotoType.popularPhoto:
        return PopularPhotosQuery();
    }
  }
}

class AllPhotosQuery implements PhotoQueryFactory {
  @override
  DataMap get query => {};
}

class NewPhotosQuery implements PhotoQueryFactory {
  @override
  DataMap get query => {'new': true};
}

class PopularPhotosQuery implements PhotoQueryFactory {
  @override
  DataMap get query => {'popular': true};
}