import 'package:cruncyroll/core/config/app_config.dart';
import 'package:cruncyroll/core/network/network_info.dart';
import 'package:cruncyroll/data/datasources/local/anime_local_data_source.dart';
import 'package:cruncyroll/data/datasources/remote/anime_api_service.dart';
import 'package:cruncyroll/data/repositories/anime_repository_impl.dart';
import 'package:cruncyroll/domain/repositories/anime_repository.dart';
import 'package:cruncyroll/domain/usecases/get_anime_details.dart';
import 'package:cruncyroll/domain/usecases/get_anime_episodes.dart';
import 'package:cruncyroll/domain/usecases/get_trending_anime.dart';
import 'package:cruncyroll/domain/usecases/search_anime.dart';
import 'package:cruncyroll/presentation/bloc/anime_details/anime_details_bloc.dart';
import 'package:cruncyroll/presentation/bloc/home/home_bloc.dart';
import 'package:cruncyroll/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      connectTimeout: Duration(seconds: AppConfig.instance.timeout),
      receiveTimeout: Duration(seconds: AppConfig.instance.timeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  if (AppConfig.instance.enableLogging) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton<AnimeApiService>(() => AnimeApiService(getIt()));

  getIt.registerLazySingleton<AnimeLocalDataSource>(
    () => AnimeLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      apiService: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetTrendingAnime(getIt()));
  getIt.registerLazySingleton(() => GetAnimeDetails(getIt()));
  getIt.registerLazySingleton(() => GetAnimeEpisodes(getIt()));
  getIt.registerLazySingleton(() => SearchAnime(getIt()));

  getIt.registerFactory(
    () => HomeBloc(getTrendingAnime: getIt(), animeRepository: getIt()),
  );

  getIt.registerFactory(
    () => AnimeDetailsBloc(
      getAnimeDetails: getIt(),
      getAnimeEpisodes: getIt(),
      animeRepository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => FavoritesBloc(getIt()),
  );
}
