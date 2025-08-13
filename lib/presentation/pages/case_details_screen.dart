import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/core/constants/app_colors.dart';
import 'package:locat_lost/navigation/app_routes.dart';
import 'package:locat_lost/presentation/widgets/custom_app_bar.dart';
import 'package:locat_lost/presentation/widgets/main_bottom_navigation.dart';
import 'package:locat_lost/presentation/widgets/skeleton_loader.dart';

class CaseDetailsScreen extends StatefulWidget {
  final bool isInNavigation;

  const CaseDetailsScreen({super.key, this.isInNavigation = false});

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  bool _isLoading = false;
  late MainNavigationController navController;

  // Dummy status data
  final Map<String, dynamic> caseStatus = {
    'totalCases': 15,
    'activeCases': 8,
    'resolvedCases': 5,
    'underInvestigation': 2,
    'recentActivity': [
      {
        'type': 'match_found',
        'title': 'Potential Match Found',
        'description': 'A possible match for Emma Johnson has been found',
        'time': '2 hours ago',
        'status': 'urgent',
      },
      {
        'type': 'case_updated',
        'title': 'Case Status Updated',
        'description': 'Alex Smith case moved to investigating status',
        'time': '5 hours ago',
        'status': 'info',
      },
      {
        'type': 'case_resolved',
        'title': 'Case Resolved',
        'description': 'Sarah Wilson has been safely reunited',
        'time': '1 day ago',
        'status': 'success',
      },
      {
        'type': 'new_case',
        'title': 'New Case Reported',
        'description': 'Missing person report filed for John Doe',
        'time': '2 days ago',
        'status': 'info',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    // Initialize or get the navigation controller
    try {
      navController = Get.find<MainNavigationController>();
    } catch (e) {
      navController = Get.put(MainNavigationController());
    }

    if (!widget.isInNavigation) {
      navController.setIndex(
        2,
      ); // Set Case Details as active only if not in navigation wrapper
    }
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Case Status',
        onPressed: () => _loadStatus(),
        icon: Icons.refresh,
      ),
      backgroundColor: AppColors.surfaceVariant,
      body: RefreshIndicator(
        onRefresh: _loadStatus,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            16.w,
            16.h,
            16.w,
            widget.isInNavigation ? 140.h : 160.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewCards(),
              SizedBox(height: 24.h),
              _buildRecentActivitySection(),
              SizedBox(height: 24.h),
              _buildQuickActionsSection(),
            ],
          ),
        ),
      ),
      extendBody: !widget.isInNavigation,
      bottomNavigationBar:
          widget.isInNavigation
              ? null
              : Obx(
                () => MainBottomNavigation(
                  currentIndex: navController.selectedIndex.value,
                  onTap: navController.changeIndex,
                ),
              ),
    );
  }

  Widget _buildOverviewCards() {
    if (_isLoading) {
      return Column(
        children: [
          const DashboardStatsSkeleton(),
          SizedBox(height: 16.h),
          const DashboardStatsSkeleton(),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Cases',
                caseStatus['totalCases'].toString(),
                Icons.assignment,
                AppColors.info,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                'Active',
                caseStatus['activeCases'].toString(),
                Icons.schedule,
                AppColors.statusActive,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Resolved',
                caseStatus['resolvedCases'].toString(),
                Icons.check_circle,
                AppColors.success,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                'Investigating',
                caseStatus['underInvestigation'].toString(),
                Icons.search,
                AppColors.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(height: 12.h),
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
            style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        if (_isLoading)
          Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: const ReportCardSkeleton(),
              ),
            ),
          )
        else
          ...caseStatus['recentActivity'].map<Widget>((activity) {
            return _buildActivityCard(activity);
          }).toList(),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    IconData icon;
    Color color;

    switch (activity['status']) {
      case 'urgent':
        icon = Icons.priority_high;
        color = AppColors.error;
        break;
      case 'success':
        icon = Icons.check_circle;
        color = AppColors.success;
        break;
      case 'info':
      default:
        icon = Icons.info;
        color = AppColors.info;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  activity['description'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  activity['time'],
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'View All Cases',
                Icons.assignment,
                AppColors.primary,
                () {
                  // Navigate to My Cases screen with index 0 (missing cases)
                  Get.back();
                  Get.toNamed(AppRoutes.myCases);
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionButton(
                'Emergency',
                Icons.emergency,
                AppColors.error,
                () {
                  Get.toNamed(AppRoutes.emergency);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Contact Support',
                Icons.support_agent,
                AppColors.info,
                () {
                  Get.toNamed(AppRoutes.contactUs);
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionButton(
                'Settings',
                Icons.settings,
                AppColors.textSecondary,
                () {
                  // Navigate to settings
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.w),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
