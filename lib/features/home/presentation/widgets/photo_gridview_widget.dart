import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/core/widgets/error_widget.dart';
import 'package:webant_gallery/core/widgets/loading_widget.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';
import 'package:webant_gallery/features/home/presentation/widgets/photo_card.dart';

class PhotosGridView extends StatefulWidget {
  const PhotosGridView({
    super.key,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.paddingHorizontal = 18,
    this.borederRadius = 10,
    this.bottomSpace = false,
  });

  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double paddingHorizontal;
  final double borederRadius;
  final bool bottomSpace;

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
              padding: EdgeInsets.symmetric(
                horizontal: widget.paddingHorizontal,
              ),
              child: CustomScrollView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverGrid.builder(
                    itemCount: state.photos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount,
                      crossAxisSpacing: widget.crossAxisSpacing,
                      mainAxisSpacing: widget.mainAxisSpacing,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return PhotoCard(
                        photo: state.photos[index],
                        borderRadius: widget.borederRadius,
                      );
                    },
                  ),
                  state.isLoading && state.photos.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            child: Center(child: LoadingWidget(showText: false,)),
                          ),
                        )
                      : SliverToBoxAdapter(child: SizedBox.shrink()),
                  !state.isLoading && state.hasReachedMax && widget.bottomSpace
                      ? SliverToBoxAdapter(
                          child: Container(
                            color: Colors.white,
                            height:
                                (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.width -
                                    244) /
                                2,
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
