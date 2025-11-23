part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Photo> photos;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoading;
  final String error;

  const HomeState({
    required this.photos,
    required this.currentPage,
    required this.hasReachedMax,
    required this.isLoading,
    required this.error,
  });

  const HomeState.initial()
    : this(
        photos: const [],
        currentPage: 1,
        hasReachedMax: false,
        isLoading: false,
        error: '',
      );

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
    );
  }

  @override
  List<Object?> get props => [photos, currentPage, hasReachedMax, isLoading];
}
