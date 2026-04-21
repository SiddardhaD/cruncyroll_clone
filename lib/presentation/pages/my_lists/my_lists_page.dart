import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../../domain/entities/anime.dart';
import '../../bloc/favorites/favorites_bloc.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../bloc/favorites/favorites_event.dart';
import '../../bloc/anime_details/anime_details_bloc.dart';
import '../anime_details/anime_details_page.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<FavoritesBloc>().add(LoadFavorites());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            Icon(Icons.bookmark, color: AppColors.textPrimary, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'My Lists',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryOrange,
          indicatorWeight: 3.h,
          labelColor: AppColors.textPrimary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          tabs: const [
            Tab(text: 'WATCHLIST'),
            Tab(text: 'CRUNCHLISTS'),
            Tab(text: 'HISTORY'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWatchlistTab(),
          _buildCrunchlistsTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildWatchlistTab() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoritesStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryOrange),
          );
        }

        if (state.favorites.isEmpty) {
          return _buildEmptyState(
            icon: Icons.bookmark_border,
            title: 'No items in watchlist',
            subtitle: 'Add anime to your watchlist to see them here',
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {},
                        color: AppColors.textSecondary,
                      ),
                      IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: () {},
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  return _buildWatchlistItem(state.favorites[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWatchlistItem(Anime anime) {
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
                    'Start Watching: S1 E1',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Series • Sub | Dub',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.bookmark),
                  color: AppColors.error,
                  onPressed: () {
                    context.read<FavoritesBloc>().add(RemoveFavorite(anime.id));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: AppColors.textSecondary,
                  onPressed: () {
                    context.read<FavoritesBloc>().add(RemoveFavorite(anime.id));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrunchlistsTab() {
    return _buildEmptyState(
      icon: Icons.list,
      title: 'No Crunchlists yet',
      subtitle: 'Create custom lists to organize your anime',
    );
  }

  Widget _buildHistoryTab() {
    return _buildEmptyState(
      icon: Icons.history,
      title: 'No viewing history',
      subtitle: 'Your recently watched anime will appear here',
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64.sp, color: AppColors.textTertiary),
          SizedBox(height: 16.h),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
