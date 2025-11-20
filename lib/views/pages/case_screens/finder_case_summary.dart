import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/controllers/finder_report_controller.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/utils/utils/dialog_utils.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/utils/utils/navigation_helper.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

class FinderCaseSummaryScreen extends StatelessWidget {
  const FinderCaseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FinderReportController>();
    print('📊 FinderSummary - Got controller: ${controller.hashCode}');
    print('   Controller data - Name: ${controller.childName.value}, Father: ${controller.fatherName.value}, Images: ${controller.selectedImages.length}');

    return Scaffold(
      appBar: CustomAppBar(
        text: 'Found Person Report',
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: Obx(() {
        // Debug print to verify reactive updates
        print('🔄 Summary screen rebuilding...');
        print('  Images: ${controller.selectedImages.length}');
        print('  Name: ${controller.childName.value}');
        print('  Father: ${controller.fatherName.value}');
        print('  Gender: ${controller.gender.value}');
        print('  Place: ${controller.placeFound.value}');
        print('  Contact: ${controller.contactNumber.value}');
        
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(controller),
              _buildFoundPersonDetailsCard(controller),
              _buildCapturedImagesSection(controller),
              _buildFinderInfoCard(controller),
              _buildLocationAndTimeCard(controller),
              _buildAdditionalDetailsCard(controller),
              _buildActionButtons(controller, context),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeaderSection(FinderReportController controller) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.person_search, color: Colors.white, size: 32.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Found Person Report',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Review your report details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Ready to Submit',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoundPersonDetailsCard(FinderReportController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Found Person Details',
        icon: Icons.person,
        child: Column(
          children: [
            _buildDetailRow(
              'Name', 
              controller.childName.value.isEmpty ? 'Not specified' : controller.childName.value
            ),
            _buildDetailRow(
              'Father Name', 
              controller.fatherName.value.isEmpty ? 'Not specified' : controller.fatherName.value
            ),
            _buildDetailRow(
              'Gender', 
              controller.gender.value.isEmpty ? 'Not specified' : controller.gender.value
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapturedImagesSection(FinderReportController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Captured Photos',
        icon: Icons.camera_alt,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.photo_camera, size: 18.w, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  '${controller.selectedImages.length} ${controller.selectedImages.length == 1 ? 'Photo' : 'Photos'}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${controller.selectedImages.length}/5',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (controller.selectedImages.isEmpty)
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'No images captured. Please go back and add images.',
                        style: TextStyle(color: Colors.red.shade700, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 12.w),
                      width: 120.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          File(controller.selectedImages[index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinderInfoCard(FinderReportController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Your Contact Information',
        icon: Icons.person_pin,
        child: Column(
          children: [
            _buildDetailRow(
              'Primary Phone', 
              controller.contactNumber.value.isEmpty ? 'Not specified' : controller.contactNumber.value
            ),
            _buildDetailRow(
              'Emergency Contact', 
              controller.emergency.value.isEmpty ? 'Not provided' : controller.emergency.value
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationAndTimeCard(FinderReportController controller) {
    String dateStr = 'Not specified';
    String timeStr = 'Not specified';
    
    // Controller already stores date as "dd/MM/yyyy" and time as "h:mm AM/PM"
    // Just display them directly without parsing
    if (controller.foundDate.value.isNotEmpty) {
      dateStr = controller.foundDate.value;
    }
    
    if (controller.foundTime.value.isNotEmpty) {
      timeStr = controller.foundTime.value;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Location & Time',
        icon: Icons.location_on,
        child: Column(
          children: [
            _buildDetailRow(
              'Place Found', 
              controller.placeFound.value.isEmpty ? 'Not specified' : controller.placeFound.value
            ),
            _buildDetailRow('Date Found', dateStr),
            _buildDetailRow('Time Found', timeStr),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetailsCard(FinderReportController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Additional Details',
        icon: Icons.description,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.additionalDetails.value.isEmpty 
                ? 'No additional details provided' 
                : controller.additionalDetails.value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20.w),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
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
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(FinderReportController controller, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () => _submitReport(controller, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 24.w, color: Colors.white),
                  SizedBox(width: 12.w),
                  Text(
                    'Submit Report',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Edit Button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: OutlinedButton(
              onPressed: () => Get.toNamed(AppRoutes.foundPersonDetails),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary, width: 2.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 24.w, color: AppColors.primary),
                  SizedBox(width: 12.w),
                  Text(
                    'Edit Report',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitReport(FinderReportController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Submit Report?',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to submit this found person report? Once submitted, you can track the status in "My Cases".',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performSubmission(controller);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _performSubmission(FinderReportController controller) async {
    // Validate that at least 1 image is selected (required)
    if (controller.selectedImages.isEmpty) {
      Get.snackbar(
        'Images Required',
        'Please capture or upload at least one image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.myRedColor,
        colorText: Colors.white,
      );
      return;
    }

    // Show loading indicator
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 16.h),
              Text('Submitting report...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Call actual API
    final response = await controller.submitReport();

    // Close loading dialog
    Get.back();

    if (response.success) {
      // Clear form data after successful submission
      controller.clearData();
      
      DialogUtils.showCaseSubmissionSuccess(
        title: 'Found Person Report Submitted!',
        message: response.message,
        onViewCases: () {
          NavigationHelper.goToMyCases();
        },
      );
    } else {
      DialogUtils.showCaseSubmissionError(
        title: 'Found Person Report Failed',
        message: response.message,
        onRetry: () {
          _performSubmission(controller);
        },
      );
    }
  }
}
