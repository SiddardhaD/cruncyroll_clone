import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/anime.dart';
import '../../../domain/entities/episode.dart';
import '../../bloc/anime_details/anime_details_bloc.dart';
import '../../bloc/anime_details/anime_details_event.dart';
import '../../bloc/anime_details/anime_details_state.dart';
import '../video_player/video_player_page.dart';

class AnimeDetailsPage extends StatefulWidget {
  final String animeId;

  const AnimeDetailsPage({super.key, required this.animeId});

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  bool _isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    context.read<AnimeDetailsBloc>().add(LoadAnimeDetails(widget.animeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
        builder: (context, state) {
          if (state.status == AnimeDetailsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          }

          if (state.status == AnimeDetailsStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Error loading details'),
            );
          }

          final anime = state.anime;
          if (anime == null) return const SizedBox();

          return CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSection(anime),
                    _buildTitleSection(anime, state.isFavorite),
                    _buildRatingSection(anime),
                    _buildActionButtons(anime, state.episodes),
                    _buildDescription(anime),
                    _buildPremiumBanner(),
                    _buildEpisodesList(state.episodes, anime),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
    );
  }

  Widget _buildBannerSection(Anime anime) {
    return Stack(
      children: [
        SizedBox(
          height: 280.h,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: anime.bannerUrl ?? anime.imageUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.cardDark,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                Container(color: AppColors.cardDark),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.backgroundDark],
              ),
            ),
          ),
        ),
        if (anime.logoUrl != null)
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Image.asset(
              anime.logoUrl!,
              height: 80.h,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleSection(Anime anime, bool isFavorite) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            anime.title.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Sub | Dub',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(Anime anime) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < anime.rating
                    ? AppColors.accentYellow
                    : AppColors.textTertiary,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                'Average Rating: ${anime.rating.toStringAsFixed(1)} (10.9K)',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              Text(' • ', style: TextStyle(color: AppColors.textSecondary)),
              Text(
                '770 Reviews',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Anime anime, List episodes) {
    final firstEpisode = episodes.isNotEmpty ? episodes[0] : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: firstEpisode != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerPage(episode: firstEpisode),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow, size: 24),
                  label: Text(
                    'START WATCHING S1 E1',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textSecondary),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border, size: 18),
                  onPressed: () {
                    context.read<AnimeDetailsBloc>().add(
                      ToggleFavorite(anime.id),
                    );
                  },
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: () {
              context.read<AnimeDetailsBloc>().add(ToggleFavorite(anime.id));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: AppColors.textSecondary, size: 18),
                SizedBox(width: 4.w),
                Text(
                  'ADD TO CRUNCHYLIST',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(Anime anime) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            anime.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: _isDescriptionExpanded ? null : 3,
            overflow: _isDescriptionExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () {
              setState(() {
                _isDescriptionExpanded = !_isDescriptionExpanded;
              });
            },
            child: Text(
              _isDescriptionExpanded ? 'SHOW LESS' : 'MORE DETAILS',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B6A6F),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        children: [
          Text(
            'Watch BLUELOCK without ads using Crunchyroll Premium!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle premium trial
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF78B25),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              icon: const Icon(Icons.workspace_premium, size: 24),
              label: Text(
                'START FREE TRIAL',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodesList(List episodes, Anime anime) {
    if (episodes.isEmpty) return const SizedBox();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'S1: ${anime.title.toUpperCase()}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
                color: AppColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              return _buildEpisodeItem(episodes[index], anime);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodeItem(Episode episode, Anime anime) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(episode: episode),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: CachedNetworkImage(
                    imageUrl: episode.thumbnailUrl ?? '',
                    width: 120.w,
                    height: 68.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.cardDark,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryOrange,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Container(color: AppColors.cardDark),
                  ),
                ),
                Positioned(
                  bottom: 4.h,
                  right: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: Text(
                      '24m',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    episode.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Dub | Sub',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
