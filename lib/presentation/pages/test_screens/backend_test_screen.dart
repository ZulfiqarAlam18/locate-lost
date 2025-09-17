import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import '../../../data/services/connection_test_service.dart';
import '../../../data/services/base_api_service.dart';

class BackendTestScreen extends StatefulWidget {
  const BackendTestScreen({super.key});

  @override
  State<BackendTestScreen> createState() => _BackendTestScreenState();
}

class _BackendTestScreenState extends State<BackendTestScreen> {
  bool _isTesting = false;
  Map<String, dynamic>? _testResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backend Connection Test'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔍 Backend Connection Test',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'This will test if your Flutter app can communicate with your Node.js backend.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Backend URL: ${BaseApiService.apiBaseUrl}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'monospace',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Test Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _isTesting ? null : _runConnectionTests,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isTesting
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Testing Connection...',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Test Backend Connection',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Results
            if (_testResults != null) ...[
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: _testResults!['overallSuccess'] 
                        ? Colors.green[50] 
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _testResults!['overallSuccess'] 
                          ? Colors.green[300]! 
                          : Colors.red[300]!,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary
                        Text(
                          _testResults!['summary'] ?? 'Test completed',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: _testResults!['overallSuccess'] 
                                ? Colors.green[800] 
                                : Colors.red[800],
                          ),
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        // Individual test results
                        _buildTestResult('Basic Connection', _testResults!['basicConnection']),
                        SizedBox(height: 12.h),
                        _buildTestResult('Health Check', _testResults!['healthCheck']),
                        SizedBox(height: 12.h),
                        _buildTestResult('Auth Endpoint', _testResults!['authEndpoint']),
                        
                        SizedBox(height: 16.h),
                        
                        // Recommendations
                        if (!_testResults!['overallSuccess']) ...[
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.orange[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '💡 Troubleshooting Tips:',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[800],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '1. Make sure your Node.js backend server is running\n'
                                  '2. Check if the IP address (192.168.1.100) is correct\n'
                                  '3. Ensure port 5000 is not blocked by firewall\n'
                                  '4. Try connecting from a browser: http://192.168.1.100:5000\n'
                                  '5. Make sure both devices are on the same network',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.orange[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_find,
                        size: 64.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Click the button above to test\nbackend connectivity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTestResult(String testName, Map<String, dynamic> result) {
    final success = result['success'] ?? false;
    final message = result['message'] ?? 'No message';
    final statusCode = result['statusCode'];
    final responseBody = result['responseBody'];
    
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: success ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: success ? Colors.green[300]! : Colors.red[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: success ? Colors.green[700] : Colors.red[700],
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                testName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 12.sp,
              color: success ? Colors.green[700] : Colors.red[700],
            ),
          ),
          if (statusCode != null) ...[
            SizedBox(height: 4.h),
            Text(
              'Status Code: $statusCode',
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey[600],
                fontFamily: 'monospace',
              ),
            ),
          ],
          // Show detailed server info for successful health check
          if (success && testName == 'Health Check' && responseBody != null) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🚀 LocateLost Backend Server Info:',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    responseBody.toString(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: 'monospace',
                      color: Colors.green[700],
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _runConnectionTests() async {
    setState(() {
      _isTesting = true;
      _testResults = null;
    });

    try {
      final results = await ConnectionTestService.runAllTests();
      setState(() {
        _testResults = results;
      });

      // Show snackbar with results
      Get.snackbar(
        results['overallSuccess'] ? 'Connection Success!' : 'Connection Failed',
        results['summary'],
        backgroundColor: results['overallSuccess'] ? Colors.green : Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        duration: const Duration(seconds: 5),
        icon: Icon(
          results['overallSuccess'] ? Icons.wifi : Icons.wifi_off,
          color: Colors.white,
        ),
      );
    } catch (e) {
      setState(() {
        _testResults = {
          'overallSuccess': false,
          'summary': 'Test failed: $e',
        };
      });
    } finally {
      setState(() {
        _isTesting = false;
      });
    }
  }
}