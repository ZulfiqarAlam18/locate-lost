import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CapturePicturesScreen extends StatefulWidget {
  const CapturePicturesScreen({super.key});

  @override
  State<CapturePicturesScreen> createState() => _CapturePicturesScreenState();
}

class _CapturePicturesScreenState extends State<CapturePicturesScreen> {
  CameraController? _controller;
  List<File> capturedImages = [];
  bool isCameraInitialized = false;
  bool hasShownPrompt = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    setState(() => isCameraInitialized = true);
  }

  Future<void> takePicture() async {
    if (!_controller!.value.isInitialized || capturedImages.length >= 5) return;

    final directory = await getTemporaryDirectory();
    final imagePath = join(directory.path, '${DateTime.now()}.png');
    final image = await _controller!.takePicture();

    setState(() {
      capturedImages.add(File(image.path));
    });

    if (capturedImages.length == 1 && !hasShownPrompt) {
      hasShownPrompt = true;
      Future.delayed(Duration(milliseconds: 300), () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Want to take more?"),
            content: Text("More photos can help us with better recognition and verification."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("No, continue"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Yes, I’ll add more"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void goToNext() {
    if (capturedImages.isNotEmpty) {
      // Navigator.push to child info screen and pass capturedImages
    }
  }

  void removeImage(int index) {
    setState(() {
      capturedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isCameraInitialized
          ? Column(
        children: [
          // AppBar-like back button
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: CameraPreview(_controller!),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 1: Take Child's Picture",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please take at least one picture.\nYou can take up to 5 for better accuracy.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: capturedImages.asMap().entries.map((entry) {
                      int idx = entry.key;
                      File file = entry.value;
                      return GestureDetector(
                        onLongPress: () => removeImage(idx),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(file, height: 60, width: 60, fit: BoxFit.cover),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: capturedImages.length >= 5 ? null : takePicture,
                        icon: const Icon(Icons.camera),
                        label: const Text("Take Photo"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: capturedImages.length >= 5 ? Colors.grey : Colors.teal,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: capturedImages.isEmpty ? null : goToNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: capturedImages.isEmpty ? Colors.grey : Colors.teal,
                        ),
                        child: const Text("Continue"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
