import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/core/widgets/error_widget.dart';
import 'package:webant_gallery/core/widgets/loading_widget.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';
import 'package:webant_gallery/injection_container.dart' as di;

class PhotosGridView extends StatefulWidget {
  const PhotosGridView({super.key});

  @override
  State<PhotosGridView> createState() => _PhotosGridViewState();
}

class _PhotosGridViewState extends State<PhotosGridView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>()
      ..initController(controller)
      ..getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().getPhoto(isRefresh: true),
      backgroundColor: AppColors.white,
      color: AppColors.main,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.photos.isNotEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: CustomScrollView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverGrid.builder(
                    itemCount: state.photos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${AppConstants.baseIp}/get_file/${state.photos[index].filePhoto.path}',
                          httpHeaders: {
                            "Authorization":
                                "Bearer ${di.sl<TokenManager>().getAccessToken()}",
                          },
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return GestureDetector(
                              onTap: () {
                                context.router.push(
                                  PhotoInfoRoute(
                                    photoId: state.photos[index].id,
                                  ),
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
                        ),
                      );
                    },
                  ),
                  state.isLoading && state.photos.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(child: SizedBox.shrink()),
                ],
              ),
            );
          } else if (state.error.isNotEmpty) {
            return ErrorWidget(error: state.error);
          } else if (state.isLoading) {
            return LoadingWidget();
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
