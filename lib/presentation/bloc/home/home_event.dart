import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadTrendingAnime extends HomeEvent {}

class LoadPopularAnime extends HomeEvent {}

class LoadRecentAnime extends HomeEvent {}

class RefreshHome extends HomeEvent {}
