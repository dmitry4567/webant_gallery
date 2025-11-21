import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webant_gallery/core/utils/toast.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/photo_info/domain/usecase/get_photo_info.dart';

part 'photo_info_state.dart';

class PhotoInfoCubit extends Cubit<PhotoInfoState> {
  final GetPhotoInfo getPhotoInfo;

  PhotoInfoCubit({required this.getPhotoInfo})
    : super(PhotoInfoState.initial());

  Future<void> loadPhotoInfo({required int photoId}) async {
    emit(state.copyWith(isLoading: true));

    final result = await getPhotoInfo(GetPhotoInfoParams(photoId: photoId));

    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error.message));
      },
      (data) {
        emit(state.copyWith(isLoading: false, error: '', photo: data));
      },
    );
  }
}
