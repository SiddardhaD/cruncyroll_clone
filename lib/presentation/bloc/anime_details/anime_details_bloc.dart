import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_anime_details.dart';
import '../../../domain/usecases/get_anime_episodes.dart';
import '../../../domain/repositories/anime_repository.dart';
import 'anime_details_event.dart';
import 'anime_details_state.dart';

class AnimeDetailsBloc extends Bloc<AnimeDetailsEvent, AnimeDetailsState> {
  final GetAnimeDetails getAnimeDetails;
  final GetAnimeEpisodes getAnimeEpisodes;
  final AnimeRepository animeRepository;

  AnimeDetailsBloc({
    required this.getAnimeDetails,
    required this.getAnimeEpisodes,
    required this.animeRepository,
  }) : super(const AnimeDetailsState()) {
    on<LoadAnimeDetails>(_onLoadAnimeDetails);
    on<LoadEpisodes>(_onLoadEpisodes);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadAnimeDetails(
    LoadAnimeDetails event,
    Emitter<AnimeDetailsState> emit,
  ) async {
    emit(state.copyWith(status: AnimeDetailsStatus.loading));

    final result = await getAnimeDetails(event.animeId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AnimeDetailsStatus.error,
        errorMessage: failure.message,
      )),
      (anime) => emit(state.copyWith(
        status: AnimeDetailsStatus.success,
        anime: anime,
        isFavorite: anime.isFavorite,
      )),
    );

    add(LoadEpisodes(event.animeId));
  }

  Future<void> _onLoadEpisodes(
    LoadEpisodes event,
    Emitter<AnimeDetailsState> emit,
  ) async {
    final result = await getAnimeEpisodes(event.animeId);

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.message,
      )),
      (episodes) => emit(state.copyWith(
        episodes: episodes,
      )),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<AnimeDetailsState> emit,
  ) async {
    final result = await animeRepository.toggleFavorite(event.animeId);

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.message,
      )),
      (isFavorite) => emit(state.copyWith(
        isFavorite: isFavorite,
      )),
    );
  }
}
