import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/features/add_photo/domain/usecase/add_photo.dart';

part 'add_photo_state.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  final AddPhoto addPhoto;

  AddPhotoCubit({required this.addPhoto}) : super(AddPhotoState.initial());

  void setPhoto({required XFile file}) {
    emit(state.copyWith(file: file));
  }

  void setName(String value) {
    emit(state.copyWith(name: value));
  }

  void setDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void setIsNew(bool value) {
    emit(state.copyWith(isNew: value));
  }

  void setIsPopular(bool value) {
    emit(state.copyWith(isPopular: value));
  }

  void clearError() {
    emit(state.copyWith(error: ''));
  }

  void uploadPhoto() async {
    emit(state.copyWith(isLoading: true, error: ""));

    final data = await addPhoto(
      AddPhotoParams(
        file: state.file!,
        name: state.name,
        description: state.description,
        isNew: state.isNew,
        isPopular: state.isPopular,
      ),
    );

    data.fold(
      (e) {
        emit(state.copyWith(isLoading: false, error: e.message));
      },
      (_) {
        emit(state.copyWith(isLoading: false, isUploaded: true));
      },
    );
  }
}
