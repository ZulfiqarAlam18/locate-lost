import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class DangerZoneSettingsScreen extends StatefulWidget {
  const DangerZoneSettingsScreen({super.key});

  @override
  State<DangerZoneSettingsScreen> createState() => _DangerZoneSettingsScreenState();
}

class _DangerZoneSettingsScreenState extends State<DangerZoneSettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _confirmationController = TextEditingController();
  bool _understandConsequences = false;

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
    _confirmationController.dispose();
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
          'Danger Zone',
          style: TextStyle(
            color: AppColors.error,
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
                // Warning Section
                _buildWarningSection(),

                SizedBox(height: 24.h),

                // Destructive Actions
                _buildDestructiveActionsSection(),

                SizedBox(height: 24.h),

                // Data Management
                _buildDataManagementSection(),

                SizedBox(height: 24.h),

                // Account Termination
                _buildAccountTerminationSection(),

                SizedBox(height: 32.h),

                // Emergency Contact
                _buildEmergencyContactSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarningSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.error, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Warning Icon
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              Icons.warning,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          Text(
            'DANGER ZONE',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.error,
              letterSpacing: 1.2,
            ),
          ),
          
          SizedBox(height: 12.h),
          
          Text(
            'The actions in this section are irreversible and may result in permanent data loss. Proceed with extreme caution.',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textPrimary,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16.h),
          
          // Warning Points
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.error.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Before proceeding, please note:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildWarningPoint('• All data will be permanently deleted'),
                _buildWarningPoint('• Active cases will be closed'),
                _buildWarningPoint('• Account recovery may not be possible'),
                _buildWarningPoint('• Connected devices will be signed out'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestructiveActionsSection() {
    return _buildSection(
      'Destructive Actions',
      Icons.delete_forever,
      AppColors.error,
      Column(
        children: [
          _buildDestructiveAction(
            'Clear All Data',
            'Remove all your personal data while keeping the account',
            Icons.clear_all,
            AppColors.warning,
            () => _showClearDataDialog(),
            severity: 'Medium',
          ),
          
          SizedBox(height: 16.h),
          
          _buildDestructiveAction(
            'Reset Account',
            'Reset account to default settings and clear all data',
            Icons.refresh,
            AppColors.error,
            () => _showResetAccountDialog(),
            severity: 'High',
          ),
          
          SizedBox(height: 16.h),
          
          _buildDestructiveAction(
            'Close All Cases',
            'Permanently close all your active cases',
            Icons.close,
            AppColors.warning,
            () => _showCloseAllCasesDialog(),
            severity: 'Medium',
          ),
          
          SizedBox(height: 16.h),
          
          _buildDestructiveAction(
            'Revoke All Access',
            'Sign out from all devices and revoke all permissions',
            Icons.security,
            AppColors.info,
            () => _showRevokeAccessDialog(),
            severity: 'Low',
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection() {
    return _buildSection(
      'Data Management',
      Icons.storage,
      AppColors.warning,
      Column(
        children: [
          // Data Export Before Deletion
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.download,
                  color: AppColors.info,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Export Data First',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Consider exporting your data before performing destructive actions.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _exportAllData,
                  child: Text(
                    'Export',
                    style: TextStyle(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Data Retention Information
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.warning,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Data Retention Policy',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _buildDataRetentionItem('Personal Information', '30 days after deletion'),
                _buildDataRetentionItem('Case Data', 'Immediately deleted'),
                _buildDataRetentionItem('Chat History', '7 days (for safety)'),
                _buildDataRetentionItem('Location Data', 'Immediately deleted'),
                _buildDataRetentionItem('Analytics Data', 'Anonymized after 90 days'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTerminationSection() {
    return _buildSection(
      'Account Termination',
      Icons.person_remove,
      AppColors.error,
      Column(
        children: [
          // Final Warning
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.error.withOpacity(0.5), width: 2),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person_off,
                  color: AppColors.error,
                  size: 48.sp,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Delete Account Permanently',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'This action cannot be undone. Your account and all associated data will be permanently deleted.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 20.h),
                
                // Confirmation Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _understandConsequences,
                      onChanged: (value) => setState(() => _understandConsequences = value!),
                      activeColor: AppColors.error,
                    ),
                    Expanded(
                      child: Text(
                        'I understand the consequences of this action',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // Delete Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _understandConsequences ? _showDeleteAccountDialog : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_forever,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Delete Account Permanently',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactSection() {
    return _buildSection(
      'Emergency Support',
      Icons.support_agent,
      AppColors.info,
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.info.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.info.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.headset_mic,
              color: AppColors.info,
              size: 32.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'If you\'re having issues or made a mistake, our support team is here to help.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _contactEmergencySupport,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.info),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Contact Support',
                      style: TextStyle(color: AppColors.info),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _callEmergencyHotline,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Emergency Call',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildWarningPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildDestructiveAction(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    required String severity,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
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
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(severity),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          severity,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
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

  Widget _buildDataRetentionItem(String type, String duration) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: AppColors.warning,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            duration,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Low':
        return AppColors.success;
      case 'Medium':
        return AppColors.warning;
      case 'High':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  // Dialog Methods
  void _showClearDataDialog() {
    _showConfirmationDialog(
      'Clear All Data',
      'This will remove all your personal data while keeping your account active. You can continue using the app but will need to set up your profile again.',
      'CLEAR DATA',
      AppColors.warning,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All data cleared successfully'),
            backgroundColor: AppColors.warning,
          ),
        );
      },
    );
  }

  void _showResetAccountDialog() {
    _showConfirmationDialog(
      'Reset Account',
      'This will reset your account to default settings and clear all data. This action cannot be undone.',
      'RESET ACCOUNT',
      AppColors.error,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account reset initiated'),
            backgroundColor: AppColors.error,
          ),
        );
      },
    );
  }

  void _showCloseAllCasesDialog() {
    _showConfirmationDialog(
      'Close All Cases',
      'This will permanently close all your active cases. Closed cases cannot be reopened.',
      'CLOSE ALL CASES',
      AppColors.warning,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All cases closed'),
            backgroundColor: AppColors.warning,
          ),
        );
      },
    );
  }

  void _showRevokeAccessDialog() {
    _showConfirmationDialog(
      'Revoke All Access',
      'This will sign you out from all devices and revoke all app permissions. You will need to sign in again.',
      'REVOKE ACCESS',
      AppColors.info,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All access revoked. Please sign in again.'),
            backgroundColor: AppColors.info,
          ),
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'Delete Account',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To confirm account deletion, type "DELETE MY ACCOUNT" below:',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _confirmationController,
              decoration: InputDecoration(
                hintText: 'DELETE MY ACCOUNT',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.error),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Text(
                'This action is irreversible. All your data will be permanently deleted.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _confirmationController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_confirmationController.text == 'DELETE MY ACCOUNT') {
                Navigator.pop(context);
                _confirmationController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Account deletion initiated. You will receive an email confirmation.'),
                    backgroundColor: AppColors.error,
                    duration: Duration(seconds: 5),
                  ),
                );
                // Navigate back to login or close app
                Get.offAllNamed('/login');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please type "DELETE MY ACCOUNT" exactly as shown'),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Delete Forever', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
    String title,
    String message,
    String confirmText,
    Color color,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary,
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
              onConfirm();
            },
            style: ElevatedButton.styleFrom(backgroundColor: color),
            child: Text(
              confirmText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Action Methods
  void _exportAllData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data export started. You will receive an email with download link.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _contactEmergencySupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Connecting to emergency support...')),
    );
  }

  void _callEmergencyHotline() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling emergency hotline: +1 (800) 123-4567'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
