import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/dialog_utils.dart';
import '../utils/app_colors.dart';

class DialogDemoScreen extends StatelessWidget {
  const DialogDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog Demo'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.h),
            
            Text(
              'Case Submission Dialogs',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 40.h),
            
            // Success Dialog Button
            ElevatedButton(
              onPressed: () {
                DialogUtils.showCaseSubmissionSuccess();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Show Success Dialog',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Error Dialog Button
            ElevatedButton(
              onPressed: () {
                DialogUtils.showCaseSubmissionError();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Show Error Dialog',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Custom Success Dialog Button
            ElevatedButton(
              onPressed: () {
                DialogUtils.showCaseSubmissionSuccess(
                  title: 'Missing Person Report Submitted!',
                  message: 'Your missing person report has been successfully submitted to our database. We will notify you immediately if there are any matches or updates.',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Show Custom Success Dialog',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Custom Error Dialog Button
            ElevatedButton(
              onPressed: () {
                DialogUtils.showCaseSubmissionError(
                  title: 'Network Error',
                  message: 'Unable to connect to the server. Please check your internet connection and try again.',
                  onRetry: () {
                    // Show a snackbar for demo
                    Get.snackbar(
                      'Retry',
                      'Retrying submission...',
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Show Custom Error Dialog',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: 40.h),
            
            Text(
              'Features Included:',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFeatureItem('✅ Scale + Fade entrance animation'),
                _buildFeatureItem('🎉 Confetti burst effect for success'),
                _buildFeatureItem('📱 Material 3 design with rounded corners'),
                _buildFeatureItem('🔄 Icon rotation animation'),
                _buildFeatureItem('🎯 Accessible labels and actions'),
                _buildFeatureItem('📝 Custom titles and messages'),
                _buildFeatureItem('🔄 Retry functionality for errors'),
                _buildFeatureItem('📋 Direct navigation to "My Cases"'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
