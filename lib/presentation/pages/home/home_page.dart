import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../bloc/anime_details/anime_details_bloc.dart';
import '../anime_details/anime_details_page.dart';
import '../../widgets/anime_list_section.dart';
import '../../widgets/anime_banner_carousel.dart';
import '../../widgets/shimmer_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadTrendingAnime());
    context.read<HomeBloc>().add(LoadPopularAnime());
    context.read<HomeBloc>().add(LoadRecentAnime());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const ShimmerLoading();
        }

        if (state.status == HomeStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.errorMessage ?? 'An error occurred',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(RefreshHome());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHome());
            },
            color: AppColors.primaryOrange,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.trendingAnime.isNotEmpty)
                    AnimeBannerCarousel(
                      animeList: state.trendingAnime.take(4).toList(),
                      onWatchNow: (anime) {
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
                      onToggleFavorite: (anime) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              anime.isFavorite
                                  ? 'Removed from bookmarks'
                                  : 'Added to bookmarks',
                            ),
                            backgroundColor: AppColors.primaryOrange,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  AnimeListSection(
                    title: 'Trending Now',
                    animeList: state.trendingAnime,
                    onSeeAll: () {},
                  ),
                  AnimeListSection(
                    title: 'Popular Anime',
                    animeList: state.popularAnime,
                    onSeeAll: () {},
                  ),

                  AnimeListSection(
                    title: 'Recently Updated',
                    animeList: state.recentAnime,
                    onSeeAll: () {},
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      );
  }
}
