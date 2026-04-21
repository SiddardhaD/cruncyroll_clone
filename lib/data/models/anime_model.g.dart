// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeModel _$AnimeModelFromJson(Map<String, dynamic> json) => AnimeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      totalEpisodes: (json['totalEpisodes'] as num).toInt(),
      status: json['status'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      releaseYear: json['releaseYear'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$AnimeModelToJson(AnimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'bannerUrl': instance.bannerUrl,
      'logoUrl': instance.logoUrl,
      'rating': instance.rating,
      'totalEpisodes': instance.totalEpisodes,
      'status': instance.status,
      'genres': instance.genres,
      'releaseYear': instance.releaseYear,
      'isFavorite': instance.isFavorite,
    };
