import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.myGreyColor,
                AppColors.myGreyColor.withOpacity(0.5),
                AppColors.myGreyColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

class ReportCardSkeleton extends StatelessWidget {
  const ReportCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
          // Image skeleton
          SkeletonLoader(
            width: 60.w,
            height: 60.h,
            borderRadius: BorderRadius.circular(12.r),
          ),
          SizedBox(width: 16.w),
          
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 16.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 8.h),
                SkeletonLoader(
                  width: 120.w,
                  height: 14.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    SkeletonLoader(
                      width: 60.w,
                      height: 20.h,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    SizedBox(width: 8.w),
                    SkeletonLoader(
                      width: 40.w,
                      height: 14.h,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardStatsSkeleton extends StatelessWidget {
  const DashboardStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Column(
              children: [
                SkeletonLoader(
                  width: 40.w,
                  height: 24.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 8.h),
                SkeletonLoader(
                  width: 60.w,
                  height: 12.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: AppColors.divider,
          ),
          Expanded(
            child: Column(
              children: [
                SkeletonLoader(
                  width: 40.w,
                  height: 24.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 8.h),
                SkeletonLoader(
                  width: 60.w,
                  height: 12.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: AppColors.divider,
          ),
          Expanded(
            child: Column(
              children: [
                SkeletonLoader(
                  width: 40.w,
                  height: 24.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                SizedBox(height: 8.h),
                SkeletonLoader(
                  width: 60.w,
                  height: 12.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
