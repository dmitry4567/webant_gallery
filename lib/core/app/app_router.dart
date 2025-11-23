import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/app/bottom_nav_bar.dart';
import 'package:webant_gallery/features/all_photos/presentation/page/all_photos.dart';
import 'package:webant_gallery/features/add_photo/presentation/page/add_photo.dart';
import 'package:webant_gallery/features/home/presentation/page/home.dart';
import 'package:webant_gallery/features/photo_info/presentation/page/photo_info.dart';
import 'package:webant_gallery/features/profile/presentation/page/profile.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: DashboardRoute.page,
      children: [
        AutoRoute(initial: true, path: 'home', page: HomeRoute.page),
        AutoRoute(
          path: 'all_photos',
          page: EmptyShellRoute(''),
          children: [
            AutoRoute(path: '', page: AllPhotosRoute.page),
            AutoRoute(path: 'add_photo/new_photo', page: NewPhotoRoute.page),
          ],
        ),

        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    AutoRoute(path: '/photo_info', page: PhotoInfoRoute.page),
  ];
}
