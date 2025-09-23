import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

enum LocationCheckResult {
  enabled,
  serviceDisabled,
  permissionDenied,
}

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
  
  /// Comprehensive location check - both services and permissions
  static Future<LocationCheckResult> checkFullLocationStatus() async {
    final isServiceEnabled = await isLocationServiceEnabled();
    final isPermissionGranted = await isLocationPermissionGranted();
    
    if (!isServiceEnabled) {
      return LocationCheckResult.serviceDisabled;
    } else if (!isPermissionGranted) {
      return LocationCheckResult.permissionDenied;
    } else {
      return LocationCheckResult.enabled;
    }
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
  
  /// Check if device location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  
  /// Main method to check and handle location permissions after login
  static Future<void> checkLocationPermissionAfterLogin() async {
    // Skip if already checked this session
    if (_hasCheckedThisSession) {
      // Even if checked this session, verify location is still enabled
      final isServiceEnabled = await isLocationServiceEnabled();
      final isPermissionGranted = await isLocationPermissionGranted();
      
      if (isServiceEnabled && isPermissionGranted) {
        Get.offAllNamed(AppRoutes.home);
        return;
      } else {
        // Reset session check if location is disabled
        _hasCheckedThisSession = false;
      }
    }
    
    // First check if location services are enabled on the device
    final isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showLocationServiceDisabledDialog();
      return;
    }
    
    // Then check app permissions
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
        // Unknown status, show explanation dialog
        _showLocationPermissionDialog();
    }
  }
  
  /// Show dialog when device location services are disabled
  static void _showLocationServiceDisabledDialog() {
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
                  Icons.location_disabled_outlined,
                  size: 40.sp,
                  color: Colors.red[700],
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // Title
              Text(
                'Location Services Disabled',
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
                'LocateLost requires location services to be enabled on your device to help find missing children safely.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 20.h),
              
              // Critical features notice
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Colors.red[600], size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'This app cannot work without location!',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'To enable location services:\n1. Go to your device Settings\n2. Find "Location" or "Location Services"\n3. Turn on Location Services\n4. Return to this app',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.red[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Buttons
              Column(
                children: [
                  // Primary button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        // Recheck after user potentially enabled location
                        await checkLocationPermissionAfterLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'I\'ve Enabled Location Services',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Secondary button - exit app
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Close the app since location is mandatory
                        Get.dialog(
                          AlertDialog(
                            title: Text('Exit App?'),
                            content: Text('Location services are required for this app to function. The app will close now.'),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Force close the app
                                  Get.back();
                                  Get.back();
                                  // You might want to use SystemNavigator.pop() or exit(0) here
                                },
                                child: Text('Exit App'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        'Exit App',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
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
    // First check if location services are enabled
    final isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showLocationServiceDisabledDialog();
      return;
    }
    
    final status = await Permission.location.request();
    
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // Permission granted, double-check location services are still enabled
        final stillEnabled = await isLocationServiceEnabled();
        if (stillEnabled) {
          _hasCheckedThisSession = true;
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
        } else {
          _showLocationServiceDisabledDialog();
        }
        break;
        
      case PermissionStatus.denied:
        // User denied, but can ask again later - but still need location services
        _showLocationPermissionDialog();
        break;
        
      case PermissionStatus.permanentlyDenied:
        // Show settings dialog
        _showPermanentlyDeniedDialog();
        break;
        
      default:
        _showLocationPermissionDialog();
    }
  }
  
  /// Skip location permission with warning
  static void _skipLocationPermission() async {
    // Check if location services are enabled on device
    final isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showLocationServiceDisabledDialog();
      return;
    }
    
    // Show a warning dialog before allowing to skip
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Icon(
                Icons.warning_amber_rounded,
                size: 48.sp,
                color: Colors.orange[600],
              ),
              
              SizedBox(height: 16.h),
              
              // Title
              Text(
                'Limited App Functionality',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 12.h),
              
              // Warning message
              Text(
                'Without location access, you will miss important features:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 16.h),
              
              // Missing features list
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  children: [
                    _buildMissingFeatureItem('📍 Nearby missing person alerts'),
                    _buildMissingFeatureItem('🚨 Location-based emergency notifications'),
                    _buildMissingFeatureItem('📊 Accurate found person reporting'),
                    _buildMissingFeatureItem('🗺️ Map-based case matching'),
                  ],
                ),
              ),
              
              SizedBox(height: 20.h),
              
              Text(
                'You can enable location later in app settings.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        _proceedWithoutLocation();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        'Continue Without',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
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
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Enable Location',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
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
  
  /// Actually proceed without location after warning
  static void _proceedWithoutLocation() async {
    // Final check - if location services are disabled, don't allow proceeding
    final isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showLocationServiceDisabledDialog();
      return;
    }
    
    _hasCheckedThisSession = true;
    Get.offAllNamed(AppRoutes.home);
  }
  
  /// Helper method to build missing feature items
  static Widget _buildMissingFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(Icons.remove, color: Colors.red[600], size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
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
    // After settings, recheck the entire location flow instead of proceeding without
    await checkLocationPermissionAfterLogin();
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
