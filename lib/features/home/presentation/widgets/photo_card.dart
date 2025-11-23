import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/injection_container.dart' as di;

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, required this.photo, this.borderRadius = 10});

  final Photo photo;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: '${AppConstants.baseIp}/get_file/${photo.filePhoto.path}',
        httpHeaders: {
          "Authorization": "Bearer ${di.sl<TokenManager>().getAccessToken()}",
        },
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) {
          return GestureDetector(
            onTap: () {
              context.router.push(PhotoInfoRoute(photoId: photo.id));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          );
        },
        progressIndicatorBuilder: (context, _, loadingProgress) {
          return Container(color: AppColors.greyLight);
        },
        errorWidget: (context, _, stackTrace) {
          return Container(color: AppColors.errorRed);
        },
      ),
    );
  }
}
