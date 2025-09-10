import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.primary,
              size: 24.sp,
            ),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: 24.sp,
            ),
            onPressed: () => Get.toNamed('/settings/notifications'),
            tooltip: 'Notification settings',
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllNotifications(),
                  _buildCaseUpdates(),
                  _buildSystemNotifications(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_outlined, size: 16.sp),
                SizedBox(width: 4.w),
                Text('All'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_outlined, size: 16.sp),
                SizedBox(width: 4.w),
                Text('Cases'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.system_update_outlined, size: 16.sp),
                SizedBox(width: 4.w),
                Text('System'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildNotificationCard(
          icon: Icons.location_on_rounded,
          iconColor: AppColors.error,
          title: 'New Case Near You',
          message:
              'A missing child case was reported 2.5 km from your location. Tap to view details.',
          time: '2 minutes ago',
          isUnread: true,
          onTap: () => _handleNotificationTap('case_nearby'),
        ),
        _buildNotificationCard(
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.success,
          title: 'Case Update',
          message:
              'Good news! The missing child from your area has been found safe.',
          time: '1 hour ago',
          isUnread: true,
          onTap: () => _handleNotificationTap('case_resolved'),
        ),
        _buildNotificationCard(
          icon: Icons.security_rounded,
          iconColor: AppColors.primary,
          title: 'Safety Alert',
          message:
              'Increased security measures are active in your area. Stay vigilant.',
          time: '3 hours ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('safety_alert'),
        ),
        _buildNotificationCard(
          icon: Icons.campaign_rounded,
          iconColor: AppColors.info,
          title: 'Community Update',
          message:
              'Join our community meeting about child safety this Saturday at 2 PM.',
          time: '1 day ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('community_update'),
        ),
        _buildNotificationCard(
          icon: Icons.update_rounded,
          iconColor: AppColors.secondary,
          title: 'App Update Available',
          message:
              'Version 2.1.0 is now available with improved safety features.',
          time: '2 days ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('app_update'),
        ),
      ],
    );
  }

  Widget _buildCaseUpdates() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildNotificationCard(
          icon: Icons.location_on_rounded,
          iconColor: AppColors.error,
          title: 'New Missing Person Report',
          message:
              'A 7-year-old child has been reported missing in Sector G-11. Last seen wearing a blue shirt.',
          time: '15 minutes ago',
          isUnread: true,
          onTap: () => _handleNotificationTap('new_case'),
        ),
        _buildNotificationCard(
          icon: Icons.search_rounded,
          iconColor: AppColors.warning,
          title: 'Search Area Update',
          message:
              'Search teams are now focusing on Margalla Hills area. Volunteers needed.',
          time: '45 minutes ago',
          isUnread: true,
          onTap: () => _handleNotificationTap('search_update'),
        ),
        _buildNotificationCard(
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.success,
          title: 'Case Resolved',
          message:
              'Ahmed Ali (8 years old) has been found safe and reunited with family.',
          time: '2 hours ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('case_resolved'),
        ),
        _buildNotificationCard(
          icon: Icons.people_outline_rounded,
          iconColor: AppColors.primary,
          title: 'Match Found',
          message:
              'A potential match has been found for the missing person case #MP2024001.',
          time: '5 hours ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('match_found'),
        ),
      ],
    );
  }

  Widget _buildSystemNotifications() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildNotificationCard(
          icon: Icons.security_rounded,
          iconColor: AppColors.primary,
          title: 'Location Permission',
          message:
              'Please enable location services for better case matching and alerts.',
          time: '30 minutes ago',
          isUnread: true,
          onTap: () => _handleNotificationTap('location_permission'),
        ),
        _buildNotificationCard(
          icon: Icons.backup_rounded,
          iconColor: AppColors.info,
          title: 'Data Backup Complete',
          message:
              'Your data has been successfully backed up to secure cloud storage.',
          time: '6 hours ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('backup_complete'),
        ),
        _buildNotificationCard(
          icon: Icons.update_rounded,
          iconColor: AppColors.secondary,
          title: 'System Maintenance',
          message:
              'Scheduled maintenance will occur tonight from 2 AM to 4 AM.',
          time: '1 day ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('maintenance'),
        ),
        _buildNotificationCard(
          icon: Icons.verified_user_rounded,
          iconColor: AppColors.success,
          title: 'Account Verified',
          message:
              'Your account has been successfully verified. All features are now available.',
          time: '3 days ago',
          isUnread: false,
          onTap: () => _handleNotificationTap('account_verified'),
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border:
              isUnread
                  ? Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 1.w,
                  )
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 24.sp),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight:
                                      isUnread
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap(String notificationType) {
    // Handle different notification types
    switch (notificationType) {
      case 'case_nearby':
      case 'new_case':
        Get.toNamed('/case-details');
        break;
      case 'case_resolved':
        Get.toNamed('/my-cases');
        break;
      case 'safety_alert':
        Get.toNamed('/emergency');
        break;
      case 'location_permission':
        // Request location permission
        _requestLocationPermission();
        break;
      case 'app_update':
        _showUpdateDialog();
        break;
      default:
        Get.snackbar(
          'Notification',
          'Notification tapped: $notificationType',
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 2),
        );
    }
  }

  void _markAllAsRead() {
    Get.snackbar(
      'Success',
      'All notifications marked as read',
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 2),
      icon: Icon(Icons.check_circle_rounded, color: Colors.white, size: 24.sp),
    );

    // Refresh the screen to show all notifications as read
    setState(() {});
  }

  void _requestLocationPermission() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 48.sp,
                color: AppColors.primary,
              ),
              SizedBox(height: 16.h),
              Text(
                'Enable Location',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Allow location access to receive nearby case alerts and improve matching accuracy.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Not Now',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        // Implement location permission request
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Enable',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.system_update_rounded,
                size: 48.sp,
                color: AppColors.info,
              ),
              SizedBox(height: 16.h),
              Text(
                'Update Available',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Version 2.1.0 includes improved safety features and bug fixes.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Later',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        // Implement app update
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.info,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
