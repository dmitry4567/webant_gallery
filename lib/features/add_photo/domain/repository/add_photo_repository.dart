import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/utils/typedef.dart';

abstract class AddPhotoRepository {
  ResultVoid uploadPhoto({
    required XFile file,
    required String name,
    required String description,
    required bool isNew,
    required bool isPopular,
  });
}
