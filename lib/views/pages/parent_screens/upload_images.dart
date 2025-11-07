import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  // Removed MissingPersonController dependency - keep images and form data local
  List<XFile> _selectedImages = [];
  late final _LocalMissingPerson controller;
  
  // Dynamic progress calculation for upload images screen
  double get progressPercent {
    // Calculate base progress from previous screen completion
    double baseProgress = _calculateFormCompletionProgress();
    const maxAdditionalProgress = 0.10; // Additional 10% progress available for images
    
  int imageCount = _selectedImages.length;
    // Progress increases with images, maxes out at 3 images (recommended minimum)
    double imageProgress = (imageCount >= 3 ? 1.0 : imageCount / 3.0) * maxAdditionalProgress;
    
    return baseProgress + imageProgress;
  }
  
  // Calculate how much of the form was completed (0.0 to 0.80)
  double _calculateFormCompletionProgress() {
    const maxFormProgress = 0.80;
    
    List<bool> formFieldsCompleted = [
      // In UI-only mode these are local/default empty values; progress will be 0
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    
    int completedFields = formFieldsCompleted.where((completed) => completed).length;
    return (completedFields / formFieldsCompleted.length) * maxFormProgress;
  }
  
  @override
  void initState() {
    super.initState();
    // Initialize local controller shim to delegate to this state's _selectedImages
    controller = _LocalMissingPerson(
      () => _selectedImages,
      (newList) {
        setState(() {
          _selectedImages = newList;
        });
      },
    );
  }

  Future<void> _pickImages() async {
    if (controller.selectedImages.length >= 5) {
      Get.snackbar(
        'Limit Reached',
        'You can only select up to 5 images',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.myRedColor,
        colorText: Colors.white,
      );
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      int remainingSlots = 5 - controller.selectedImages.length;
      
      List<XFile> currentImages = List.from(controller.selectedImages);
      List<XFile> imagesToAdd = pickedFiles.take(remainingSlots).toList();
      currentImages.addAll(imagesToAdd);
      
      controller.updateImages(currentImages);
      
      // Trigger UI update for progress
      setState(() {});

      if (pickedFiles.length > remainingSlots) {
        Get.snackbar(
          'Selection Limited',
          'Only $remainingSlots images were added. Maximum 5 images allowed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
        );
      }
    }
  }

  void _removeImage(int index) {
    List<XFile> currentImages = List.from(controller.selectedImages);
    currentImages.removeAt(index);
    controller.updateImages(currentImages);
    
    // Trigger UI update for progress
    setState(() {});
  }

  void _viewImageFullScreen(String imagePath) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Obx(() => SingleChildScrollView(
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
                                'Upload Progress',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                controller.selectedImages.isEmpty
                                    ? 'Form completed - Add images to continue'
                                    : '${controller.selectedImages.length} of 5 images selected',
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
                            animationDuration: 800,
                            progressColor: controller.selectedImages.isEmpty
                                ? Colors.orange  // 80% - form completed but no images
                                : controller.selectedImages.length >= 3
                                    ? AppColors.primary  // 90% - good progress with images
                                    : Colors.orange, // 80-90% - some images
                            backgroundColor: Colors.teal.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${(progressPercent * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedImages.isEmpty
                                    ? Colors.orange
                                    : controller.selectedImages.length >= 3
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
              Divider(
                color: AppColors.primary,
                indent: 100.w,
                endIndent: 100.w,
                thickness: 2.h,
              ),
              SizedBox(height: 10.h),
              Text(
                'Upload clear and front facing images of the missing person (1-5 images).',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.myBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),

              // Image Upload Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1.5.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Images (${controller.selectedImages.length}/5)',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      
                      // Upload area
                      GestureDetector(
                        onTap: controller.selectedImages.length < 5 ? _pickImages : null,
                        child: Container(
                          width: double.infinity,
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
                              style: BorderStyle.solid,
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
                                      ? 'Tap to select images from gallery'
                                      : controller.selectedImages.length < 5
                                          ? 'Tap to add more images'
                                          : 'Maximum 5 images selected',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: controller.selectedImages.length < 5 
                                        ? AppColors.primary 
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (controller.selectedImages.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: Text(
                                      'At least 1 image required*',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.myRedColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Image Preview Grid
                      if (controller.selectedImages.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Images',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 1,
                              ),
                              itemCount: controller.selectedImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _viewImageFullScreen(controller.selectedImages[index].path),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: AppColors.primary.withOpacity(0.3),
                                            width: 1.w,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.r),
                                          child: Image.file(
                                            File(controller.selectedImages[index].path),
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () => _removeImage(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.myRedColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.all(4.w),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      
                      // Instructions
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Image Guidelines:',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              '• Upload 1-5 clear images of the missing person\n'
                              '• Use front-facing, well-lit photos\n'
                              '• Each image should be less than 10 MB\n'
                              '• Tap on any image to view in full screen',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.myBlackColor,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ],
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
                      if (controller.selectedImages.isNotEmpty) {
                     Get.toNamed(AppRoutes.parentCaseSummary);


                    //    Get.toNamed(AppRoutes.reporterDetails);
                      } else {
                        Get.snackbar(
                          'Images Required',
                          'Please select at least 1 image to continue',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.myRedColor,
                          colorText: Colors.white,
                        );
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
      )),
    );
  }
}

// Local shim to emulate the parts of the missing MissingPersonController used by
// the UI. Delegates selectedImages get/set to provided callbacks so the
// stateful widget can remain the single source of truth.
class _LocalMissingPerson {
  final List<XFile> Function() _getList;
  final void Function(List<XFile>) _setList;

  _LocalMissingPerson(this._getList, this._setList);

  List<XFile> get selectedImages => _getList();
  set selectedImages(List<XFile> imgs) => _setList(imgs);

  void updateImages(List<XFile> imgs) => _setList(imgs);

  // Minimal fields expected by UI; left empty for UI-only mode.
  String childName = '';
  String fatherName = '';
  String gender = '';
  String lastSeenPlace = '';
  String lastSeenTime = '';
  String phoneNumber = '';
}
