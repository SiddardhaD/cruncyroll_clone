import 'package:cruncyroll/data/models/anime_model.dart';
import 'package:cruncyroll/data/models/episode_model.dart';
import 'package:hive/hive.dart';

abstract class AnimeLocalDataSource {
  Future<List<AnimeModel>> getCachedTrendingAnime();
  Future<void> cacheTrendingAnime(List<AnimeModel> anime);
  Future<List<AnimeModel>> getFavoriteAnime();
  Future<void> addToFavorites(AnimeModel anime);
  Future<void> removeFromFavorites(String animeId);
  Future<bool> isFavorite(String animeId);
  Future<void> cacheAnimeDetails(AnimeModel anime);
  Future<AnimeModel?> getCachedAnimeDetails(String animeId);
  Future<void> cacheEpisodes(String animeId, List<EpisodeModel> episodes);
  Future<List<EpisodeModel>?> getCachedEpisodes(String animeId);
}

class AnimeLocalDataSourceImpl implements AnimeLocalDataSource {
  static const String trendingBox = 'trending_anime';
  static const String favoritesBox = 'favorite_anime';
  static const String animeDetailsBox = 'anime_details';
  static const String episodesBox = 'episodes';

  @override
  Future<List<AnimeModel>> getCachedTrendingAnime() async {
    final box = await Hive.openBox<Map>(trendingBox);
    final cached = box.get('data');
    if (cached != null) {
      final list = (cached['items'] as List)
          .map((e) => AnimeModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return list;
    }
    return [];
  }

  @override
  Future<void> cacheTrendingAnime(List<AnimeModel> anime) async {
    final box = await Hive.openBox<Map>(trendingBox);
    await box.put('data', {
      'items': anime.map((e) => e.toJson()).toList(),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<List<AnimeModel>> getFavoriteAnime() async {
    final box = await Hive.openBox<Map>(favoritesBox);
    final favorites = box.values
        .map((e) => AnimeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return favorites;
  }

  @override
  Future<void> addToFavorites(AnimeModel anime) async {
    final box = await Hive.openBox<Map>(favoritesBox);
    await box.put(anime.id, anime.toJson());
  }

  @override
  Future<void> removeFromFavorites(String animeId) async {
    final box = await Hive.openBox<Map>(favoritesBox);
    await box.delete(animeId);
  }

  @override
  Future<bool> isFavorite(String animeId) async {
    final box = await Hive.openBox<Map>(favoritesBox);
    return box.containsKey(animeId);
  }

  @override
  Future<void> cacheAnimeDetails(AnimeModel anime) async {
    final box = await Hive.openBox<Map>(animeDetailsBox);
    await box.put(anime.id, anime.toJson());
  }

  @override
  Future<AnimeModel?> getCachedAnimeDetails(String animeId) async {
    final box = await Hive.openBox<Map>(animeDetailsBox);
    final cached = box.get(animeId);
    if (cached != null) {
      return AnimeModel.fromJson(Map<String, dynamic>.from(cached));
    }
    return null;
  }

  @override
  Future<void> cacheEpisodes(
    String animeId,
    List<EpisodeModel> episodes,
  ) async {
    final box = await Hive.openBox<Map>(episodesBox);
    await box.put(animeId, {
      'items': episodes.map((e) => e.toJson()).toList(),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<List<EpisodeModel>?> getCachedEpisodes(String animeId) async {
    final box = await Hive.openBox<Map>(episodesBox);
    final cached = box.get(animeId);
    if (cached != null) {
      final list = (cached['items'] as List)
          .map((e) => EpisodeModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return list;
    }
    return null;
  }
}
