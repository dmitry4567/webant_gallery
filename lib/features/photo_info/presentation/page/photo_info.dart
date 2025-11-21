import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/core/utils/toast.dart';
import 'package:webant_gallery/core/widgets/error_widget.dart';
import 'package:webant_gallery/core/widgets/loading_widget.dart';
import 'package:webant_gallery/features/photo_info/presentation/cubit/photo_info_cubit.dart';
import 'package:webant_gallery/features/photo_info/presentation/widgets/zoom_image.dart';
import 'package:intl/intl.dart';
import 'package:webant_gallery/injection_container.dart' as di;

@RoutePage()
class PhotoInfoPage extends StatefulWidget {
  const PhotoInfoPage({super.key, required this.photoId});

  final int photoId;

  @override
  State<PhotoInfoPage> createState() => _PhotoInfoPageState();
}

class _PhotoInfoPageState extends State<PhotoInfoPage> {
  final DateFormat format = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    super.initState();

    di.sl<ToastService>().init(context);
    context.read<PhotoInfoCubit>().loadPhotoInfo(photoId: widget.photoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.white10,
                        onTap: () {
                          context.router.back();
                        },
                        child: Container(
                          height: 44,
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          child: Row(
                            children: [
                              Icon(
                                MyIcons.back,
                                color: AppColors.blue,
                                size: 19,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.w400,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            "Edit",
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
            ),
            Expanded(
              child: BlocConsumer<PhotoInfoCubit, PhotoInfoState>(
                listener: (context, state) {
                  if (state.error != '') {
                    di.sl<ToastService>().showErrorToast(state.error);
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return LoadingWidget();
                  } else if (state.error.isNotEmpty) {
                    return ErrorWidget(error: state.error);
                  } else if (state.photo != null) {
                    final data = state.photo!;

                    return SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          ZoomableImage(imageUrl: data.filePhoto.path),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 18),
                                Text(
                                  data.name ?? "",
                                  style: AppTextStyle.h2.copyWith(height: 1),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.user!.displayName,
                                      style: AppTextStyle.p.copyWith(
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    Text(
                                      format.format(data.createdAt!).toString(),
                                      style: AppTextStyle.caption.copyWith(
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  data.description ?? "",
                                  style: AppTextStyle.p,
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
