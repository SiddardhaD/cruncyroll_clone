import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerShimmer(),
          SizedBox(height: 16.h),
          _buildSectionShimmer(),
          _buildSectionShimmer(),
          _buildSectionShimmer(),
        ],
      ),
    );
  }

  Widget _buildBannerShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        height: 400.h,
        width: double.infinity,
        color: AppColors.shimmerBase,
      ),
    );
  }

  Widget _buildSectionShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Container(
              height: 20.h,
              width: 150.w,
              color: AppColors.shimmerBase,
            ),
          ),
        ),
        SizedBox(
          height: 260.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildCardShimmer();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              width: 140.w,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 16.h,
              width: 120.w,
              color: AppColors.shimmerBase,
            ),
            SizedBox(height: 4.h),
            Container(
              height: 12.h,
              width: 80.w,
              color: AppColors.shimmerBase,
            ),
          ],
        ),
      ),
    );
  }
}
