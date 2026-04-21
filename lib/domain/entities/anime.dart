import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String? bannerUrl;
  final String? logoUrl;
  final double rating;
  final int totalEpisodes;
  final String status;
  final List<String> genres;
  final String? releaseYear;
  final bool isFavorite;

  const Anime({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.bannerUrl,
    this.logoUrl,
    required this.rating,
    required this.totalEpisodes,
    required this.status,
    required this.genres,
    this.releaseYear,
    this.isFavorite = false,
  });

  Anime copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? bannerUrl,
    String? logoUrl,
    double? rating,
    int? totalEpisodes,
    String? status,
    List<String>? genres,
    String? releaseYear,
    bool? isFavorite,
  }) {
    return Anime(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      rating: rating ?? this.rating,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      status: status ?? this.status,
      genres: genres ?? this.genres,
      releaseYear: releaseYear ?? this.releaseYear,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        bannerUrl,
        logoUrl,
        rating,
        totalEpisodes,
        status,
        genres,
        releaseYear,
        isFavorite,
      ];
}
