part of 'photo_info_cubit.dart';

class PhotoInfoState extends Equatable {
  final Photo? photo;
  final bool isLoading;
  final String error;
  
  const PhotoInfoState({
    required this.photo,
    required this.isLoading,
    required this.error,
  });

  factory PhotoInfoState.initial() {
    return PhotoInfoState(
      photo: null,
      isLoading: false,
      error: "",
    );
  }

  PhotoInfoState copyWith({
    Photo? photo,
    bool? isLoading,
    String? error,
  }) {
    return PhotoInfoState(
      photo: photo ?? this.photo,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [photo, isLoading, error];
}