import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';

class ToastService {
  final FToast _fToast = FToast();

  ToastService();

  void init(BuildContext context) {
    _fToast.init(context);
  }

  void showErrorToast(String text) async {
    await Future.delayed(Duration(milliseconds: 0));
    _fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.errorRed,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MyIcons.info, color: AppColors.white, size: 20),
            SizedBox(width: 8.0),
            Text(
              text,
              style: AppTextStyle.h3.copyWith(color: AppColors.white),
              maxLines: 2,
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void showInfoToast(String text) async {
    await Future.delayed(Duration(milliseconds: 0));
    _fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.infoToast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MyIcons.info, color: AppColors.white, size: 20),
            SizedBox(width: 8.0),
            Text(
              text,
              style: AppTextStyle.h3.copyWith(color: AppColors.white),
              maxLines: 2,
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
