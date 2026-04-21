import 'package:cruncyroll/data/models/anime_model.dart';
import 'package:cruncyroll/data/models/episode_model.dart';
import 'package:dio/dio.dart';
import 'mock_anime_data.dart';

class AnimeApiService {
  final Dio _dio;

  AnimeApiService(this._dio);

  // Using mock data instead of real API calls
  Future<List<AnimeModel>> getTrendingAnime() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final List<dynamic> data = MockAnimeData.trendingAnime;
      return data.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> getPopularAnime() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final List<dynamic> data = MockAnimeData.popularAnime;
      return data.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> getRecentAnime() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final List<dynamic> data = MockAnimeData.recentAnime;
      return data.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<AnimeModel> getAnimeDetails(String animeId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final data = MockAnimeData.getAnimeById(animeId);
      if (data == null) {
        throw DioException(
          requestOptions: RequestOptions(path: '/anime/$animeId'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/anime/$animeId'),
            statusCode: 404,
          ),
        );
      }
      return AnimeModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EpisodeModel>> getAnimeEpisodes(String animeId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final episodes = MockAnimeData.getEpisodes()[animeId] ?? [];
      return episodes.map((json) => EpisodeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> searchAnime(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final allAnime = MockAnimeData.getAllAnime();
      final filtered = allAnime.where((anime) {
        final title = anime['title'].toString().toLowerCase();
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery);
      }).toList();

      return filtered.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> getAnimeByGenre(String genre) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final allAnime = MockAnimeData.getAllAnime();
      final filtered = allAnime.where((anime) {
        final genres = anime['genres'] as List;
        return genres.any(
          (g) => g.toString().toLowerCase() == genre.toLowerCase(),
        );
      }).toList();

      return filtered.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Uncomment this section when you want to switch to real API
  /*
  Future<List<AnimeModel>> getTrendingAnime() async {
    try {
      final response = await _dio.get('/anime/trending');
      final List<dynamic> data = response.data;
      return data.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<AnimeModel>> getPopularAnime() async {
    try {
      final response = await _dio.get('/anime/popular');
      final List<dynamic> data = response.data;
      return data.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  // ... add other real API methods here when ready
  */
}
