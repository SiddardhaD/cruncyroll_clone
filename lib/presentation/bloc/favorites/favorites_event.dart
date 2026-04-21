import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final String animeId;

  const AddFavorite(this.animeId);

  @override
  List<Object?> get props => [animeId];
}

class RemoveFavorite extends FavoritesEvent {
  final String animeId;

  const RemoveFavorite(this.animeId);

  @override
  List<Object?> get props => [animeId];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final String animeId;

  const ToggleFavoriteEvent(this.animeId);

  @override
  List<Object?> get props => [animeId];
}
