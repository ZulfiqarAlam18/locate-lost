import 'dart:io';
import 'package:get/get.dart';
import '../models/parent_report_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class ParentReportService extends BaseApiService {
  
  // Create missing child report
  Future<ApiResponse<ParentReport>> createReport({
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
      final form = FormData({
        'childName': childName,
        'childAge': age.toString(),
        'description': '${clothes ?? ''} ${additionalDetails ?? ''}'.trim(),
        'lastSeenLocation': placeLost,
        'contactInfo': '${additionalDetails ?? ''}'.trim(),
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
      
      print('--- HTTP REQUEST DEBUG ---');
      print('Base URL: ${httpClient.baseUrl}');
      print('Endpoint: /api/reports/parent');  // Updated endpoint
      print('Full URL: ${httpClient.baseUrl}/api/reports/parent');
      print('Form data: ${form.fields}');
      print('Files count: ${form.files.length}');
      print('Auth token exists: ${getAuthToken() != null}');
      if (getAuthToken() != null) {
        print('Auth token preview: ${getAuthToken()!.substring(0, 20)}...');
      }
      
      final response = await post('/api/reports/parent', form);  // Updated endpoint
      
      print('--- HTTP RESPONSE DEBUG ---');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');
      
      if (response.statusCode == 201) {
        print('SUCCESS: Creating ParentReport from response data');
        return ApiResponse.success(
          ParentReport.fromJson(response.body['data']), 
          response.body['message'] ?? 'Report created successfully',
        );
      } else {
        print('ERROR: Status code ${response.statusCode}');
        print('Error message: ${response.body['message'] ?? 'Failed to create report'}');
        return ApiResponse.error(
          response.body['message'] ?? 'Failed to create report'
        );
      }
    } catch (e) {
      print('--- NETWORK EXCEPTION ---');
      print('Error type: ${e.runtimeType}');
      print('Error message: $e');
      return ApiResponse.error('Error creating report: $e');
    }
  }
  
  // Get user's reports
  Future<ApiResponse<List<ParentReport>>> getMyReports({
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
      
      final response = await get('/api/parent-reports/my-reports', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> reportsJson = result['data']['data']['reports'];
        final reports = reportsJson
            .map((json) => ParentReport.fromJson(json))
            .toList();
        
        return ApiResponse.success(reports, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching reports: $e');
    }
  }
  
  // Get all parent reports (public)
  Future<ApiResponse<List<ParentReport>>> getAllReports({
    int page = 1,
    int limit = 10,
    String? status,
    String? gender,
    int? minAge,
    int? maxAge,
    String? location,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (status != null) query['status'] = status;
      if (gender != null) query['gender'] = gender;
      if (minAge != null) query['minAge'] = minAge.toString();
      if (maxAge != null) query['maxAge'] = maxAge.toString();
      if (location != null) query['location'] = location;
      
      final response = await get('/api/parent-reports', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> reportsJson = result['data']['data']['reports'];
        final reports = reportsJson
            .map((json) => ParentReport.fromJson(json))
            .toList();
        
        return ApiResponse.success(reports, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching reports: $e');
    }
  }
  
  // Get report by ID
  Future<ApiResponse<ParentReport>> getReportById(String reportId) async {
    try {
      final response = await get('/api/parent-reports/$reportId');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          ParentReport.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching report: $e');
    }
  }
  
  // Update report status
  Future<ApiResponse<ParentReport>> updateReportStatus(
    String reportId, 
    String status,
  ) async {
    try {
      final response = await put('/api/parent-reports/$reportId', {
        'status': status,
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          ParentReport.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error updating report: $e');
    }
  }
}