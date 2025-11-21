// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddPhotoPage]
class AddPhotoRoute extends PageRouteInfo<void> {
  const AddPhotoRoute({List<PageRouteInfo>? children})
      : super(
          AddPhotoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddPhotoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddPhotoPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [NewPhotoPage]
class NewPhotoRoute extends PageRouteInfo<NewPhotoRouteArgs> {
  NewPhotoRoute({
    Key? key,
    required XFile file,
    List<PageRouteInfo>? children,
  }) : super(
          NewPhotoRoute.name,
          args: NewPhotoRouteArgs(
            key: key,
            file: file,
          ),
          initialChildren: children,
        );

  static const String name = 'NewPhotoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewPhotoRouteArgs>();
      return NewPhotoPage(
        key: args.key,
        file: args.file,
      );
    },
  );
}

class NewPhotoRouteArgs {
  const NewPhotoRouteArgs({
    this.key,
    required this.file,
  });

  final Key? key;

  final XFile file;

  @override
  String toString() {
    return 'NewPhotoRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [PhotoInfoPage]
class PhotoInfoRoute extends PageRouteInfo<PhotoInfoRouteArgs> {
  PhotoInfoRoute({
    Key? key,
    required int photoId,
    List<PageRouteInfo>? children,
  }) : super(
          PhotoInfoRoute.name,
          args: PhotoInfoRouteArgs(
            key: key,
            photoId: photoId,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotoInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoInfoRouteArgs>();
      return PhotoInfoPage(
        key: args.key,
        photoId: args.photoId,
      );
    },
  );
}

class PhotoInfoRouteArgs {
  const PhotoInfoRouteArgs({
    this.key,
    required this.photoId,
  });

  final Key? key;

  final int photoId;

  @override
  String toString() {
    return 'PhotoInfoRouteArgs{key: $key, photoId: $photoId}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}
