import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/theme/palete.dart';

Future<void> iosDialog(BuildContext context) async {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Confirmation'),
      content: const Text(
        'Are you sure you want to exit?\nThe entered data will be lost',
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            context.router.back();
            Navigator.pop(context);
          },
          child: const Text('Exit', style: TextStyle(color: Color(0xff007AFF))),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xff007AFF)),
          ),
        ),
      ],
    ),
  );
}

Future<void> androidDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        backgroundColor: AppColors.white,
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to exit? The '),
              Text('entered data will be lost'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Exit', style: TextStyle(color: AppColors.main)),
            onPressed: () {
              context.router.back();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.main),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
