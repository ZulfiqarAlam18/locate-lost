import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/parent_report/parent_report_request.dart';
import '../data/network/parent_report_helper.dart';
import 'auth_controller.dart';
import '../data/models/parent_report/parent_report_response.dart';

class ParentReportController extends GetxController {
  static ParentReportController get instance => Get.find<ParentReportController>();

  // Form fields matching API spec
  final RxString childName = ''.obs;
  final RxString fatherName = ''.obs;
  final RxString gender = ''.obs;
  final RxString placeLost = ''.obs;
  final RxString lostDate = ''.obs;
  final RxString lostTime = ''.obs;
  final RxString contactNumber = ''.obs;
  final RxString emergency = ''.obs;
  final RxString additionalDetails = ''.obs;

  final RxBool isLoading = false.obs;
  final RxList<XFile> selectedImages = <XFile>[].obs;

  final ParentReportHelper _helper = ParentReportHelper();

  void setField(String key, String value) {
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
      case 'placeLost':
        placeLost.value = value;
        break;
      case 'lostDate':
        lostDate.value = value;
        break;
      case 'lostTime':
        lostTime.value = value;
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
  }

  void addImage(XFile file) {
    if (selectedImages.length >= 5) return;
    selectedImages.add(file);
  }

  void updateImages(List<XFile> imgs) {
    selectedImages.assignAll(imgs);
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < selectedImages.length) selectedImages.removeAt(index);
  }

  Future<ParentReportResponse> submitReport() async {
    try {
      isLoading.value = true;

      // Combine date and time into ISO string for lostTime
      String isoLostTime = _formatToISO(lostDate.value, lostTime.value);

      final request = ParentReportRequest(
        childName: childName.value,
        fatherName: fatherName.value,
        gender: gender.value,
        lostTime: isoLostTime,
        contactNumber: contactNumber.value,
        emergency: emergency.value,
        placeLost: placeLost.value.isEmpty ? null : placeLost.value,
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
      return ParentReportResponse(success: false, message: e.toString(), data: null);
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
}
