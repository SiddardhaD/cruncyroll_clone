import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/anime_details/anime_details_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  AppConfig.init(environment: Environment.development);

  await setupDependencyInjection();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const CrunchyrollApp());
}

class CrunchyrollApp extends StatelessWidget {
  const CrunchyrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<HomeBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<AnimeDetailsBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<FavoritesBloc>(),
            ),
          ],
          child: MaterialApp(
            title: 'Crunchyroll',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            home: const LoginPage(),
          ),
        );
      },
    );
  }
}
