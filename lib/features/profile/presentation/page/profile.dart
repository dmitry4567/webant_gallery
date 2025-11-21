import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/theme/palete.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(color: AppColors.white),
    );
  }
}
