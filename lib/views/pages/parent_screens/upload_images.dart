import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/controllers/parent_report_controller.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/custom_elevated_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({super.key});

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  final ImagePicker _picker = ImagePicker();
  late final ParentReportController controller;
  
  // Progress calc
  double get progressPercent {
    const maxAdditionalProgress = 0.10;
    int imageCount = controller.selectedImages.length;
    double imageProgress = (imageCount >= 3 ? 1.0 : imageCount / 3.0) * maxAdditionalProgress;
    return 0.80 + imageProgress; // Form is assumed 80% from previous screen
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<ParentReportController>();
  }

  Future<void> _pickImages() async {
    if (controller.selectedImages.length >= 5) {
      Get.snackbar('Limit Reached', 'You can only select up to 5 images',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.myRedColor,
          colorText: Colors.white);
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      int remainingSlots = 5 - controller.selectedImages.length;

      List<XFile> updated = List.from(controller.selectedImages);
      updated.addAll(pickedFiles.take(remainingSlots));

      controller.updateImages(updated);
      setState(() {}); // Trigger UI update

      if (pickedFiles.length > remainingSlots) {
        Get.snackbar(
          'Selection Limited',
          'Only $remainingSlots images were added.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
        );
      }
    }
  }

  void _removeImage(int index) {
    List<XFile> updated = List.from(controller.selectedImages);
    updated.removeAt(index);
    controller.updateImages(updated);
    setState(() {}); // Trigger UI update
  }

  void _viewImageFullScreen(String imagePath) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.file(File(imagePath), fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

              Divider(color: AppColors.primary, indent: 100.w, endIndent: 100.w, thickness: 2.h),
              SizedBox(height: 20.h),

              // Progress Card
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Upload Progress',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 6.h),
                              Text(
                                controller.selectedImages.isEmpty
                                    ? 'Form completed - Add images to continue'
                                    : '${controller.selectedImages.length} of 5 images selected',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.myRedColor,
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
                            progressColor: controller.selectedImages.length >= 3
                                ? AppColors.primary
                                : Colors.orange,
                            backgroundColor: Colors.teal.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${(progressPercent * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedImages.length >= 3
                                    ? AppColors.primary
                                    : Colors.orange,
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
              Divider(color: AppColors.primary, indent: 100.w, endIndent: 100.w, thickness: 2.h),

              SizedBox(height: 10.h),
              Text(
                'Upload clear and front facing images of the missing person (1-5 images).',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.myBlackColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),

              // Image Upload Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1.5.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Images (${controller.selectedImages.length}/5)',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 15.h),

                      GestureDetector(
                        onTap: controller.selectedImages.length < 5 ? _pickImages : null,
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: controller.selectedImages.length < 5
                                ? AppColors.secondary.withOpacity(0.7)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: controller.selectedImages.isEmpty
                                  ? AppColors.myRedColor
                                  : AppColors.primary,
                              width: 2.w,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  controller.selectedImages.length < 5
                                      ? Icons.add_photo_alternate
                                      : Icons.photo_library,
                                  color: controller.selectedImages.length < 5
                                      ? AppColors.primary
                                      : Colors.grey,
                                  size: 45.sp,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  controller.selectedImages.isEmpty
                                      ? 'Tap to select images'
                                      : controller.selectedImages.length < 5
                                          ? 'Tap to add more images'
                                          : 'Maximum 5 images selected',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: controller.selectedImages.length < 5
                                        ? AppColors.primary
                                        : Colors.grey,
                                  ),
                                ),
                                if (controller.selectedImages.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: Text(
                                      'At least 1 image required*',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.myRedColor),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      if (controller.selectedImages.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 10.h),
                          itemCount: controller.selectedImages.length,
                          itemBuilder: (_, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _viewImageFullScreen(controller.selectedImages[index].path),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.file(
                                      File(controller.selectedImages[index].path),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: AppColors.myRedColor,
                                      child: Icon(Icons.close,
                                          size: 16.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                      SizedBox(height: 15.h),

                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '• Upload 1-5 clear images\n'
                          '• Use front-facing, well-lit photos\n'
                          '• Tap to view in full screen',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevatedButton(
                    onPressed: () => Navigator.pop(context),
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
                      if (controller.selectedImages.isNotEmpty) {
                        Get.toNamed(AppRoutes.parentCaseSummary);
                      } else {
                        Get.snackbar(
                            'Images Required',
                            'Please select at least 1 image',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.myRedColor,
                            colorText: Colors.white);
                      }
                    },
                    height: 45.h,
                    width: 130.w,
                    fontSize: 15.sp,
                    borderRadius: 10.r,
                    label: 'Next',
                    backgroundColor: controller.selectedImages.isEmpty
                        ? Colors.grey.shade400
                        : AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
