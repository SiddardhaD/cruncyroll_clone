import 'package:equatable/equatable.dart';
import '../../../domain/entities/anime.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Anime> trendingAnime;
  final List<Anime> popularAnime;
  final List<Anime> recentAnime;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.trendingAnime = const [],
    this.popularAnime = const [],
    this.recentAnime = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Anime>? trendingAnime,
    List<Anime>? popularAnime,
    List<Anime>? recentAnime,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      trendingAnime: trendingAnime ?? this.trendingAnime,
      popularAnime: popularAnime ?? this.popularAnime,
      recentAnime: recentAnime ?? this.recentAnime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        trendingAnime,
        popularAnime,
        recentAnime,
        errorMessage,
      ];
}
