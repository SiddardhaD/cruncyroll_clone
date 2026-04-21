// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
      id: json['id'] as String,
      animeId: json['animeId'] as String,
      episodeNumber: (json['episodeNumber'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      videoUrl: json['videoUrl'] as String,
      durationInSeconds: (json['durationInSeconds'] as num).toInt(),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      isWatched: json['isWatched'] as bool? ?? false,
      watchedProgress: (json['watchedProgress'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animeId': instance.animeId,
      'episodeNumber': instance.episodeNumber,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'videoUrl': instance.videoUrl,
      'durationInSeconds': instance.durationInSeconds,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'isWatched': instance.isWatched,
      'watchedProgress': instance.watchedProgress,
    };
