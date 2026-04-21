import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/di/injection_container.dart';
import '../../domain/entities/anime.dart';
import '../bloc/anime_details/anime_details_bloc.dart';
import '../pages/anime_details/anime_details_page.dart';

class FeaturedBanner extends StatelessWidget {
  final Anime anime;

  const FeaturedBanner({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: anime.bannerUrl ?? anime.imageUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.cardDark,
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.cardDark,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.overlayGradient,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'FEATURED',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withValues(alpha: 0.5),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    anime.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => getIt<AnimeDetailsBloc>(),
                                  child: AnimeDetailsPage(animeId: anime.id),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Watch Now'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => getIt<AnimeDetailsBloc>(),
                                  child: AnimeDetailsPage(animeId: anime.id),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline),
                          label: const Text('More Info'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

