import 'dart:io';
import 'package:get/get.dart';
import '../models/parent_report_model.dart';
import '../services/parent_report_service.dart';

class ParentReportController extends GetxController {
  final ParentReportService _reportService = ParentReportService();
  
  // Observable variables
  RxList<ParentReport> reports = <ParentReport>[].obs;
  RxList<ParentReport> myReports = <ParentReport>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCreating = false.obs;
  RxString errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadMyReports();
  }
  
  // Create new report
  Future<bool> createReport({
    required String childName,
    required int age,
    required String gender,
    required String placeLost,
    required DateTime lostTime,
    String? clothes,
    String? additionalDetails,
    double? latitude,
    double? longitude,
    String? locationName,
    required List<File> images,
  }) async {
    try {
      isCreating.value = true;
      errorMessage.value = '';
      
      final result = await _reportService.createReport(
        childName: childName,
        age: age,
        gender: gender,
        placeLost: placeLost,
        lostTime: lostTime,
        clothes: clothes,
        additionalDetails: additionalDetails,
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
        images: images,
      );
      
      if (result.success) {
        myReports.insert(0, result.data!);
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isCreating.value = false;
    }
  }
  
  // Load user's reports
  Future<void> loadMyReports({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _reportService.getMyReports(
        page: page,
        limit: limit,
        status: status,
      );
      
      if (result.success) {
        if (page == 1) {
          myReports.value = result.data!;
        } else {
          myReports.addAll(result.data!);
        }
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load all reports (public)
  Future<void> loadAllReports({
    int page = 1,
    int limit = 20,
    String? status,
    String? gender,
    int? minAge,
    int? maxAge,
    String? location,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _reportService.getAllReports(
        page: page,
        limit: limit,
        status: status,
        gender: gender,
        minAge: minAge,
        maxAge: maxAge,
        location: location,
      );
      
      if (result.success) {
        if (page == 1) {
          reports.value = result.data!;
        } else {
          reports.addAll(result.data!);
        }
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Update report status
  Future<bool> updateReportStatus(String reportId, String status) async {
    try {
      final result = await _reportService.updateReportStatus(reportId, status);
      
      if (result.success) {
        // Update the report in the list
        final index = myReports.indexWhere((report) => report.id == reportId);
        if (index != -1) {
          myReports[index] = result.data!;
        }
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
  
  // Refresh reports
  Future<void> refreshReports() async {
    await loadMyReports(page: 1);
  }
}