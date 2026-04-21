import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/anime.dart';
import '../repositories/anime_repository.dart';

class SearchAnime {
  final AnimeRepository repository;

  SearchAnime(this.repository);

  Future<Either<Failure, List<Anime>>> call(String query) async {
    if (query.isEmpty) {
      return const Left(ValidationFailure('Search query cannot be empty'));
    }
    return await repository.searchAnime(query);
  }
}
