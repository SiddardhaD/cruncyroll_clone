import 'package:equatable/equatable.dart';
import '../../../domain/entities/anime.dart';

enum FavoritesStatus { initial, loading, success, error }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Anime> favorites;
  final Set<String> favoriteIds;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.errorMessage,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Anime>? favorites,
    Set<String>? favoriteIds,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isFavorite(String animeId) => favoriteIds.contains(animeId);

  @override
  List<Object?> get props => [status, favorites, favoriteIds, errorMessage];
}
