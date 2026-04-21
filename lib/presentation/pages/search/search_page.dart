import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/anime_details/anime_details_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../anime_details/anime_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Anime> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final homeState = context.read<HomeBloc>().state;
    final allAnime = [
      ...homeState.trendingAnime,
      ...homeState.popularAnime,
      ...homeState.recentAnime,
    ];

    final results = allAnime.where((anime) {
      return anime.title.toLowerCase().contains(query.toLowerCase()) ||
          anime.genres.any(
            (genre) => genre.toLowerCase().contains(query.toLowerCase()),
          );
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/bottom5.svg',
              height: 24.h,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.play_circle_outline,
                color: AppColors.primaryOrange,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'crunchyroll',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildEmptyState()
                : _searchResults.isEmpty
                ? _buildNoResults()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.backgroundDark,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Search anime...',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                onChanged: _performSearch,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64.sp, color: AppColors.textTertiary),
          SizedBox(height: 16.h),
          Text(
            'Search for anime',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Text(
            'Find your favorite shows',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64.sp, color: AppColors.textTertiary),
          SizedBox(height: 16.h),
          Text(
            'No results found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with different keywords',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            'Top Results',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return _buildSearchResultItem(_searchResults[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultItem(Anime anime) {
    return InkWell(
      onTap: () {
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
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: anime.imageUrl ?? '',
                width: 80.w,
                height: 120.h,
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Sub | Dub',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.sp,
                        color: AppColors.accentYellow,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        anime.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '${anime.totalEpisodes} Episodes',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
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
