import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/controllers/finder_report_controller.dart';

class FoundPersonController extends GetxController {
  // Found Person Details - Matching current UI fields
  String personName = '';
  String fatherName = '';
  String gender = '';
  String foundPlace = '';
  String foundDate = '';
  String foundTime = '';
  String finderPhone = '';
  String finderSecondaryPhone = '';
  String additionalDetails = '';
  
  // Images
  var selectedImages = <XFile>[].obs;
  
  // Loading states
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  
  // Reference to FinderReportController for actual submission
  late final FinderReportController _finderReportController;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize or get existing FinderReportController
    if (Get.isRegistered<FinderReportController>()) {
      _finderReportController = Get.find<FinderReportController>();
    } else {
      _finderReportController = Get.put(FinderReportController());
    }
  }
  
  // Clear all data
  void clearData() {
    personName = '';
    fatherName = '';
    gender = '';
    foundPlace = '';
    foundDate = '';
    foundTime = '';
    finderPhone = '';
    finderSecondaryPhone = '';
    additionalDetails = '';
    selectedImages.clear();
  }
  
  // Update found person details
  void updateFoundPersonDetails({
    required String name,
    required String father,
    required String gen,
    required String place,
    required String date,
    required String time,
    required String phone,
    String? secondPhone,
    String? additional,
  }) {
    personName = name;
    fatherName = father;
    gender = gen;
    foundPlace = place;
    foundDate = date;
    foundTime = time;
    finderPhone = phone;
    finderSecondaryPhone = secondPhone ?? '';
    additionalDetails = additional ?? '';
  }
  
  // Update images
  void updateImages(List<XFile> images) {
    selectedImages.value = images;
  }
  
  // Parse found date and time into DateTime
  DateTime get foundDateTime {
    try {
      // Combine date and time if both are available
      if (foundDate.isNotEmpty && foundTime.isNotEmpty) {
        // Parse date (DD/MM/YYYY format) and time (HH:MM AM/PM format)
        final dateParts = foundDate.split('/');
        if (dateParts.length == 3) {
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          
          // For simplicity, assume current time if time parsing fails
          // In a real app, you'd want to parse the time properly
          return DateTime(year, month, day);
        }
      }
      return DateTime.now();
    } catch (e) {
      return DateTime.now();
    }
  }
  
  // Get estimated age (if provided in name or other fields)
  int? get estimatedAge {
    // This would be better if you had a separate age field
    // For now, return null since it's optional in the finder report
    return null;
  }
  
  // Submit the report using FinderReportController
  Future<bool> submitReport() async {
    try {
      isSubmitting.value = true;
      
      // Convert XFile to File
      List<File> imageFiles = [];
      for (XFile xFile in selectedImages) {
        imageFiles.add(File(xFile.path));
      }
      
      // Use the FinderReportController to submit
      final success = await _finderReportController.createReport(
        childName: personName.isNotEmpty ? personName : null,
        estimatedAge: estimatedAge,
        gender: gender,
        placeFound: foundPlace,
        foundTime: foundDateTime,
        additionalDetails: additionalDetails,
        images: imageFiles,
      );
      
      if (success) {
        // Clear data after successful submission
        clearData();
      }
      
      return success;
    } catch (e) {
      print('Error submitting found person report: $e');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
  
  // Validation helpers
  bool validateRequiredFields() {
    return foundPlace.isNotEmpty &&
           foundDate.isNotEmpty &&
           foundTime.isNotEmpty &&
           finderPhone.isNotEmpty &&
           gender.isNotEmpty;
  }
  
  String getValidationError() {
    if (foundPlace.isEmpty) return 'Please enter the place where the person was found';
    if (foundDate.isEmpty) return 'Please select the date when the person was found';
    if (foundTime.isEmpty) return 'Please select the time when the person was found';
    if (finderPhone.isEmpty) return 'Please enter your contact number';
    if (gender.isEmpty) return 'Please select the gender';
    return '';
  }
}