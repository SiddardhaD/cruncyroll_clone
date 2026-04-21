import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/anime.dart';
import '../repositories/anime_repository.dart';

class GetTrendingAnime {
  final AnimeRepository repository;

  GetTrendingAnime(this.repository);

  Future<Either<Failure, List<Anime>>> call() async {
    return await repository.getTrendingAnime();
  }
}
