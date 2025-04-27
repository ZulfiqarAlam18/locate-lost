import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FinderCameraScreen extends StatefulWidget {
  @override
  _FinderCameraScreenState createState() => _FinderCameraScreenState();
}

class _FinderCameraScreenState extends State<FinderCameraScreen> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is required')),
      );
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
      builder: (_) => AlertDialog(
        title: Text("Picture Captured"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(_capturedImages.last, height: 200),
            SizedBox(height: 8),
            Text("More pictures help with better accuracy."),
            Text("You can upload up to 5.", style: TextStyle(fontSize: 12)),
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
      builder: (_) => AlertDialog(
        title: Text("Review Your Images"),
        content: _capturedImages.isNotEmpty
            ? CarouselSlider(
          items: _capturedImages.map((img) {
            return Stack(
              children: [
                Image.file(img, fit: BoxFit.cover, width: double.infinity),
                Positioned(
                  top: 5,
                  right: 5,
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
            height: 250,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
        )
            : Text("No images to review."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/childInfoScreen');
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
    if (!_isCameraInitialized) return Center(child: CircularProgressIndicator());
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
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 5, color: Colors.teal),
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











// first version


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';
//
// class FinderCameraScreen extends StatefulWidget {
//   @override
//   _FinderCameraScreenState createState() => _FinderCameraScreenState();
// }
//
// class _FinderCameraScreenState extends State<FinderCameraScreen> {
//   late CameraController _controller;
//   List<File> _capturedImages = [];
//   bool _isCameraInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     await _controller.initialize();
//     setState(() {
//       _isCameraInitialized = true;
//     });
//   }
//
//   Future<void> _takePicture() async {
//     if (_capturedImages.length >= 5) return;
//
//     final path = (await getTemporaryDirectory()).path;
//     final imagePath = '$path/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     await _controller.takePicture().then((XFile file) {
//       final image = File(file.path);
//       _capturedImages.add(image);
//     });
//
//     if (_capturedImages.length == 1) {
//       _showReviewDialog();
//     } else {
//       setState(() {});
//     }
//   }
//
//   void _showReviewDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         title: Text("Review Your Picture"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               children: [
//                 Image.file(_capturedImages.last, width: 200, height: 200),
//                 Positioned(
//                   right: 0,
//                   child: IconButton(
//                     icon: Icon(Icons.close, color: Colors.red),
//                     onPressed: () {
//                       setState(() {
//                         _capturedImages.removeLast();
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 12),
//             Text("Taking more photos improves accuracy."),
//             SizedBox(height: 4),
//             Text("You can upload up to 5 photos.", style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text("Yes, I'll take more"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.pushNamed(context, '/childInfoScreen');
//             },
//             child: Text("No, I'm done"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Widget _buildCameraPreview() {
//     if (!_isCameraInitialized) {
//       return Center(child: CircularProgressIndicator());
//     }
//     return CameraPreview(_controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           _buildCameraPreview(),
//           Positioned(
//             top: 40,
//             left: 10,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//           Positioned(
//             bottom: 30,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: GestureDetector(
//                 onTap: _takePicture,
//                 child: Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(width: 5, color: Colors.teal),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









// another version


//
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:locat_lost/Screens/founder_screens/f_child_info.dart';
// import 'package:locat_lost/colors.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';
//
// class CapturePicturesScreen extends StatefulWidget {
//   const CapturePicturesScreen({super.key});
//
//   @override
//   State<CapturePicturesScreen> createState() => _CapturePicturesScreenState();
// }
//
// class _CapturePicturesScreenState extends State<CapturePicturesScreen> {
//   CameraController? _controller;
//   List<File> capturedImages = [];
//   bool isCameraInitialized = false;
//   bool hasShownPrompt = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }
//
//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;
//
//     _controller = CameraController(camera, ResolutionPreset.medium);
//     await _controller!.initialize();
//     setState(() => isCameraInitialized = true);
//   }
//
//   Future<void> takePicture() async {
//     if (!_controller!.value.isInitialized || capturedImages.length >= 5) return;
//
//     final directory = await getTemporaryDirectory();
//     final imagePath = join(directory.path, '${DateTime.now()}.png');
//     final image = await _controller!.takePicture();
//
//     setState(() {
//       capturedImages.add(File(image.path));
//     });
//
//     if (capturedImages.length == 1 && !hasShownPrompt) {
//       hasShownPrompt = true;
//       Future.delayed(Duration(milliseconds: 300), () {
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text("Want to take more?"),
//             content: Text("More photos can help us with better recognition and verification."),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text("No, continue"),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text("Yes, I’ll add more"),
//               ),
//             ],
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   void goToNext() {
//     if (capturedImages.isNotEmpty) {
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildInfoScreen()));
//       // Navigator.push to child info screen and pass capturedImages
//     }
//   }
//
//   void removeImage(int index) {
//     setState(() {
//       capturedImages.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: isCameraInitialized
//           ? Column(
//         children: [
//           // AppBar-like back button
//           SafeArea(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: CameraPreview(_controller!),
//           ),
//           Expanded(
//             flex: 3,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Step 1: Take Child's Picture",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Please take at least one picture.\nYou can take up to 5 for better accuracy.",
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 10,
//                     children: capturedImages.asMap().entries.map((entry) {
//                       int idx = entry.key;
//                       File file = entry.value;
//                       return Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.file(file, height: 60, width: 60, fit: BoxFit.cover),
//                           ),
//
//
//                           Container(
//                             padding: const EdgeInsets.all(2),
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.red,
//                             ),
//                             child: SizedBox(
//                               width: 20,  // Control width and height to match your desired size
//                               height: 20,
//                               child: IconButton(
//                                 padding: EdgeInsets.zero, // Remove internal padding
//                                 constraints: const BoxConstraints(), // Remove default min constraints
//                                 icon: const Icon(Icons.close, color: Colors.white, size: 16),
//                                 onPressed: () {
//                                   removeImage(idx); // Your function
//                                 },
//                               ),
//                             ),
//                           )
//
//
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: capturedImages.length >= 5 ? null : takePicture,
//                         icon: const Icon(Icons.camera_alt),
//                         label: const Text("Take Photo"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: capturedImages.length >= 5 ? Colors.grey : Colors.teal,
//                           foregroundColor: AppColors.secondary,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: capturedImages.isEmpty ? null : goToNext,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: capturedImages.isEmpty ? Colors.grey : Colors.teal,
//                           foregroundColor: AppColors.secondary,
//                         ),
//                         child: const Text("Continue"),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
