import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/features/home/data/repository/photo_query_factory.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';
import 'package:webant_gallery/features/home/presentation/widgets/photo_gridview_widget.dart';
import 'package:webant_gallery/injection_container.dart' as di;

@RoutePage()
class AllPhotosPage extends StatelessWidget {
  const AllPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<HomeCubit>(param1: PhotoType.all),
      child: Scaffold(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              color: AppColors.greyLight,
              child: Center(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state.photos.isNotEmpty) {
                      return CachedNetworkImage(
                        imageUrl:
                            '${AppConstants.baseIp}/get_file/${state.photos[0].filePhoto.path}',
                        httpHeaders: {
                          "Authorization":
                              "Bearer ${di.sl<TokenManager>().getAccessToken()}",
                        },
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) {
                          return GestureDetector(
                            onTap: () {
                              context.router.push(
                                PhotoInfoRoute(photoId: state.photos[0].id),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        progressIndicatorBuilder:
                            (context, _, loadingProgress) {
                              return Container(color: AppColors.greyLight);
                            },
                        errorWidget: (context, _, stackTrace) {
                          return Container(color: AppColors.errorRed);
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.white,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Text("Select photo:", style: AppTextStyle.p),
                  SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: PhotosGridView(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                paddingHorizontal: 16,
                borederRadius: 0,
                bottomSpace: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
