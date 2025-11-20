import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/finder_report/finder_report_request.dart';
import '../data/models/finder_report/finder_report_response.dart';
import '../data/network/finder_report_helper.dart';
import 'auth_controller.dart';

class FinderReportController extends GetxController {
  final FinderReportHelper _helper = FinderReportHelper();

  // Observable fields - all optional for finder reports
  final RxString childName = ''.obs;
  final RxString fatherName = ''.obs;
  final RxString gender = ''.obs;
  final RxString placeFound = ''.obs;
  final RxString foundDate = ''.obs;
  final RxString foundTime = ''.obs;
  final RxString contactNumber = ''.obs;
  final RxString emergency = ''.obs;
  final RxString additionalDetails = ''.obs;

  // Images - this is captured/selected first in finder flow
  final RxList<XFile> selectedImages = <XFile>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('🟢 FinderReportController CREATED - hashCode: ${this.hashCode}');
  }

  @override
  void onClose() {
    print('🔴 FinderReportController DESTROYED - hashCode: ${this.hashCode}');
    super.onClose();
  }

  // Singleton instance
  static FinderReportController get instance {
    if (!Get.isRegistered<FinderReportController>()) {
      Get.put(FinderReportController());
    }
    return Get.find<FinderReportController>();
  }

  void setField(String key, String value) {
    print('📝 setField called - key: $key, value: $value, controller: ${this.hashCode}');
    switch (key) {
      case 'childName':
        childName.value = value;
        break;
      case 'fatherName':
        fatherName.value = value;
        break;
      case 'gender':
        gender.value = value;
        break;
      case 'placeFound':
        placeFound.value = value;
        break;
      case 'foundDate':
        foundDate.value = value;
        break;
      case 'foundTime':
        foundTime.value = value;
        break;
      case 'contactNumber':
        contactNumber.value = value;
        break;
      case 'emergency':
        emergency.value = value;
        break;
      case 'additionalDetails':
        additionalDetails.value = value;
        break;
    }
    print('   ✅ Field set - $key = ${_getFieldValue(key)}');
  }

  String _getFieldValue(String key) {
    switch (key) {
      case 'childName': return childName.value;
      case 'fatherName': return fatherName.value;
      case 'gender': return gender.value;
      case 'placeFound': return placeFound.value;
      case 'foundDate': return foundDate.value;
      case 'foundTime': return foundTime.value;
      case 'contactNumber': return contactNumber.value;
      case 'emergency': return emergency.value;
      case 'additionalDetails': return additionalDetails.value;
      default: return '';
    }
  }

  void updateImages(List<XFile> images) {
    selectedImages.value = images;
  }

  void addImage(XFile image) {
    selectedImages.add(image);
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) selectedImages.removeAt(index);
  }

  Future<FinderReportResponse> submitReport() async {
    try {
      isLoading.value = true;

      // Format foundTime if date and time are provided
      String? isoFoundTime;
      if (foundDate.value.isNotEmpty && foundTime.value.isNotEmpty) {
        isoFoundTime = _formatToISO(foundDate.value, foundTime.value);
      } else {
        // If not provided, backend will use current time
        isoFoundTime = null;
      }

      final request = FinderReportRequest(
        childName: childName.value.isEmpty ? null : childName.value,
        fatherName: fatherName.value.isEmpty ? null : fatherName.value,
        gender: gender.value.isEmpty ? null : gender.value,
        foundTime: isoFoundTime,
        contactNumber: contactNumber.value.isEmpty ? null : contactNumber.value,
        emergency: emergency.value.isEmpty ? null : emergency.value,
        placeFound: placeFound.value.isEmpty ? null : placeFound.value,
        additionalDetails: additionalDetails.value.isEmpty ? null : additionalDetails.value,
      );

      // Convert XFile list to File list
      final files = selectedImages.map((x) => File(x.path)).toList();
      print('📸 Images to upload: ${files.length}');
      for (var file in files) {
        print('  - ${file.path} (exists: ${file.existsSync()})');
      }

      final headers = <String, String>{};
      try {
        final auth = AuthController.instance;
        if (auth.isAuthenticated) {
          headers.addAll({'Authorization': 'Bearer ${auth.accessToken.value}'});
        }
      } catch (e) {
        // Auth controller may not be bound; ignore
      }

      final response = await _helper.createReport(request: request, images: files, headers: headers);

      isLoading.value = false;
      return response;
    } catch (e) {
      isLoading.value = false;
      return FinderReportResponse(success: false, message: e.toString(), data: null);
    }
  }

  // Helper to format date/time strings to ISO
  String _formatToISO(String dateStr, String timeStr) {
    try {
      // dateStr format: dd/MM/yyyy, timeStr format: HH:mm AM/PM
      if (dateStr.isEmpty) return DateTime.now().toIso8601String();
      
      final dateParts = dateStr.split('/');
      if (dateParts.length != 3) return DateTime.now().toIso8601String();
      
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      int hour = 12;
      int minute = 0;
      
      if (timeStr.isNotEmpty) {
        // Parse time like "2:30 PM"
        final timeRegex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)?', caseSensitive: false);
        final match = timeRegex.firstMatch(timeStr);
        if (match != null) {
          hour = int.parse(match.group(1)!);
          minute = int.parse(match.group(2)!);
          final period = match.group(3)?.toUpperCase();
          if (period == 'PM' && hour != 12) hour += 12;
          if (period == 'AM' && hour == 12) hour = 0;
        }
      }
      
      final dateTime = DateTime(year, month, day, hour, minute);
      return dateTime.toIso8601String();
    } catch (e) {
      print('⚠️ Date format error: $e');
      return DateTime.now().toIso8601String();
    }
  }

  // Clear all data (for starting a new report)
  void clearData() {
    childName.value = '';
    fatherName.value = '';
    gender.value = '';
    placeFound.value = '';
    foundDate.value = '';
    foundTime.value = '';
    contactNumber.value = '';
    emergency.value = '';
    additionalDetails.value = '';
    selectedImages.clear();
    isLoading.value = false;
  }
}
