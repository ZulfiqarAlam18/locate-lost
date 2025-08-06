import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class DashboardStats extends StatelessWidget {
  final int activeReports;
  final int totalReports;
  final int resolvedReports;
  final bool isLoading;

  const DashboardStats({
    super.key,
    required this.activeReports,
    required this.totalReports,
    required this.resolvedReports,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingSkeleton();
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStatItem(
            title: 'Active',
            value: activeReports.toString(),
            color: AppColors.statusActive,
            icon: Icons.pending_actions_rounded,
          ),
          _buildDivider(),
          _buildStatItem(
            title: 'Total',
            value: totalReports.toString(),
            color: AppColors.primary,
            icon: Icons.assignment_rounded,
          ),
          _buildDivider(),
          _buildStatItem(
            title: 'Resolved',
            value: resolvedReports.toString(),
            color: AppColors.statusResolved,
            icon: Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 24.sp,
              color: color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.w,
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      color: AppColors.divider,
    );
  }

  Widget _buildLoadingSkeleton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildSkeletonStatItem(),
          _buildDivider(),
          _buildSkeletonStatItem(),
          _buildDivider(),
          _buildSkeletonStatItem(),
        ],
      ),
    );
  }

  Widget _buildSkeletonStatItem() {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.myGreyColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 32.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColors.myGreyColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: 48.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.myGreyColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
