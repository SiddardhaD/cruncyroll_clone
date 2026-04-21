import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/episode.dart';
import '../pages/video_player/video_player_page.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  final VoidCallback? onTap;

  const EpisodeCard({super.key, required this.episode, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(episode: episode),
              ),
            );
          },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: episode.thumbnailUrl ?? '',
                    width: 140.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColors.backgroundDark),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.backgroundDark,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: AppColors.overlay.withValues(alpha: 0.3),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 40,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  if (episode.watchedProgress != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        value:
                            episode.watchedProgress! /
                            episode.durationInSeconds,
                        backgroundColor: AppColors.border,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Episode ${episode.episodeNumber}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      episode.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      episode.formattedDuration,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Icon(
                episode.isWatched ? Icons.check_circle : Icons.circle_outlined,
                color: episode.isWatched
                    ? AppColors.success
                    : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
