import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  late CameraController _controller;
  List<File> _capturedImages = [];
  bool _isCameraInitialized = false;
  bool _showCarousel = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndInitCamera();
  }

  Future<void> _checkPermissionsAndInitCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Camera permission is required')));
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized || _capturedImages.length >= 5) return;

    final path = (await getTemporaryDirectory()).path;
    final imagePath = '$path/${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      await _controller.takePicture().then((XFile file) {
        final image = File(file.path);
        setState(() {
          _capturedImages.add(image);
        });

        if (_capturedImages.length == 1) {
          _showReviewDialog();
        }
      });
    } catch (e) {
      print("Capture error: $e");
    }
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text("Picture Captured"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(_capturedImages.last, height: 200.h),
                SizedBox(height: 8.h),
                Text("More pictures help with better accuracy."),
                Text(
                  "You can upload up to 5.",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _showCarousel = true;
                  });
                },
                child: Text("Yes, take more"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showFinalReview();
                },
                child: Text("No, I'm done"),
              ),
            ],
          ),
    );
  }

  void _showFinalReview() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Review Your Images"),
            content:
                _capturedImages.isNotEmpty
                    ? CarouselSlider(
                      items:
                          _capturedImages.map((img) {
                            return Stack(
                              children: [
                                Image.file(
                                  img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 5.h,
                                  right: 5.w,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _capturedImages.remove(img);
                                      });
                                      Navigator.of(context).pop();
                                      _showFinalReview(); // Refresh carousel
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                      options: CarouselOptions(
                        height: 250.h,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                    )
                    : Text("No images to review."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/foundPersonDetailsScreen');
                },
                child: Text("Submit & Proceed"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized)
      return Center(child: CircularProgressIndicator());
    return CameraPreview(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildCameraPreview(),
          Positioned(
            top: 40.h,
            left: 10.w,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 5.w, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
