import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_app_bar.dart';
import 'package:locate_lost/presentation/widgets/main_bottom_navigation.dart';
import 'package:locate_lost/presentation/widgets/skeleton_loader.dart';

class MyCasesScreen extends StatefulWidget {
  final bool isInNavigation;
  
  const MyCasesScreen({super.key, this.isInNavigation = false});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  late MainNavigationController navController;

  // Dummy data for demonstration
  final List<Map<String, dynamic>> missingCases = [
    {
      'id': 'MP-001',
      'name': 'Emma Johnson',
      'age': 8,
      'status': 'Active',
      'lastSeen': 'Riverside Park',
      'date': '01/08/2025',
      'image': 'assets/images/ali.png',
      'priority': 'Critical',
    },
    {
      'id': 'MP-002',
      'name': 'Alex Smith',
      'age': 12,
      'status': 'Investigating',
      'lastSeen': 'School',
      'date': '28/07/2025',
      'image': 'assets/images/zulfiqar.png',
      'priority': 'High',
    },
  ];

  final List<Map<String, dynamic>> foundCases = [
    {
      'id': 'FP-001',
      'name': 'Sarah Wilson',
      'age': 10,
      'status': 'Found',
      'location': 'Mall Center',
      'date': '30/07/2025',
      'image': 'assets/images/bg.png',
      'finder': 'John Doe',
    },
  ];

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
    
    if (!widget.isInNavigation) {
      navController.setIndex(1); // Set My Cases as active only if not in navigation wrapper
    }
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
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
        onPressed: () {},
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
    
    
      // extendBody: !widget.isInNavigation,
      // bottomNavigationBar: widget.isInNavigation ? null : Obx(() => MainBottomNavigation(
      //   currentIndex: navController.selectedIndex.value,
      //   onTap: navController.changeIndex,
      // )),


    );
  }

  Widget _buildMissingCasesTab() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (missingCases.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_search,
        title: 'No Missing Cases',
        subtitle: 'You haven\'t reported any missing cases yet.',
        buttonText: 'Report Missing Person',
        onPressed: () => Get.toNamed(AppRoutes.reportCase),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData();
      },
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, widget.isInNavigation ? 200.h : 220.h),
        itemCount: missingCases.length,
        itemBuilder: (context, index) {
          final caseData = missingCases[index];
          return _buildMissingCaseCard(caseData);
        },
      ),
    );
  }

  Widget _buildFoundCasesTab() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (foundCases.isEmpty) {
      return _buildEmptyState(
        icon: Icons.camera_alt,
        title: 'No Found Cases',
        subtitle: 'You haven\'t reported any found cases yet.',
        buttonText: 'Report Found Person',
        onPressed: () => Get.toNamed(AppRoutes.foundPersonDetails),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData();
      },
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, widget.isInNavigation ? 200.h : 220.h),
        itemCount: foundCases.length,
        itemBuilder: (context, index) {
          final caseData = foundCases[index];
          return _buildFoundCaseCard(caseData);
        },
      ),
    );
  }

  Widget _buildMissingCaseCard(Map<String, dynamic> caseData) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: InkWell(
          onTap: () => Get.toNamed(AppRoutes.parentCaseSummary),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    caseData['image'],
                    width: 70.w,
                    height: 70.w,
                    fit: BoxFit.cover,
                    semanticLabel: 'Photo of ${caseData['name']}',
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
                          Text(
                            caseData['name'],
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          _buildPriorityChip(caseData['priority']),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Age: ${caseData['age']} • ID: ${caseData['id']}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildStatusChip(caseData['status']),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Last seen: ${caseData['lastSeen']}',
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
                        'Reported: ${caseData['date']}',
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

  Widget _buildFoundCaseCard(Map<String, dynamic> caseData) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: InkWell(
          onTap: () => Get.toNamed(AppRoutes.finderCaseSummary),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    caseData['image'],
                    width: 70.w,
                    height: 70.w,
                    fit: BoxFit.cover,
                    semanticLabel: 'Photo of found person',
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
                          Text(
                            caseData['name'],
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              'FOUND',
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
                        'Age: ${caseData['age']} • ID: ${caseData['id']}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Found at: ${caseData['location']}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Reported: ${caseData['date']} • By: ${caseData['finder']}',
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
