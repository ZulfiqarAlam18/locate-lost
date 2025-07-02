import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../routes/app_routes.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({super.key});

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  double progressPercent = .65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Center(
                child: Text(
                  'Lost Person',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Divider(
                color: AppColors.primary,
                indent: 100.w,
                endIndent: 100.w,
                thickness: 2.h,
              ),
              SizedBox(height: 20.h),

              Container(
                width: 390.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1.5.w),
                ),
                child: Card(
                  elevation: 6,
                  color: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Application Progress',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Enter missing person\'s real\nname to continue',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.myRedColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CircularPercentIndicator(
                            radius: 40.r,
                            lineWidth: 8.0.w,
                            percent: progressPercent,
                            animation: true,
                            animationDuration: 1000,
                            progressColor: AppColors.primary,
                            backgroundColor: Colors.teal.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${(progressPercent * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Divider(
                color: AppColors.primary,
                indent: 100.w,
                endIndent: 100.w,
                thickness: 2.h,
              ),
              SizedBox(height: 10.h),
              Text(
                'Upload clear and front facing images/videos of the missing person.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.myBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),

              // Reusable widget for the upload buttons
              _buildUploadButton(
                icon: Icons.upload,
                label: 'Upload Image',
                isRequired: true,
              ),

              SizedBox(height: 10.h),

              _buildUploadButton(
                icon: Icons.camera_alt,
                label: 'Upload Video',
                isRequired: false,
              ),

              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    height: 45.h,
                    width: 130.w,
                    fontSize: 15.sp,
                    borderRadius: 10.r,
                    label: 'Back',
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.primary,
                    showBorder: true,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.reporterDetails);
                    },
                    height: 45.h,
                    width: 130.w,
                    fontSize: 15.sp,
                    borderRadius: 10.r,
                    label: 'Next',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for upload buttons
  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required bool isRequired,
  }) {
    return Container(
      width: 430.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary, width: 1.5.w),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 10.h),
          child: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(icon, color: AppColors.primary, size: 49.sp),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.h),
              if (isRequired)
                Text(
                  'YOU MUST UPLOAD AT LEAST ONE IMAGE/VIDEO OF THE PERSON',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.myRedColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              SizedBox(height: 10),
              Text(
                '(Image/video size shouldn’t be more than 10 MBs.)',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.myRedColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
