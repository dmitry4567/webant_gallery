import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/injection_container.dart' as di;

class ZoomableImage extends StatefulWidget {
  final String imageUrl;

  const ZoomableImage({super.key, required this.imageUrl});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        _previousScale = _scale;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = _previousScale * details.scale;
        });
      },
      onScaleEnd: (details) {
        setState(() {
          _scale = 1;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: CachedNetworkImage(
          imageUrl: '${AppConstants.baseIp}/get_file/${widget.imageUrl}',
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
      ),
    );
  }
}
