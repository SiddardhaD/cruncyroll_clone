import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/anime.dart';

part 'anime_model.g.dart';

@JsonSerializable()
class AnimeModel extends Anime {
  const AnimeModel({
    required super.id,
    required super.title,
    required super.description,
    super.imageUrl,
    super.bannerUrl,
    super.logoUrl,
    required super.rating,
    required super.totalEpisodes,
    required super.status,
    required super.genres,
    super.releaseYear,
    super.isFavorite,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeModelToJson(this);

  factory AnimeModel.fromEntity(Anime anime) {
    return AnimeModel(
      id: anime.id,
      title: anime.title,
      description: anime.description,
      imageUrl: anime.imageUrl,
      bannerUrl: anime.bannerUrl,
      logoUrl: anime.logoUrl,
      rating: anime.rating,
      totalEpisodes: anime.totalEpisodes,
      status: anime.status,
      genres: anime.genres,
      releaseYear: anime.releaseYear,
      isFavorite: anime.isFavorite,
    );
  }

  Anime toEntity() {
    return Anime(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      bannerUrl: bannerUrl,
      logoUrl: logoUrl,
      rating: rating,
      totalEpisodes: totalEpisodes,
      status: status,
      genres: genres,
      releaseYear: releaseYear,
      isFavorite: isFavorite,
    );
  }
}
