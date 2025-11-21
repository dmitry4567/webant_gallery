import 'package:hive/hive.dart';

part 'photo.g.dart';

@HiveType(typeId: 1)
class Photo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final bool isNew;
  @HiveField(4)
  final bool isPopular;
  @HiveField(5)
  final FilePhoto filePhoto;
  @HiveField(6)
  final DateTime? createdAt;
  @HiveField(7)
  final User? user;

  const Photo({
    required this.id,
    this.name,
    this.description,
    required this.isNew,
    required this.isPopular,
    required this.filePhoto,
    this.createdAt,
    this.user,
  });
}

@HiveType(typeId: 2)
class FilePhoto {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String path;

  const FilePhoto({required this.id, required this.path});
}

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String displayName;

  const User({required this.id, required this.displayName});
}
