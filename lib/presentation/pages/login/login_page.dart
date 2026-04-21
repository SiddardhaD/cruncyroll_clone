import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';
import '../dashboard/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final int numberOfRows = 6;
  final List<int> imagesPerRow = [5, 6, 5, 6, 5, 6];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controllers = List.generate(
      numberOfRows,
      (index) => AnimationController(
        duration: Duration(seconds: 20 + (index * 5)), // Different speeds
        vsync: this,
      )..repeat(),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.95),
                ],
              ),
            ),
          ),

          // Login content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 6),
                _buildLoginContent(),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Column(
      children: List.generate(numberOfRows, (rowIndex) {
        final isScrollingRight = rowIndex % 2 == 0;
        final imageCount = imagesPerRow[rowIndex];

        return Expanded(
          child: AnimatedBuilder(
            animation: _animations[rowIndex],
            builder: (context, child) {
              return _buildScrollingRow(
                rowIndex,
                imageCount,
                isScrollingRight,
                _animations[rowIndex].value,
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildScrollingRow(
    int rowIndex,
    int imageCount,
    bool isScrollingRight,
    double animationValue,
  ) {
    return OverflowBox(
      alignment: Alignment.centerLeft,
      maxWidth: double.infinity,
      child: Transform.translate(
        offset: Offset(
          isScrollingRight
              ? -animationValue * MediaQuery.of(context).size.width / 0.5
              : animationValue * MediaQuery.of(context).size.width / 1,
          0,
        ),
        child: Row(
          children: [
            ...List.generate(imageCount, (index) {
              return _buildImageCard(rowIndex, index, imageCount);
            }),
            ...List.generate(imageCount, (index) {
              return _buildImageCard(rowIndex, index, imageCount);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(int rowIndex, int imageIndex, int imageCount) {
    final imageNumber = (rowIndex * 5) + imageIndex + 1;
    final imagePath = 'assets/images/splash$imageNumber.jpg';

    return Container(
      width: 100.w,
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.cardDark,
              child: Icon(
                Icons.image,
                color: AppColors.textTertiary,
                size: 40.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/bottom5.svg',
                height: 24.h,
                width: 24.w,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryOrange,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'crunchyroll',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'All your favorite anime. All in one place.',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 38.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF78B25),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 4,
              ),
              icon: Icon(Icons.workspace_premium, size: 18.sp),
              label: Text(
                'Explore Free Trial',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to dashboard (for now)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryOrange,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: BorderSide(color: AppColors.primaryOrange, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'or ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardPage(),
                    ),
                  );
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
