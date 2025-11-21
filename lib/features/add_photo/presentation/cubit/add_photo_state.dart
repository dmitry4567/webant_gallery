part of 'add_photo_cubit.dart';

class AddPhotoState extends Equatable {
  final XFile? file;
  final String name;
  final String description;
  final bool isNew;
  final bool isPopular;
  final bool isLoading;
  final String error;
  final bool isUploaded;

  const AddPhotoState({
    required this.file,
    required this.name,
    required this.description,
    required this.isNew,
    required this.isPopular,
    required this.isLoading,
    required this.error,
    required this.isUploaded,
  });

  const AddPhotoState.initial()
    : this(
        file: null,
        name: '',
        description: '',
        isNew: false,
        isPopular: false,
        isLoading: false,
        error: '',
        isUploaded: false,
      );

  AddPhotoState copyWith({
    XFile? file,
    String? name,
    String? description,
    bool? isNew,
    bool? isPopular,
    bool? isLoading,
    String? error,
    bool? isUploaded,
  }) {
    return AddPhotoState(
      file: file ?? this.file,
      name: name ?? this.name,
      description: description ?? this.description,
      isNew: isNew ?? this.isNew,
      isPopular: isPopular ?? this.isPopular,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  @override
  List<Object?> get props => [
    file,
    name,
    description,
    isNew,
    isPopular,
    isLoading,
    error,
  ];
}
