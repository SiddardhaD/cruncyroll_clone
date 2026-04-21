import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/episode.dart';
import '../repositories/anime_repository.dart';

class GetAnimeEpisodes {
  final AnimeRepository repository;

  GetAnimeEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> call(String animeId) async {
    return await repository.getAnimeEpisodes(animeId);
  }
}
