import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:locate_lost/controllers/finder_report_controller.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraController? _controller;
  late final FinderReportController finderController;
  bool _isCameraInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;
  final int _maxImages = 5;

  // Dynamic progress calculation (10% for images)
  double get progressPercent {
    const maxProgress = 0.10; // Images are first step (10%)
    
    int imageCount = finderController.selectedImages.length;
    // Progress increases with images, completes at 3+ images
    double imageProgress = (imageCount >= 3 ? 1.0 : imageCount / 3.0) * maxProgress;
    
    return imageProgress;
  }

  @override
  void initState() {
    super.initState();
    finderController = Get.find<FinderReportController>();
    print('📷 CameraCapture - Got controller: ${finderController.hashCode}');
    print('   Current images: ${finderController.selectedImages.length}');
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Check camera permission
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        setState(() {
          _errorMessage = 'Camera permission is required to capture images.';
          _isLoading = false;
        });
        return;
      }

      // Check storage permission
      final storageStatus = await Permission.storage.request();
      if (!storageStatus.isGranted) {
        // For Android 11+ we might need different permissions
        final manageExternalStorage =
            await Permission.manageExternalStorage.request();
        if (!manageExternalStorage.isGranted) {
          setState(() {
            _errorMessage = 'Storage permission is required to save images.';
            _isLoading = false;
          });
          return;
        }
      }

      // Initialize camera
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras available on this device.';
          _isLoading = false;
        });
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize camera: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (finderController.selectedImages.length >= _maxImages) {
      _showSnackBar('Maximum $_maxImages images allowed', isError: true);
      return;
    }

    try {
      final XFile picture = await _controller!.takePicture();
      final File imageFile = File(picture.path);

      // Validate image file
      if (await imageFile.exists()) {
        final fileSize = await imageFile.length();
        if (fileSize > 10 * 1024 * 1024) {
          // 10MB limit
          _showSnackBar('Image too large. Please try again.', isError: true);
          return;
        }

        setState(() {
          finderController.addImage(XFile(imageFile.path));
        });

        _showSnackBar('Image captured successfully!');

        if (finderController.selectedImages.length == 1) {
          _showReviewDialog();
        }
      } else {
        _showSnackBar('Failed to save image. Please try again.', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error capturing image: ${e.toString()}', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Picture Captured!",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      File(finderController.selectedImages.last.path),
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "More pictures help with better accuracy.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "You can upload up to $_maxImages images.",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            "Take More",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showFinalReview();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            "I'm Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
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
    );
  }

  void _showFinalReview() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Container(
              padding: EdgeInsets.all(20.w),
              constraints: BoxConstraints(maxHeight: 500.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Review Your Images",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (finderController.selectedImages.isNotEmpty) ...[
                    Expanded(
                      child: CarouselSlider(
                        items:
                            finderController.selectedImages.asMap().entries.map((entry) {
                              int index = entry.key;
                              File img = File(entry.value.path);
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.file(
                                        img,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8.h,
                                      right: 8.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 20.w,
                                          ),
                                          onPressed: () => _removeImage(index),
                                          constraints: BoxConstraints(
                                            minWidth: 36.w,
                                            minHeight: 36.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8.h,
                                      left: 8.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Text(
                                          '${index + 1} / ${finderController.selectedImages.length}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        options: CarouselOptions(
                          height: 300.h,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '${finderController.selectedImages.length} image(s) ready to submit',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 48.w,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "No images to review",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          finderController.selectedImages.isNotEmpty
                              ? _proceedToNextScreen
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        "Submit & Proceed",
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }

  void _removeImage(int index) {
    setState(() {
      finderController.removeImage(index);
    });
    Navigator.of(context).pop();
    if (finderController.selectedImages.isNotEmpty) {
      _showFinalReview();
    }
  }

  void _proceedToNextScreen() {
    // Convert File objects to XFile objects (local only).
    // Previously these were stored in a controller; that dependency was removed.
    // If you want to pass captured images to the next screen, pass them via
    // navigation arguments (Get.toNamed(..., arguments: {...})) or persist them
    // in a short-lived store. For now we keep this screen UI-only and simply
    // navigate forward.
    Navigator.of(context).pop();
    Get.toNamed(AppRoutes.foundPersonDetails);
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              'Permissions Required',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            content: Text(
              'This app needs camera and storage permissions to capture and save images. Please grant permissions in settings.',
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  'Open Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  Future<bool> _onWillPop() async {
    if (finderController.selectedImages.isNotEmpty) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                'Discard Images?',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              content: Text(
                'You have ${finderController.selectedImages.length} unsaved image(s). Are you sure you want to go back?',
                style: TextStyle(fontSize: 14.sp),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Discard', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (_isLoading) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 16.h),
              Text(
                'Initializing camera...',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 64.w),
                SizedBox(height: 16.h),
                Text(
                  'Camera Error',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed:
                      _errorMessage!.contains('permission')
                          ? _showPermissionDialog
                          : _initializeCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    _errorMessage!.contains('permission')
                        ? 'Grant Permissions'
                        : 'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!_isCameraInitialized || _controller == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return CameraPreview(_controller!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildCameraPreview(),

            // Header with back button and counter
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24.w,
                        ),
                        onPressed: () async {
                          if (await _onWillPop()) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${finderController.selectedImages.length}/$_maxImages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Progress indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(progressPercent * 100).toInt()}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            width: 30.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progressPercent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: finderController.selectedImages.isEmpty
                                      ? Colors.orange
                                      : finderController.selectedImages.length >= 3
                                          ? Colors.green
                                          : Colors.orange,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom controls
            Positioned(
              bottom: 50.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Image thumbnails
                  if (finderController.selectedImages.isNotEmpty) ...[
                    Container(
                      height: 60.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: finderController.selectedImages.length,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                File(finderController.selectedImages[index].path),
                                width: 60.w,
                                height: 60.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  // Capture button and review button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (finderController.selectedImages.isNotEmpty) ...[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: IconButton(
                            onPressed: _showFinalReview,
                            icon: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 24.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],

                      // Capture button
                      GestureDetector(
                        onTap: _isCameraInitialized ? _takePicture : null,
                        child: Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _isCameraInitialized
                                    ? Colors.white
                                    : Colors.grey,
                            border: Border.all(
                              width: 4.w,
                              color:
                                  finderController.selectedImages.length >= _maxImages
                                      ? Colors.red
                                      : AppColors.primary,
                            ),
                          ),
                          child:
                              finderController.selectedImages.length >= _maxImages
                                  ? Icon(
                                    Icons.block,
                                    color: Colors.red,
                                    size: 30.w,
                                  )
                                  : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
