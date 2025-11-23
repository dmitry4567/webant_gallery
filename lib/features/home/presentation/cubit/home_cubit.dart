import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/features/home/data/repository/photo_query_factory.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/home/domain/usecase/get_new_photo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPhotos getPhotos;
  final PhotoType photoType;

  late ScrollController scrollController;

  int numberPage = 1;

  HomeCubit({required this.getPhotos, required this.photoType})
    : super(HomeState.initial());

  void initController(ScrollController controller) {
    scrollController = controller;

    scrollController.addListener(_onScroll);
  }

  Future<void> getPhoto({bool isRefresh = false}) async {
    if (isRefresh) numberPage = 1;

    emit(state.copyWith(isLoading: true, error: ""));

    final data = await getPhotos(
      GetPhotosParams(page: numberPage, photoType: photoType),
    );

    data.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error.message));
      },
      (result) {
        emit(
          state.copyWith(
            photos: isRefresh
                ? List.of(result)
                : (List.of(state.photos)..addAll(result)),
            currentPage: numberPage,
            hasReachedMax: result.isEmpty,
            isLoading: false,
          ),
        );
      },
    );
  }

  void _onScroll() {
    if (_shouldLoadMore()) {
      numberPage++;

      getPhoto();
    }
  }

  bool _shouldLoadMore() {
    if (state.isLoading || state.hasReachedMax) return false;

    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent > 0) {
      final currentPosition = scrollController.offset;
      final maxPosition = scrollController.position.maxScrollExtent;

      return currentPosition >= maxPosition;
    }

    return false;
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    return super.close();
  }
}
