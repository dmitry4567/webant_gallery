import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/constants/app_constants.dart';
import 'package:webant_gallery/core/services/token_manager.dart';
import 'package:webant_gallery/features/add_photo/presentation/cubit/add_photo_cubit.dart';
import 'package:webant_gallery/features/photo_info/presentation/cubit/photo_info_cubit.dart';
import 'package:webant_gallery/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<PhotoInfoCubit>()),
        BlocProvider(create: (context) => di.sl<AddPhotoCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    login();
  }

  Future<void> login() async {
    final dio = Dio(BaseOptions(baseUrl: AppConstants.baseIp));

    final response = await dio.post(
      '/token',
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
      data: {
        "grant_type": "password",
        "username": "d@gmail.com",
        "password": "1234",
        "client_id": "123",
        "client_secret": "123",
      },
    );

    if (response.statusCode == 200) {
      await di.sl<TokenManager>().setAccessToken(response.data['access_token']);
      await di.sl<TokenManager>().setRefreshToken(
        response.data['refresh_token'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: di.sl<AppRouter>().config(),
      title: 'Gallery',
    );
  }
}
