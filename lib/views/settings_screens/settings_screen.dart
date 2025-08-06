import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Account Section
                _buildSettingsSection(
                  'Account',
                  Icons.person_outline,
                  AppColors.primary,
                  [
                    _buildSettingsItem(
                      'Edit Profile',
                      'Manage your personal information',
                      Icons.edit,
                      () => Get.toNamed(AppRoutes.settingsAccount),
                    ),
                    _buildSettingsItem(
                      'Change Password',
                      'Update your account security',
                      Icons.lock_outline,
                      () => Get.toNamed(AppRoutes.settingsAccount),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Notifications Section
                _buildSettingsSection(
                  'Notifications',
                  Icons.notifications_outlined,
                  AppColors.accent,
                  [
                    _buildSettingsItem(
                      'Notification Preferences',
                      'Manage alerts and updates',
                      Icons.tune,
                      () => Get.toNamed(AppRoutes.settingsNotifications),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Appearance Section
                _buildSettingsSection(
                  'Appearance',
                  Icons.palette_outlined,
                  AppColors.info,
                  [
                    _buildSettingsItem(
                      'Theme & Display',
                      'Customize app appearance',
                      Icons.brightness_6,
                      () => Get.toNamed(AppRoutes.settingsAppearance),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Privacy & Security Section
                _buildSettingsSection(
                  'Privacy & Security',
                  Icons.security,
                  AppColors.warning,
                  [
                    _buildSettingsItem(
                      'Privacy Settings',
                      'Control your data and privacy',
                      Icons.privacy_tip_outlined,
                      () => Get.toNamed(AppRoutes.settingsPrivacy),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Language Section
                _buildSettingsSection(
                  'Language',
                  Icons.language,
                  AppColors.success,
                  [
                    _buildSettingsItem(
                      'Language & Region',
                      'Select your preferred language',
                      Icons.translate,
                      () => Get.toNamed(AppRoutes.settingsLanguage),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Support Section
                _buildSettingsSection(
                  'Support',
                  Icons.help_outline,
                  AppColors.primary,
                  [
                    _buildSettingsItem(
                      'Help & FAQ',
                      'Get help and find answers',
                      Icons.quiz,
                      () => Get.toNamed(AppRoutes.faqs),
                    ),
                    _buildSettingsItem(
                      'Report an Issue',
                      'Report bugs or problems',
                      Icons.bug_report,
                      () => Get.toNamed(AppRoutes.settingsSupport),
                    ),
                    _buildSettingsItem(
                      'Send Feedback',
                      'Help us improve the app',
                      Icons.feedback,
                      () => Get.toNamed(AppRoutes.settingsSupport),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // About Section
                _buildSettingsSection(
                  'About',
                  Icons.info_outline,
                  AppColors.accent,
                  [
                    _buildSettingsItem(
                      'App Information',
                      'Version, terms, and policies',
                      Icons.info,
                      () => Get.toNamed(AppRoutes.settingsAbout),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Danger Zone Section
                _buildSettingsSection(
                  'Danger Zone',
                  Icons.warning,
                  AppColors.error,
                  [
                    _buildSettingsItem(
                      'Export Data',
                      'Download your account data',
                      Icons.download,
                      () => Get.toNamed(AppRoutes.settingsDangerZone),
                      isDestructive: false,
                    ),
                    _buildSettingsItem(
                      'Delete Account',
                      'Permanently delete your account',
                      Icons.delete_forever,
                      () => Get.toNamed(AppRoutes.settingsDangerZone),
                      isDestructive: true,
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Logout Button
                _buildLogoutButton(),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> items,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Header
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Section Items
                ...items,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[200]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? AppColors.error : AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDestructive
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * value),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showLogoutDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAllNamed(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
