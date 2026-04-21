import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/anime.dart';
import '../../domain/entities/episode.dart';
import '../../domain/repositories/anime_repository.dart';
import '../datasources/local/anime_local_data_source.dart';
import '../datasources/remote/anime_api_service.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeApiService apiService;
  final AnimeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AnimeRepositoryImpl({
    required this.apiService,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Anime>>> getTrendingAnime() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getTrendingAnime();
        await localDataSource.cacheTrendingAnime(result);
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final cached = await localDataSource.getCachedTrendingAnime();
        if (cached.isNotEmpty) {
          return Right(cached.map((model) => model.toEntity()).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getPopularAnime() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getPopularAnime();
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getRecentAnime() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getRecentAnime();
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Anime>> getAnimeDetails(String animeId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getAnimeDetails(animeId);
        await localDataSource.cacheAnimeDetails(result);
        final isFav = await localDataSource.isFavorite(animeId);
        return Right(result.toEntity().copyWith(isFavorite: isFav));
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final cached = await localDataSource.getCachedAnimeDetails(animeId);
        if (cached != null) {
          final isFav = await localDataSource.isFavorite(animeId);
          return Right(cached.toEntity().copyWith(isFavorite: isFav));
        }
        return const Left(NetworkFailure('No internet connection'));
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getAnimeEpisodes(
    String animeId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getAnimeEpisodes(animeId);
        await localDataSource.cacheEpisodes(animeId, result);
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final cached = await localDataSource.getCachedEpisodes(animeId);
        if (cached != null) {
          return Right(cached.map((model) => model.toEntity()).toList());
        }
        return const Left(NetworkFailure('No internet connection'));
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> searchAnime(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.searchAnime(query);
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getAnimeByGenre(String genre) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getAnimeByGenre(genre);
        return Right(result.map((model) => model.toEntity()).toList());
      } on DioException catch (e) {
        return Left(_handleDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String animeId) async {
    try {
      final isFav = await localDataSource.isFavorite(animeId);
      if (isFav) {
        await localDataSource.removeFromFavorites(animeId);
        return const Right(false);
      } else {
        final anime = await localDataSource.getCachedAnimeDetails(animeId);
        if (anime != null) {
          await localDataSource.addToFavorites(anime);
          return const Right(true);
        }
        return const Left(CacheFailure('Anime not found in cache'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getFavoriteAnime() async {
    try {
      final favorites = await localDataSource.getFavoriteAnime();
      return Right(favorites.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return const ServerFailure('Request cancelled');
      default:
        return const NetworkFailure('Network error occurred');
    }
  }
}
