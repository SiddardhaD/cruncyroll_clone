import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/local/anime_local_data_source.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AnimeLocalDataSource _localDataSource;

  FavoritesBloc(this._localDataSource) : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    try {
      final favorites = await _localDataSource.getFavoriteAnime();
      final favoriteIds = favorites.map((anime) => anime.id).toSet();
      
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
        favoriteIds: favoriteIds,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      // Note: This requires the full anime object
      // We'll load favorites after the anime is added elsewhere
      add(LoadFavorites());
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _localDataSource.removeFromFavorites(event.animeId);
      add(LoadFavorites());
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final isFavorite = await _localDataSource.isFavorite(event.animeId);
      if (isFavorite) {
        await _localDataSource.removeFromFavorites(event.animeId);
      }
      // Adding requires the full anime object, handled in AnimeDetailsBloc
      add(LoadFavorites());
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
