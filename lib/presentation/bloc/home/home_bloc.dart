import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_trending_anime.dart';
import '../../../domain/repositories/anime_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingAnime getTrendingAnime;
  final AnimeRepository animeRepository;

  HomeBloc({
    required this.getTrendingAnime,
    required this.animeRepository,
  }) : super(const HomeState()) {
    on<LoadTrendingAnime>(_onLoadTrendingAnime);
    on<LoadPopularAnime>(_onLoadPopularAnime);
    on<LoadRecentAnime>(_onLoadRecentAnime);
    on<RefreshHome>(_onRefreshHome);
  }

  Future<void> _onLoadTrendingAnime(
    LoadTrendingAnime event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await getTrendingAnime();

    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (anime) => emit(state.copyWith(
        status: HomeStatus.success,
        trendingAnime: anime,
      )),
    );
  }

  Future<void> _onLoadPopularAnime(
    LoadPopularAnime event,
    Emitter<HomeState> emit,
  ) async {
    final result = await animeRepository.getPopularAnime();

    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (anime) => emit(state.copyWith(
        popularAnime: anime,
      )),
    );
  }

  Future<void> _onLoadRecentAnime(
    LoadRecentAnime event,
    Emitter<HomeState> emit,
  ) async {
    final result = await animeRepository.getRecentAnime();

    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (anime) => emit(state.copyWith(
        recentAnime: anime,
      )),
    );
  }

  Future<void> _onRefreshHome(
    RefreshHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState(status: HomeStatus.loading));

    final trendingResult = await getTrendingAnime();
    final popularResult = await animeRepository.getPopularAnime();
    final recentResult = await animeRepository.getRecentAnime();

    if (trendingResult.isRight() &&
        popularResult.isRight() &&
        recentResult.isRight()) {
      emit(state.copyWith(
        status: HomeStatus.success,
        trendingAnime: trendingResult.getOrElse(() => []),
        popularAnime: popularResult.getOrElse(() => []),
        recentAnime: recentResult.getOrElse(() => []),
      ));
    } else {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: 'Failed to refresh content',
      ));
    }
  }
}
