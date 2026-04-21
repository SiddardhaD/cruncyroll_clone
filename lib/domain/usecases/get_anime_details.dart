import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/anime.dart';
import '../repositories/anime_repository.dart';

class GetAnimeDetails {
  final AnimeRepository repository;

  GetAnimeDetails(this.repository);

  Future<Either<Failure, Anime>> call(String animeId) async {
    return await repository.getAnimeDetails(animeId);
  }
}
