import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';
import '../my_lists/my_lists_page.dart';
import '../browse/browse_page.dart';
import '../account/account_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MyListsPage(),
    const BrowsePage(),
    const SearchPage(),
    const AccountPage(),
  ];

  final List<String> _labels = [
    'Home',
    'My Lists',
    'Browse',
    'Search',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) => _buildNavItem(index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = _currentIndex == index;
    final iconPath = 'assets/images/bottom${index + 1}.svg';

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 22.h,
              width: 22.w,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primaryOrange : AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _labels[index],
              style: TextStyle(
                fontSize: 11.sp,
                color: isActive
                    ? AppColors.primaryOrange
                    : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
