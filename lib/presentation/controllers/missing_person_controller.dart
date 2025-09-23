import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/parent_report_service.dart';
import '../../data/models/parent_report_model.dart';

class MissingPersonController extends GetxController {
  // Missing Person Details - Updated to match current UI fields
  String childName = '';
  String fatherName = '';
  String gender = '';
  String lastSeenPlace = '';
  String lastSeenDate = '';
  String lastSeenTime = '';
  String phoneNumber = '';
  String secondPhoneNumber = '';
  String additionalDetails = '';
  
  // Legacy fields (kept for backward compatibility but not used in current UI)
  String surname = '';
  int age = 0;
  String height = '';
  String skinColor = '';
  String hairColor = '';
  String disability = '';
  
  // Images
  var selectedImages = <XFile>[].obs;
  
  // Reporter Details
  String reporterName = '';
  String relationship = '';
  String reporterPhone = '';
  String emergencyContact = '';
  
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
    gender = '';
    lastSeenPlace = '';
    lastSeenDate = '';
    lastSeenTime = '';
    phoneNumber = '';
    secondPhoneNumber = '';
    additionalDetails = '';
    // Legacy fields
    surname = '';
    age = 0;
    height = '';
    skinColor = '';
    hairColor = '';
    disability = '';
    selectedImages.clear();
    reporterName = '';
    relationship = '';
    reporterPhone = '';
    emergencyContact = '';
  }
  
  // Update missing person details - Updated to match current UI
  void updateMissingPersonDetails({
    required String name,
    required String father,
    required String gen,
    required String place,
    required String date,
    required String time,
    required String phone,
    String? secondPhone,
    String? additional,
    // Legacy parameters for backward compatibility
    String? sur,
    int? ageValue,
    String? hgt,
    String? skin,
    String? hair,
    String? dis,
  }) {
    childName = name;
    fatherName = father;
    gender = gen;
    lastSeenPlace = place;
    lastSeenDate = date;
    lastSeenTime = time;
    phoneNumber = phone;
    secondPhoneNumber = secondPhone ?? '';
    additionalDetails = additional ?? '';
    // Legacy fields (maintain for backward compatibility)
    surname = sur ?? '';
    age = ageValue ?? 0;
    height = hgt ?? '';
    skinColor = skin ?? '';
    hairColor = hair ?? '';
    disability = dis ?? '';
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
  
  // Build additional details string from all available information
  String _buildAdditionalDetailsString() {
    List<String> details = [];
    
    // Add father's name if available
    if (fatherName.isNotEmpty) details.add('Father: $fatherName');
    
    // Add legacy physical description fields if available
    if (skinColor.isNotEmpty) details.add('Skin: $skinColor');
    if (hairColor.isNotEmpty) details.add('Hair: $hairColor');
    if (disability.isNotEmpty) details.add('Disability: $disability');
    
    // Add phone numbers
    if (phoneNumber.isNotEmpty) details.add('Contact: $phoneNumber');
    if (secondPhoneNumber.isNotEmpty) details.add('Alt Contact: $secondPhoneNumber');
    
    // Add user-provided additional details
    if (additionalDetails.isNotEmpty) details.add(additionalDetails);
    
    return details.join(', ');
  }
  
  // Parse last seen date and time into DateTime
  DateTime get lastSeenDateTime {
    try {
      // Combine date and time if both are available
      if (lastSeenDate.isNotEmpty && lastSeenTime.isNotEmpty) {
        // Parse date (DD/MM/YYYY format) and time (HH:MM AM/PM format)
        final dateParts = lastSeenDate.split('/');
        if (dateParts.length == 3) {
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          
          // For simplicity, assume current time if time parsing fails
          // In a real app, you'd want to parse the time properly
          return DateTime(year, month, day);
        }
      }
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
      print('Father Name: $fatherName');
      print('Gender: $gender');
      print('Last Seen Place: $lastSeenPlace');
      print('Last Seen Date: $lastSeenDate');
      print('Last Seen Time: $lastSeenTime');
      print('Phone: $phoneNumber');
      print('Secondary Phone: $secondPhoneNumber');
      print('Images count: ${imageFiles.length}');
      
      // Submit to backend using available fields
      final response = await _reportService.createReport(
        childName: childName,
        age: age > 0 ? age : 0, // Use age if available, otherwise 0
        gender: gender,
        placeLost: lastSeenPlace,
        lostTime: lastSeenDateTime,
        clothes: height.isNotEmpty ? 'Height: $height' : '', // Use height if available
        additionalDetails: _buildAdditionalDetailsString(),
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