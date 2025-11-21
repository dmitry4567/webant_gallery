import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/usecase/usecase.dart';
import 'package:webant_gallery/core/utils/typedef.dart';
import 'package:webant_gallery/features/add_photo/domain/repository/add_photo_repository.dart';

class AddPhoto implements UseCaseWithParams<void, AddPhotoParams> {
  final AddPhotoRepository repository;

  AddPhoto({required this.repository});

  @override
  ResultVoid call(AddPhotoParams params) => repository.uploadPhoto(
    file: params.file,
    name: params.name,
    description: params.description,
    isNew: params.isNew,
    isPopular: params.isPopular,
  );
}

class AddPhotoParams {
  final XFile file;
  final String name;
  final String description;
  final bool isNew;
  final bool isPopular;

  AddPhotoParams({
    required this.file,
    required this.name,
    required this.description,
    required this.isNew,
    required this.isPopular,
  });
}
