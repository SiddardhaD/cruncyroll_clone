import 'package:equatable/equatable.dart';
import '../../../domain/entities/anime.dart';
import '../../../domain/entities/episode.dart';

enum AnimeDetailsStatus { initial, loading, success, error }

class AnimeDetailsState extends Equatable {
  final AnimeDetailsStatus status;
  final Anime? anime;
  final List<Episode> episodes;
  final String? errorMessage;
  final bool isFavorite;

  const AnimeDetailsState({
    this.status = AnimeDetailsStatus.initial,
    this.anime,
    this.episodes = const [],
    this.errorMessage,
    this.isFavorite = false,
  });

  AnimeDetailsState copyWith({
    AnimeDetailsStatus? status,
    Anime? anime,
    List<Episode>? episodes,
    String? errorMessage,
    bool? isFavorite,
  }) {
    return AnimeDetailsState(
      status: status ?? this.status,
      anime: anime ?? this.anime,
      episodes: episodes ?? this.episodes,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        status,
        anime,
        episodes,
        errorMessage,
        isFavorite,
      ];
}
