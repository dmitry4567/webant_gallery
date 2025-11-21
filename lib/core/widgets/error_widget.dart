import 'package:flutter/material.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';

class ErrorWidget extends StatelessWidget {
  final String error;

  const ErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MyIcons.logo, color: AppColors.greyLight, size: 74),
          SizedBox(height: 8),
          Text("Sorry!", style: AppTextStyle.p.copyWith(color: AppColors.grey)),
          SizedBox(height: 8),
          Text(
            error,
            style: AppTextStyle.caption.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
