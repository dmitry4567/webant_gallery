import 'package:flutter/material.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/palete.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.showText = true});

  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 1, color: AppColors.grey),
          showText
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Loading...',
                      style: AppTextStyle.p.copyWith(color: AppColors.grey),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
