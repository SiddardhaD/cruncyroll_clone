import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String id;
  final String animeId;
  final int episodeNumber;
  final String title;
  final String? description;
  final String? thumbnailUrl;
  final String videoUrl;
  final int durationInSeconds;
  final DateTime? releaseDate;
  final bool isWatched;
  final int? watchedProgress;

  const Episode({
    required this.id,
    required this.animeId,
    required this.episodeNumber,
    required this.title,
    this.description,
    this.thumbnailUrl,
    required this.videoUrl,
    required this.durationInSeconds,
    this.releaseDate,
    this.isWatched = false,
    this.watchedProgress,
  });

  Episode copyWith({
    String? id,
    String? animeId,
    int? episodeNumber,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    int? durationInSeconds,
    DateTime? releaseDate,
    bool? isWatched,
    int? watchedProgress,
  }) {
    return Episode(
      id: id ?? this.id,
      animeId: animeId ?? this.animeId,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      releaseDate: releaseDate ?? this.releaseDate,
      isWatched: isWatched ?? this.isWatched,
      watchedProgress: watchedProgress ?? this.watchedProgress,
    );
  }

  String get formattedDuration {
    final hours = durationInSeconds ~/ 3600;
    final minutes = (durationInSeconds % 3600) ~/ 60;
    if (hours > 0) {
      return '$hours hr $minutes min';
    }
    return '$minutes min';
  }

  @override
  List<Object?> get props => [
        id,
        animeId,
        episodeNumber,
        title,
        description,
        thumbnailUrl,
        videoUrl,
        durationInSeconds,
        releaseDate,
        isWatched,
        watchedProgress,
      ];
}
