import 'package:equatable/equatable.dart';

abstract class AnimeDetailsEvent extends Equatable {
  const AnimeDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimeDetails extends AnimeDetailsEvent {
  final String animeId;

  const LoadAnimeDetails(this.animeId);

  @override
  List<Object> get props => [animeId];
}

class LoadEpisodes extends AnimeDetailsEvent {
  final String animeId;

  const LoadEpisodes(this.animeId);

  @override
  List<Object> get props => [animeId];
}

class ToggleFavorite extends AnimeDetailsEvent {
  final String animeId;

  const ToggleFavorite(this.animeId);

  @override
  List<Object> get props => [animeId];
}
