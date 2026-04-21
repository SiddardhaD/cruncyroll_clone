import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Account',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 64.sp,
              color: AppColors.textTertiary,
            ),
            SizedBox(height: 16.h),
            Text(
              'Account Page',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 8.h),
            Text(
              'Coming soon',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
