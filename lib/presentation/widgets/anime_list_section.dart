import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/di/injection_container.dart';
import '../../domain/entities/anime.dart';
import '../bloc/anime_details/anime_details_bloc.dart';
import '../pages/anime_details/anime_details_page.dart';
import 'anime_card.dart';

class AnimeListSection extends StatelessWidget {
  final String title;
  final List<Anime> animeList;
  final VoidCallback? onSeeAll;

  const AnimeListSection({
    super.key,
    required this.title,
    required this.animeList,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (animeList.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              return AnimeCard(
                anime: animeList[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<AnimeDetailsBloc>(),
                        child: AnimeDetailsPage(animeId: animeList[index].id),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
