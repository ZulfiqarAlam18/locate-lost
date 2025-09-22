import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/parent_report_service.dart';
import '../../data/models/parent_report_model.dart';

class MissingPersonController extends GetxController {
  // Missing Person Details
  String childName = '';
  String fatherName = '';
  String surname = '';
  String gender = '';
  int age = 0;
  String height = '';
  String skinColor = '';
  String hairColor = '';
  String disability = '';
  String lastSeenPlace = '';
  String lastSeenTime = '';
  String phoneNumber = '';
  
  // Images
  var selectedImages = <XFile>[].obs;
  
  // Reporter Details
  String reporterName = '';
  String relationship = '';
  String reporterPhone = '';
  String emergencyContact = '';
  String additionalDetails = '';
  
  // Loading states
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  
  // Service
  final ParentReportService _reportService = ParentReportService();
  
  // Store submitted cases
  var submittedCases = <ParentReport>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadSubmittedCases();
  }
  
  // Clear all data
  void clearData() {
    childName = '';
    fatherName = '';
    surname = '';
    gender = '';
    age = 0;
    height = '';
    skinColor = '';
    hairColor = '';
    disability = '';
    lastSeenPlace = '';
    lastSeenTime = '';
    phoneNumber = '';
    selectedImages.clear();
    reporterName = '';
    relationship = '';
    reporterPhone = '';
    emergencyContact = '';
    additionalDetails = '';
  }
  
  // Update missing person details
  void updateMissingPersonDetails({
    required String name,
    required String father,
    required String sur,
    required String gen,
    required int ageValue,
    required String hgt,
    required String skin,
    required String hair,
    String? dis,
    required String place,
    required String time,
    String? phone,
  }) {
    childName = name;
    fatherName = father;
    surname = sur;
    gender = gen;
    age = ageValue;
    height = hgt;
    skinColor = skin;
    hairColor = hair;
    disability = dis ?? '';
    lastSeenPlace = place;
    lastSeenTime = time;
    phoneNumber = phone ?? '';
  }
  
  // Update images
  void updateImages(List<XFile> images) {
    selectedImages.value = images;
  }
  
  // Update reporter details
  void updateReporterDetails({
    required String name,
    required String rel,
    required String phone,
    required String emergency,
    String? additional,
  }) {
    reporterName = name;
    relationship = rel;
    reporterPhone = phone;
    emergencyContact = emergency;
    additionalDetails = additional ?? '';
  }
  
  // Get complete description
  String get completeDescription {
    List<String> descriptions = [];
    
    if (skinColor.isNotEmpty) descriptions.add('Skin: $skinColor');
    if (hairColor.isNotEmpty) descriptions.add('Hair: $hairColor');
    if (height.isNotEmpty) descriptions.add('Height: $height');
    if (disability.isNotEmpty) descriptions.add('Disability: $disability');
    if (additionalDetails.isNotEmpty) descriptions.add(additionalDetails);
    
    return descriptions.join(', ');
  }
  
  // Parse last seen time (you might want to use a proper date picker)
  DateTime get lastSeenDateTime {
    // For now, return current time minus some hours
    // You should update this to parse the actual time from the form
    try {
      // If you implement proper date/time picker, parse it here
      return DateTime.now().subtract(Duration(hours: 2));
    } catch (e) {
      return DateTime.now().subtract(Duration(hours: 2));
    }
  }
  
  // Submit the report
  Future<bool> submitReport() async {
    try {
      isSubmitting.value = true;
      
      // Convert XFile to File
      List<File> imageFiles = [];
      for (XFile xfile in selectedImages) {
        imageFiles.add(File(xfile.path));
      }
      
      print('--- SUBMITTING MISSING PERSON REPORT ---');
      print('Child Name: $childName');
      print('Age: $age');
      print('Gender: $gender');
      print('Last Seen Place: $lastSeenPlace');
      print('Reporter: $reporterName');
      print('Images count: ${imageFiles.length}');
      
      // Submit to backend
      final response = await _reportService.createReport(
        childName: childName,
        age: age,
        gender: gender,
        placeLost: lastSeenPlace,
        lostTime: lastSeenDateTime,
        clothes: '$skinColor skin, $hairColor hair, height: $height',
        additionalDetails: disability.isNotEmpty 
            ? 'Disability: $disability${additionalDetails.isNotEmpty ? ', $additionalDetails' : ''}'
            : additionalDetails,
        latitude: null, // You can add location services later
        longitude: null,
        locationName: lastSeenPlace,
        images: imageFiles,
      );
      
      if (response.success && response.data != null) {
        // Add to submitted cases list
        submittedCases.add(response.data!);
        saveSubmittedCases();
        
        print('✅ Report submitted successfully!');
        print('Case ID: ${response.data!.id}');
        
        // Clear form data after successful submission
        clearData();
        
        return true;
      } else {
        print('❌ Report submission failed: ${response.message}');
        Get.snackbar(
          'Submission Failed', 
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
        return false;
      }
      
    } catch (e) {
      print('❌ Report submission error: $e');
      Get.snackbar(
        'Submission Error', 
        'Failed to submit report. Please check your connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
  
  // Save submitted cases to local storage (as backup)
  void saveSubmittedCases() {
    // You can implement local storage here using GetStorage
    // For now, just keep in memory
  }
  
  // Load submitted cases from local storage
  void loadSubmittedCases() {
    // You can implement loading from local storage here
    // For now, start with empty list
    submittedCases.value = [];
  }
  
  // Validation methods
  bool get isMissingPersonDetailsValid {
    return childName.isNotEmpty &&
           fatherName.isNotEmpty &&
           surname.isNotEmpty &&
           gender.isNotEmpty &&
           height.isNotEmpty &&
           skinColor.isNotEmpty &&
           hairColor.isNotEmpty &&
           lastSeenPlace.isNotEmpty &&
           lastSeenTime.isNotEmpty;
  }
  
  bool get isImagesValid {
    return selectedImages.isNotEmpty;
  }
  
  bool get isReporterDetailsValid {
    return reporterName.isNotEmpty &&
           relationship.isNotEmpty &&
           reporterPhone.isNotEmpty &&
           emergencyContact.isNotEmpty;
  }
  
  bool get isAllDataValid {
    return isMissingPersonDetailsValid && isImagesValid && isReporterDetailsValid;
  }
  
  // Get progress percentage
  double get progressPercentage {
    int completedSteps = 0;
    const int totalSteps = 3;
    
    if (isMissingPersonDetailsValid) completedSteps++;
    if (isImagesValid) completedSteps++;
    if (isReporterDetailsValid) completedSteps++;
    
    return completedSteps / totalSteps;
  }
}