import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/anime.dart';
import '../entities/episode.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<Anime>>> getTrendingAnime();
  Future<Either<Failure, List<Anime>>> getPopularAnime();
  Future<Either<Failure, List<Anime>>> getRecentAnime();
  Future<Either<Failure, Anime>> getAnimeDetails(String animeId);
  Future<Either<Failure, List<Episode>>> getAnimeEpisodes(String animeId);
  Future<Either<Failure, List<Anime>>> searchAnime(String query);
  Future<Either<Failure, List<Anime>>> getAnimeByGenre(String genre);
  Future<Either<Failure, bool>> toggleFavorite(String animeId);
  Future<Either<Failure, List<Anime>>> getFavoriteAnime();
}
