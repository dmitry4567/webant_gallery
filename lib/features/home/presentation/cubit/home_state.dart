part of 'home_cubit.dart';



class HomeState extends Equatable {
  final List<Photo> photos;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoading;
  final String error;
  final PhotoType type;

  const HomeState({
    this.photos = const [],
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isLoading = false,
    this.error = '',
    required this.type,
  });

  factory HomeState.initial({required PhotoType type}) => HomeState(type: type);

  HomeState copyWith({
    List<Photo>? photos,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoading,
    String? error,
    PhotoType? type,
  }) {
    return HomeState(
      photos: photos ?? this.photos,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    photos,
    currentPage,
    hasReachedMax,
    isLoading,
    type,
  ];
}
