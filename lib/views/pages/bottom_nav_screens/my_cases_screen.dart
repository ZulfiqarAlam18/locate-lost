import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:locate_lost/controllers/my_cases_controller.dart';
import 'package:locate_lost/data/models/parent_report/my_parent_reports_response.dart';
import 'package:locate_lost/data/models/finder_report/my_finder_reports_response.dart' as finder_models;
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';
import 'package:locate_lost/views/widgets/main_bottom_navigation.dart';
import 'package:locate_lost/views/widgets/skeleton_loader.dart';

class MyCasesScreen extends StatefulWidget {
  final bool isInNavigation;
  
  const MyCasesScreen({super.key, this.isInNavigation = false});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MainNavigationController navController;
  late MyCasesController casesController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Initialize or get the navigation controller
    try {
      navController = Get.find<MainNavigationController>();
    } catch (e) {
      navController = Get.put(MainNavigationController());
    }
    
    // Initialize or get MyCasesController
    try {
      casesController = Get.find<MyCasesController>();
    } catch (e) {
      casesController = Get.put(MyCasesController());
    }
    
    if (!widget.isInNavigation) {
      navController.setIndex(1); // Set My Cases as active only if not in navigation wrapper
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'My Cases',
        onPressed: () => casesController.refreshReports(),
        icon: Icons.refresh,
      ),
      backgroundColor: AppColors.surfaceVariant,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: Icon(Icons.person_search),
                  text: 'Missing Cases',
                ),
                Tab(
                  icon: Icon(Icons.person_pin),
                  text: 'Found Cases',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMissingCasesTab(),
                _buildFoundCasesTab(),
              ],
            ),
          ),
        ],
      ),
    
    
     

    );
  }

  Widget _buildMissingCasesTab() {
    return Obx(() {
      if (casesController.isLoading.value && casesController.parentReports.isEmpty) {
        return _buildLoadingState();
      }

      if (casesController.errorMessage.value.isNotEmpty && casesController.parentReports.isEmpty) {
        return _buildEmptyState(
          icon: Icons.error_outline,
          title: 'Error',
          subtitle: casesController.errorMessage.value,
          buttonText: 'Retry',
          onPressed: () => casesController.fetchMyParentReports(),
        );
      }

      if (casesController.parentReports.isEmpty) {
        return _buildEmptyState(
          icon: Icons.person_search,
          title: 'No Missing Cases',
          subtitle: 'You haven\'t reported any missing cases yet.',
          buttonText: 'Report Missing Person',
          onPressed: () => Get.toNamed(AppRoutes.reportCase),
        );
      }

      return RefreshIndicator(
        onRefresh: () => casesController.refreshReports(),
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, widget.isInNavigation ? 200.h : 220.h),
          itemCount: casesController.parentReports.length,
          itemBuilder: (context, index) {
            final report = casesController.parentReports[index];
            return _buildMissingCaseCard(report);
          },
        ),
      );
    });
  }

  Widget _buildFoundCasesTab() {
    return Obx(() {
      if (casesController.isLoading.value && casesController.finderReports.isEmpty) {
        return _buildLoadingState();
      }

      if (casesController.errorMessage.value.isNotEmpty && casesController.finderReports.isEmpty) {
        return _buildEmptyState(
          icon: Icons.error_outline,
          title: 'Error',
          subtitle: casesController.errorMessage.value,
          buttonText: 'Retry',
          onPressed: () => casesController.fetchMyFinderReports(),
        );
      }

      if (casesController.finderReports.isEmpty) {
        return _buildEmptyState(
          icon: Icons.camera_alt,
          title: 'No Found Cases',
          subtitle: 'You haven\'t reported any found cases yet.',
          buttonText: 'Report Found Person',
          onPressed: () => Get.toNamed(AppRoutes.foundPersonDetails),
        );
      }

      return RefreshIndicator(
        onRefresh: () => casesController.refreshFinderReports(),
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, widget.isInNavigation ? 200.h : 220.h),
          itemCount: casesController.finderReports.length,
          itemBuilder: (context, index) {
            final report = casesController.finderReports[index];
            return _buildFoundCaseCard(report);
          },
        ),
      );
    });
  }

  Widget _buildMissingCaseCard(ParentReportItem report) {
    // Format date
    String formattedDate = 'Unknown date';
    try {
      final date = DateTime.parse(report.createdAt);
      formattedDate = DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      formattedDate = report.createdAt;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: InkWell(
          onTap: () => Get.toNamed('${AppRoutes.caseDetail}?reportId=${report.id}'),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: report.images.isNotEmpty
                      ? Builder(
                          builder: (context) {
                            final imageUrl = report.images.first.imageUrl;
                            print('🖼️ Loading image URL: $imageUrl');
                            return Image.network(
                              imageUrl,
                              width: 70.w,
                              height: 70.w,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 70.w,
                                  height: 70.w,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                print('❌ Image load error: $error');
                                print('❌ Image URL was: $imageUrl');
                                print('❌ Stack trace: $stackTrace');
                                return Container(
                                  width: 70.w,
                                  height: 70.w,
                                  color: Colors.grey[300],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.broken_image, color: Colors.grey[600], size: 30.w),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Error',
                                        style: TextStyle(fontSize: 8.sp, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Container(
                          width: 70.w,
                          height: 70.w,
                          color: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              report.childName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (report.matchCount.matchesAsParent > 0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${report.matchCount.matchesAsParent} Match${report.matchCount.matchesAsParent > 1 ? 'es' : ''}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Father: ${report.fatherName} • ${report.gender}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildStatusChip(report.status),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              report.placeLost != null ? 'Last seen: ${report.placeLost}' : 'Location not specified',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textMuted,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Reported: $formattedDate',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFoundCaseCard(finder_models.FinderReportItem report) {
    // Format date
    String formattedDate = 'Unknown date';
    try {
      final date = DateTime.parse(report.createdAt);
      formattedDate = DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      formattedDate = report.createdAt;
    }

    // Display child name or "Unknown Child"
    final displayName = report.childName ?? 'Unknown Child';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: InkWell(
          onTap: () => Get.toNamed('${AppRoutes.finderCaseDetail}?reportId=${report.id}'),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: report.images.isNotEmpty
                      ? Builder(
                          builder: (context) {
                            final imageUrl = report.images.first.imageUrl;
                            print('🖼️ Loading finder image URL: $imageUrl');
                            return Image.network(
                              imageUrl,
                              width: 70.w,
                              height: 70.w,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 70.w,
                                  height: 70.w,
                                  color: Colors.grey[200],
                                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                print('❌ Error loading finder image: $error');
                                return Container(
                                  width: 70.w,
                                  height: 70.w,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.broken_image, color: Colors.grey[600]),
                                );
                              },
                            );
                          },
                        )
                      : Container(
                          width: 70.w,
                          height: 70.w,
                          color: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              displayName,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _buildStatusChip(report.status),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Finder: ${report.finder.name} • ${report.gender ?? "N/A"}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14.w, color: AppColors.primary),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              report.placeFound ?? 'Location not specified',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Reported: $formattedDate',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active':
        color = AppColors.statusActive;
        break;
      case 'investigating':
        color = AppColors.statusInvestigating;
        break;
      case 'resolved':
        color = AppColors.statusResolved;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'critical':
        color = AppColors.error;
        break;
      case 'high':
        color = AppColors.warning;
        break;
      case 'medium':
        color = AppColors.info;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, widget.isInNavigation ? 200.h : 220.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const ReportCardSkeleton();
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, widget.isInNavigation ? 232.h : 252.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80.w,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
