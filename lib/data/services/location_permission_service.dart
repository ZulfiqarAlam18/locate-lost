import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/core/constants/app_colors.dart';
import 'package:locat_lost/navigation/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionService {
  static bool _hasCheckedThisSession = false;
  
  /// Check if location permission check has already been done this session
  static bool get hasCheckedThisSession => _hasCheckedThisSession;
  
  /// Reset the session check (call this on app restart or logout)
  static void resetSessionCheck() {
    _hasCheckedThisSession = false;
  }
  
  /// Force check location permission (for manual triggers from settings)
  static Future<void> forceCheckLocationPermission() async {
    _hasCheckedThisSession = false;
    await checkLocationPermissionAfterLogin();
  }
  
  /// Get current location permission status
  static Future<PermissionStatus> getCurrentLocationStatus() async {
    return await Permission.location.status;
  }
  
  /// Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.location.status;
    return status == PermissionStatus.granted || status == PermissionStatus.limited;
  }
  
  /// Main method to check and handle location permissions after login
  static Future<void> checkLocationPermissionAfterLogin() async {
    // Skip if already checked this session
    if (_hasCheckedThisSession) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    
    final status = await Permission.location.status;
    
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // Permission already granted, go to home
        _hasCheckedThisSession = true;
        Get.offAllNamed(AppRoutes.home);
        break;
        
      case PermissionStatus.denied:
        // Show explanation dialog
        _showLocationPermissionDialog();
        break;
        
      case PermissionStatus.permanentlyDenied:
        // Show settings dialog
        _showPermanentlyDeniedDialog();
        break;
        
      case PermissionStatus.restricted:
        // iOS only - show restricted dialog
        _showRestrictedDialog();
        break;
        
      default:
        // Unknown status, proceed to home
        _hasCheckedThisSession = true;
        Get.offAllNamed(AppRoutes.home);
    }
  }
  
  /// Show the friendly explanation dialog for location permission
  static void _showLocationPermissionDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 40.sp,
                  color: AppColors.primary,
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // Title
              Text(
                'Enable Location Services',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Description
              Text(
                'LocateLost needs access to your location to:',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Benefits list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBenefitItem('📍 Help match found and missing children in your area'),
                  _buildBenefitItem('🚨 Quickly notify nearby authorities and volunteers'),
                  _buildBenefitItem('📱 Send precise location data in emergency situations'),
                  _buildBenefitItem('🗺️ Show relevant cases and safe zones near you'),
                ],
              ),
              
              SizedBox(height: 24.h),
              
              // Note
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[600], size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Your location is only used for safety features and is never shared without your consent.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        _skipLocationPermission();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        'Not Now',
                        style: TextStyle(
                          fontSize: 16.sp,
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
                        _requestLocationPermission();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Allow Location',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  /// Show dialog when permission is permanently denied
  static void _showPermanentlyDeniedDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 40.sp,
                  color: Colors.orange[700],
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // Title
              Text(
                'Location Access Needed',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Description
              Text(
                'Location permission has been permanently denied. To enable location services for better safety features, please:',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 20.h),
              
              // Steps
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps to enable:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[800],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '1. Tap "Open Settings" below\n2. Find "Permissions" or "App Permissions"\n3. Enable "Location" permission\n4. Return to the app',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.orange[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        _skipLocationPermission();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        'Continue Without',
                        style: TextStyle(
                          fontSize: 16.sp,
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
                        _openAppSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Open Settings',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  /// Show dialog when permission is restricted (iOS only)
  static void _showRestrictedDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.block,
                  size: 40.sp,
                  color: Colors.red[700],
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // Title
              Text(
                'Location Restricted',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Description
              Text(
                'Location services are restricted on this device. This may be due to parental controls or device management policies.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24.h),
              
              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _skipLocationPermission();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  /// Request location permission
  static Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    
    _hasCheckedThisSession = true;
    
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // Permission granted, show success and go to home
        Get.snackbar(
          'Location Enabled',
          'Location services are now enabled for better safety features!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        Get.offAllNamed(AppRoutes.home);
        break;
        
      case PermissionStatus.denied:
        // User denied, but can ask again later
        Get.offAllNamed(AppRoutes.home);
        break;
        
      case PermissionStatus.permanentlyDenied:
        // Show settings dialog
        _showPermanentlyDeniedDialog();
        break;
        
      default:
        Get.offAllNamed(AppRoutes.home);
    }
  }
  
  /// Skip location permission and go to home
  static void _skipLocationPermission() {
    _hasCheckedThisSession = true;
    Get.offAllNamed(AppRoutes.home);
  }
  
  /// Open app settings
  static Future<void> _openAppSettings() async {
    final opened = await openAppSettings();
    if (!opened) {
      Get.snackbar(
        'Cannot Open Settings',
        'Please manually open app settings to enable location permission.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    _skipLocationPermission();
  }
  
  /// Helper method to build benefit items in the dialog
  static Widget _buildBenefitItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(top: 8.h, right: 12.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
