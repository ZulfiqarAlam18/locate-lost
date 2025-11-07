import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_colors.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Privacy settings
  bool _locationSharing = true;
  bool _dataSharing = false;
  bool _analyticsSharing = true;
  bool _profileVisibility = true;
  bool _twoFactorAuth = false;
  bool _biometricLogin = true;
  bool _loginNotifications = true;
  
  // Data retention
  String _dataRetention = '1 year';
  bool _autoDeleteOldCases = true;

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
          'Privacy & Security',
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
                // Privacy Controls
                _buildPrivacySection(),

                SizedBox(height: 24.h),

                // Security Settings
                _buildSecuritySection(),

                SizedBox(height: 24.h),

                // Data Management
                _buildDataManagementSection(),

                SizedBox(height: 24.h),

                // Account Security
                _buildAccountSecuritySection(),

                SizedBox(height: 32.h),

                // Save Button
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySection() {
    return _buildSection(
      'Privacy Controls',
      Icons.privacy_tip,
      AppColors.warning,
      Column(
        children: [
          _buildSwitchTile(
            'Location Sharing',
            'Allow the app to access your location for finding nearby cases',
            _locationSharing,
            (value) => setState(() => _locationSharing = value),
            isImportant: true,
          ),
          _buildSwitchTile(
            'Profile Visibility',
            'Make your profile visible to other users',
            _profileVisibility,
            (value) => setState(() => _profileVisibility = value),
          ),
          _buildSwitchTile(
            'Data Sharing with Partners',
            'Share anonymized data with trusted partners',
            _dataSharing,
            (value) => setState(() => _dataSharing = value),
          ),
          _buildSwitchTile(
            'Analytics & Performance',
            'Help improve the app by sharing usage analytics',
            _analyticsSharing,
            (value) => setState(() => _analyticsSharing = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return _buildSection(
      'Security Settings',
      Icons.security,
      AppColors.error,
      Column(
        children: [
          _buildSwitchTile(
            'Two-Factor Authentication',
            'Add an extra layer of security to your account',
            _twoFactorAuth,
            (value) => _show2FADialog(value),
            isSecurityFeature: true,
          ),
          _buildSwitchTile(
            'Biometric Login',
            'Use fingerprint or face recognition to sign in',
            _biometricLogin,
            (value) => setState(() => _biometricLogin = value),
          ),
          _buildSwitchTile(
            'Login Notifications',
            'Get notified when someone signs in to your account',
            _loginNotifications,
            (value) => setState(() => _loginNotifications = value),
          ),
          
          SizedBox(height: 16.h),
          
          // Security Actions
          _buildSecurityAction(
            'Change Password',
            'Update your account password',
            Icons.lock_outline,
            () => _navigateToChangePassword(),
          ),
          _buildSecurityAction(
            'View Login History',
            'See recent account activity',
            Icons.history,
            () => _showLoginHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
    return _buildSection(
      'Data Management',
      Icons.storage,
      AppColors.info,
      Column(
        children: [
          // Data Retention Selector
          InkWell(
            onTap: _showDataRetentionPicker,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: AppColors.info,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data Retention Period',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Keep data for $_dataRetention',
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
          ),
          
          SizedBox(height: 16.h),
          
          _buildSwitchTile(
            'Auto-delete Old Cases',
            'Automatically delete resolved cases after retention period',
            _autoDeleteOldCases,
            (value) => setState(() => _autoDeleteOldCases = value),
          ),
          
          SizedBox(height: 16.h),
          
          // Data Export Action
          _buildDataAction(
            'Export My Data',
            'Download all your account data',
            Icons.download,
            AppColors.primary,
            () => _exportData(),
          ),
          _buildDataAction(
            'Delete My Data',
            'Permanently delete all your data',
            Icons.delete_forever,
            AppColors.error,
            () => _showDeleteDataDialog(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSecuritySection() {
    return _buildSection(
      'Account Security',
      Icons.account_circle,
      AppColors.success,
      Column(
        children: [
          // Security Score
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield,
                  color: AppColors.success,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Score',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            '8/10',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Strong',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _showSecurityTips,
                  child: Text(
                    'Improve',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Active Sessions
          _buildSecurityAction(
            'Active Sessions',
            'Manage your active login sessions',
            Icons.devices,
            () => _showActiveSessions(),
          ),
          _buildSecurityAction(
            'Security Checkup',
            'Review and improve your security settings',
            Icons.security,
            () => _runSecurityCheckup(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, Widget child) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, _) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
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
                Row(
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
                
                SizedBox(height: 16.h),
                
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged, {
    bool isImportant = false,
    bool isSecurityFeature = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: isImportant
              ? AppColors.warning.withOpacity(0.3)
              : isSecurityFeature
                  ? AppColors.error.withOpacity(0.3)
                  : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: isImportant
            ? AppColors.warning.withOpacity(0.05)
            : isSecurityFeature
                ? AppColors.error.withOpacity(0.05)
                : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isImportant || isSecurityFeature) ...[
                      SizedBox(width: 8.w),
                      Icon(
                        isImportant ? Icons.location_on : Icons.security,
                        color: isImportant ? AppColors.warning : AppColors.error,
                        size: 16.sp,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityAction(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
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

  Widget _buildDataAction(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDestructive ? AppColors.error.withOpacity(0.3) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isDestructive ? AppColors.error.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? AppColors.error : AppColors.textPrimary,
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

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveSettings,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
        ),
        child: Text(
          'Save Privacy Settings',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Dialog and Action Methods
  void _show2FADialog(bool enable) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          enable ? 'Enable 2FA' : 'Disable 2FA',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          enable
              ? 'Two-factor authentication adds an extra layer of security. You\'ll need your phone to sign in.'
              : 'Are you sure you want to disable two-factor authentication? This will make your account less secure.',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _twoFactorAuth = enable);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    enable ? '2FA enabled successfully' : '2FA disabled',
                  ),
                  backgroundColor: enable ? AppColors.success : AppColors.warning,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: enable ? AppColors.success : AppColors.warning,
            ),
            child: Text(enable ? 'Enable' : 'Disable'),
          ),
        ],
      ),
    );
  }

  void _showDataRetentionPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Retention Period',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...['6 months', '1 year', '2 years', '5 years', 'Forever'].map(
              (period) => ListTile(
                title: Text(period),
                trailing: period == _dataRetention
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _dataRetention = period);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error),
            SizedBox(width: 8.w),
            Text(
              'Delete All Data',
              style: TextStyle(color: AppColors.error),
            ),
          ],
        ),
        content: Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Data deletion initiated. You will receive an email confirmation.'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Placeholder methods for actions
  void _navigateToChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to change password...')),
    );
  }

  void _showLoginHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Showing login history...')),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data export started. You will receive an email with download link.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showActiveSessions() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Showing active sessions...')),
    );
  }

  void _runSecurityCheckup() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Running security checkup...')),
    );
  }

  void _showSecurityTips() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Showing security improvement tips...')),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Privacy settings saved successfully'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
