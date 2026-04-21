import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/anime.dart';

class AnimeBannerCarousel extends StatefulWidget {
  final List<Anime> animeList;
  final Function(Anime)? onWatchNow;
  final Function(Anime)? onToggleFavorite;

  const AnimeBannerCarousel({
    super.key,
    required this.animeList,
    this.onWatchNow,
    this.onToggleFavorite,
  });

  @override
  State<AnimeBannerCarousel> createState() => _AnimeBannerCarouselState();
}

class _AnimeBannerCarouselState extends State<AnimeBannerCarousel> {
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  // SVG assets for carousel items
  final List<String> _svgAssets = [
    'https://wallpapers.com/images/hd/luffy-zoro-kdwntc4i6gbqj08u.jpg',
    'https://wallpapercave.com/wp/wp11053400.jpg',
    'https://mfiles.alphacoders.com/909/909326.jpg',
    'https://i.pinimg.com/736x/03/6a/2e/036a2eced14dcd225d47ffcce492cb30.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_currentPage < widget.animeList.length.clamp(0, 4) - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animeList.isEmpty) return const SizedBox();

    final displayList = widget.animeList.take(4).toList();
    final currentAnime = displayList[_currentPage];

    return SizedBox(
      height: 500.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: displayList.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final svgAsset = _svgAssets[index % _svgAssets.length];
              return _buildImageBackground(svgAsset);
            },
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: _buildFixedContent(currentAnime),
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: displayList.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primaryOrange,
                  dotColor: AppColors.textTertiary,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  expansionFactor: 4,
                  spacing: 8.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageBackground(String svgAsset) {
    return Image.network(svgAsset, fit: BoxFit.cover);
  }

  Widget _buildFixedContent(Anime anime) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.backgroundDark,
            AppColors.backgroundDark.withValues(alpha: 0.9),
            AppColors.backgroundDark.withValues(alpha: 0.7),
            AppColors.backgroundDark.withValues(alpha: 0.4),
            AppColors.backgroundDark.withValues(alpha: 0.2),
            Colors.transparent,
          ],
          stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: anime.logoUrl != null
                  ? Image.asset(
                      anime.logoUrl!,
                      key: ValueKey(anime.id),
                      height: 80.h,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to text if logo image not found
                        return Text(
                          anime.title.toUpperCase(),
                          key: ValueKey('${anime.id}_text'),
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: AppColors.textPrimary,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withValues(alpha: 0.7),
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    )
                  : Text(
                      anime.title.toUpperCase(),
                      key: ValueKey(anime.id),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: AppColors.textPrimary,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withValues(alpha: 0.7),
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            SizedBox(height: 8.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Row(
                key: ValueKey('${anime.id}_genres'),
                children: [
                  Text(
                    'Subtitled',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    ' • ',
                    style: TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 16.sp,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      anime.genres.take(4).join(', '),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onWatchNow?.call(anime),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: AppColors.textPrimary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 24.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'START WATCHING S1 E1',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 8.w),
                Container(
                  width: 56.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryOrange,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: IconButton(
                    onPressed: () => widget.onToggleFavorite?.call(anime),
                    icon: Icon(
                      anime.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color: AppColors.primaryOrange,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
