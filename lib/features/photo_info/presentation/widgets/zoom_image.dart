import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/injection_container.dart' as di;
import 'package:widget_zoom/widget_zoom.dart';

class ZoomableImage extends StatelessWidget {
  final String imageUrl;

  const ZoomableImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return WidgetZoom(
      heroAnimationTag: 'tag',
      zoomWidget: CachedNetworkImage(
        imageUrl: '${AppConstants.baseIp}/get_file/$imageUrl',
        httpHeaders: {
          "Authorization": "Bearer ${di.sl<TokenManager>().getAccessToken()}",
        },
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, child, loadingProgress) {
          return Container(color: AppColors.greyLight);
        },
        errorWidget: (context, error, stackTrace) {
          return Container(color: AppColors.errorRed);
        },
      ),
    );
  }
}
