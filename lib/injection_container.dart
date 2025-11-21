import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webant_gallery/core/api/api_client.dart';
import 'package:webant_gallery/core/api/auth_interceptor.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/network/network_info.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/core/utils/toast.dart';
import 'package:webant_gallery/features/add_photo/data/datasource/add_photo_remote_datasource.dart';
import 'package:webant_gallery/features/add_photo/data/repository/add_photo_repository_impl.dart';
import 'package:webant_gallery/features/add_photo/domain/repository/add_photo_repository.dart';
import 'package:webant_gallery/features/add_photo/domain/usecase/add_photo.dart';
import 'package:webant_gallery/features/add_photo/presentation/cubit/add_photo_cubit.dart';
import 'package:webant_gallery/features/home/data/datasource/home_remote_datasource.dart';
import 'package:webant_gallery/features/home/data/repository/home_repository_impl.dart';
import 'package:webant_gallery/features/home/domain/entity/photo.dart';
import 'package:webant_gallery/features/home/domain/repository/home_repository.dart';
import 'package:webant_gallery/features/home/domain/usecase/get_new_photo.dart';
import 'package:webant_gallery/features/home/presentation/cubit/factories/home_state_factory.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';
import 'package:webant_gallery/features/photo_info/data/datasource/photo_info_local_datasource.dart';
import 'package:webant_gallery/features/photo_info/data/datasource/photo_info_remote_datasource.dart';
import 'package:webant_gallery/features/photo_info/data/repository/photo_info_repository_impl.dart';
import 'package:webant_gallery/features/photo_info/domain/repository/photo_info_repository.dart';
import 'package:webant_gallery/features/photo_info/domain/usecase/get_photo_info.dart';
import 'package:webant_gallery/features/photo_info/presentation/cubit/photo_info_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();

  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
  sl.registerLazySingleton(() => ToastService());

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => ApiClient(dio: sl<Dio>()));

  await sl.allReady();

  sl.registerLazySingleton(
    () => TokenManager(
      sharedPreferences: sl<SharedPreferences>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  sl.registerLazySingleton(
    () => AuthInterceptor(dio: sl<Dio>(), tokenManager: sl()),
  );
  final apiClient = sl<ApiClient>();
  await apiClient.initialize(AppConstants.baseIp);

  sl<Dio>().interceptors.add(sl<AuthInterceptor>());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  home();
  photoInfo();
  addPhoto();
}

Future<void> home() async {
  // Datasource
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPhotos(repository: sl()));

  // Blocs
  sl.registerFactoryParam<HomeCubit, HomeStateFactory, void>(
    (factory, _) => HomeCubit(stateFactory: factory, getPhotos: sl()),
  );
}

Future<void> photoInfo() async {
  // Hive
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(FilePhotoAdapter());
  Hive.registerAdapter(UserAdapter());
  final boxCharacter = await Hive.openBox<Photo>("photo");
  // boxCharacter.clear();
  sl.registerSingleton<Box<Photo>>(boxCharacter, instanceName: "photo");
  // Datasource
  sl.registerLazySingleton<PhotoInfoRemoteDataSource>(
    () => PhotoInfoRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<PhotoInfoLocalDataSource>(
    () => PhotoInfoLocalDataSourceImpl(
      box: sl<Box<Photo>>(instanceName: "photo"),
    ),
  );

  // Repository
  sl.registerLazySingleton<PhotoInfoRepository>(
    () => PhotoInfoRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPhotoInfo(repository: sl()));

  // Blocs
  sl.registerLazySingleton(() => PhotoInfoCubit(getPhotoInfo: sl()));
}

Future<void> addPhoto() async {
  // Datasource
  sl.registerLazySingleton<AddPhotoRemoteDataSource>(
    () => AddPhotoRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AddPhotoRepository>(
    () => AddPhotoRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddPhoto(repository: sl()));

  // Blocs
  sl.registerLazySingleton(() => AddPhotoCubit(addPhoto: sl()));
}
