import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';

@RoutePage()
class AddPhotoPage extends StatelessWidget {
  const AddPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black,
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          
          final file = await picker.pickImage(source: ImageSource.gallery);

          if (file != null) {
            if (!context.mounted) return;
            context.router.push(NewPhotoRoute(file: file));
          }
        },
        child: const Icon(MyIcons.add, color: AppColors.white),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "All photos",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white10,
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.main,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
