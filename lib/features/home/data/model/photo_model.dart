import 'package:webant_gallery/features/home/domain/entity/photo.dart';

class PhotoModel extends Photo {
  const PhotoModel({
    required super.id,
    super.name,
    super.description,
    required super.isNew,
    required super.isPopular,
    required super.filePhoto,
    super.user,
    super.createdAt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isNew: json['new'] as bool,
      isPopular: json['popular'] as bool,
      filePhoto: FilePhotoModel.fromJson(json['file']),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      createdAt: json['dateCreate'] != null
          ? DateTime.parse(json['dateCreate'] as String)
          : null,
    );
  }
}

class FilePhotoModel extends FilePhoto {
  const FilePhotoModel({required super.id, required super.path});

  factory FilePhotoModel.fromJson(Map<String, dynamic> json) {
    return FilePhotoModel(id: json['id'] as int, path: json['path'] as String);
  }
}

class UserModel extends User {
  UserModel({required super.id, required super.displayName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      displayName: json['displayName'] as String,
    );
  }
}
