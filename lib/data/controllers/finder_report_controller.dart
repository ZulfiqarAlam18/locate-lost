import 'dart:io';
import 'package:get/get.dart';
import '../models/finder_report_model.dart';
import '../services/finder_report_service.dart';

class FinderReportController extends GetxController {
  final FinderReportService _reportService = FinderReportService();
  
  // Observable variables
  RxList<FinderReport> reports = <FinderReport>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCreating = false.obs;
  RxString errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadReports();
  }
  
  // Create new finder report
  Future<bool> createReport({
    String? childName,
    int? estimatedAge,
    required String gender,
    required String placeFound,
    required DateTime foundTime,
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
        estimatedAge: estimatedAge,
        gender: gender,
        placeFound: placeFound,
        foundTime: foundTime,
        clothes: clothes,
        additionalDetails: additionalDetails,
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
        images: images,
      );
      
      if (result.success) {
        reports.insert(0, result.data!);
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
  
  // Load all finder reports
  Future<void> loadReports({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _reportService.getAllReports(
        page: page,
        limit: limit,
        status: status,
      );
      
      if (result.success) {
        if (page == 1) {
          reports.value = result.data!;
        } else {
          reports.addAll(result.data!);
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
  
  // Refresh reports
  Future<void> refreshReports() async {
    await loadReports(page: 1);
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}