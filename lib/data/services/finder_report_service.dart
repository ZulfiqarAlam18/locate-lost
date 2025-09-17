import 'dart:io';
import 'package:get/get.dart';
import '../models/finder_report_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class FinderReportService extends BaseApiService {
  
  // Create found child report
  Future<ApiResponse<FinderReport>> createReport({
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
      final form = FormData({
        if (childName != null && childName.isNotEmpty) 'childName': childName,
        if (estimatedAge != null) 'estimatedAge': estimatedAge.toString(),
        'gender': gender,
        'placeFound': placeFound,
        'foundTime': foundTime.toIso8601String(),
        if (clothes != null && clothes.isNotEmpty) 'clothes': clothes,
        if (additionalDetails != null && additionalDetails.isNotEmpty) 
          'additionalDetails': additionalDetails,
        if (latitude != null) 'latitude': latitude.toString(),
        if (longitude != null) 'longitude': longitude.toString(),
        if (locationName != null && locationName.isNotEmpty) 
          'locationName': locationName,
      });
      
      // Add image files
      for (File image in images) {
        form.files.add(MapEntry(
          'images', 
          MultipartFile(image, filename: image.path.split('/').last),
        ));
      }
      
      final response = await post('/api/reports/finder', form);
      
      if (response.statusCode == 201) {
        return ApiResponse.success(
          FinderReport.fromJson(response.body['data']), 
          response.body['message'] ?? 'Report created successfully',
        );
      } else {
        return ApiResponse.error(
          response.body['message'] ?? 'Failed to create report'
        );
      }
    } catch (e) {
      return ApiResponse.error('Error creating report: $e');
    }
  }
  
  // Get all finder reports
  Future<ApiResponse<List<FinderReport>>> getAllReports({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (status != null) query['status'] = status;
      
      final response = await get('/api/reports/finder', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> reportsJson = result['data']['data']['reports'];
        final reports = reportsJson
            .map((json) => FinderReport.fromJson(json))
            .toList();
        
        return ApiResponse.success(reports, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching reports: $e');
    }
  }
}