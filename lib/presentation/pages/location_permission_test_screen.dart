import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/data/services/location_permission_service.dart';

import '../../data/services/location_permission_service.dart' show LocationPermissionService;

class LocationPermissionTestScreen extends StatefulWidget {
  const LocationPermissionTestScreen({super.key});

  @override
  State<LocationPermissionTestScreen> createState() => _LocationPermissionTestScreenState();
}

class _LocationPermissionTestScreenState extends State<LocationPermissionTestScreen> {
  String _currentStatus = 'Unknown';
  bool _hasCheckedThisSession = false;

  @override
  void initState() {
    super.initState();
    _updateStatus();
  }

  Future<void> _updateStatus() async {
    final status = await LocationPermissionService.getCurrentLocationStatus();
    final hasChecked = LocationPermissionService.hasCheckedThisSession;
    
    setState(() {
      _currentStatus = status.toString().split('.').last;
      _hasCheckedThisSession = hasChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Permission Test'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text('Permission Status: $_currentStatus'),
                    Text('Session Checked: $_hasCheckedThisSession'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Test Buttons
            Text(
              'Test Actions',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            ElevatedButton(
              onPressed: () async {
                await LocationPermissionService.checkLocationPermissionAfterLogin();
                _updateStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('Trigger Location Check (Normal)'),
            ),
            
            SizedBox(height: 12.h),
            
            ElevatedButton(
              onPressed: () async {
                await LocationPermissionService.forceCheckLocationPermission();
                _updateStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('Force Location Check'),
            ),
            
            SizedBox(height: 12.h),
            
            ElevatedButton(
              onPressed: () {
                LocationPermissionService.resetSessionCheck();
                _updateStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('Reset Session Check'),
            ),
            
            SizedBox(height: 12.h),
            
            ElevatedButton(
              onPressed: _updateStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('Refresh Status'),
            ),
            
            SizedBox(height: 24.h),
            
            // Instructions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Test:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '1. Use "Trigger Location Check" to simulate login flow\n'
                      '2. "Force Check" bypasses session check\n'
                      '3. "Reset Session" allows testing multiple times\n'
                      '4. Test different permission states in device settings',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
