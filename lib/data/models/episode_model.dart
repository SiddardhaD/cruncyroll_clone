import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/episode.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.id,
    required super.animeId,
    required super.episodeNumber,
    required super.title,
    super.description,
    super.thumbnailUrl,
    required super.videoUrl,
    required super.durationInSeconds,
    super.releaseDate,
    super.isWatched,
    super.watchedProgress,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);

  factory EpisodeModel.fromEntity(Episode episode) {
    return EpisodeModel(
      id: episode.id,
      animeId: episode.animeId,
      episodeNumber: episode.episodeNumber,
      title: episode.title,
      description: episode.description,
      thumbnailUrl: episode.thumbnailUrl,
      videoUrl: episode.videoUrl,
      durationInSeconds: episode.durationInSeconds,
      releaseDate: episode.releaseDate,
      isWatched: episode.isWatched,
      watchedProgress: episode.watchedProgress,
    );
  }

  Episode toEntity() {
    return Episode(
      id: id,
      animeId: animeId,
      episodeNumber: episodeNumber,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      durationInSeconds: durationInSeconds,
      releaseDate: releaseDate,
      isWatched: isWatched,
      watchedProgress: watchedProgress,
    );
  }
}
