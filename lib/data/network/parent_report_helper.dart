import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../utils/constants/endpoints.dart';
import '../models/parent_report/parent_report_request.dart';
import '../models/parent_report/parent_report_response.dart';
import '../models/parent_report/my_parent_reports_response.dart';
import '../models/parent_report/parent_report_by_id_response.dart';

class ParentReportHelper {
  static final ParentReportHelper _instance = ParentReportHelper._internal();
  factory ParentReportHelper() => _instance;
  ParentReportHelper._internal();

  /// Sends parent report with optional image files (list of File paths)
  Future<ParentReportResponse> createReport({
    required ParentReportRequest request,
    List<File>? images,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$Base_URL$Parent_Report_Create');
      print('📤 Creating parent report: $uri');

      final http.MultipartRequest multipartRequest = http.MultipartRequest('POST', uri);

      // Attach form fields from request
      multipartRequest.fields.addAll(request.toFormData());

      // Attach headers if provided
      if (headers != null) {
        multipartRequest.headers.addAll(headers);
      }

      // Attach images with proper MIME types
      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          final file = images[i];
          if (!file.existsSync()) {
            print('⚠️ File not found: ${file.path}');
            continue;
          }
          
          // Determine MIME type from file extension
          String mimeType = 'image/jpeg'; // default
          final extension = file.path.toLowerCase().split('.').last;
          switch (extension) {
            case 'jpg':
            case 'jpeg':
              mimeType = 'image/jpeg';
              break;
            case 'png':
              mimeType = 'image/png';
              break;
            case 'gif':
              mimeType = 'image/gif';
              break;
            case 'webp':
              mimeType = 'image/webp';
              break;
            case 'bmp':
              mimeType = 'image/bmp';
              break;
            default:
              mimeType = 'image/jpeg';
          }
          
          final multipartFile = await http.MultipartFile.fromPath(
            'images',
            file.path,
            filename: file.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse(mimeType),
          );
          multipartRequest.files.add(multipartFile);
          print('📎 Added image ${i + 1}: ${file.path.split(Platform.pathSeparator).last} (${mimeType})');
        }
        print('✅ Total images attached: ${multipartRequest.files.length}');
      } else {
        print('⚠️ No images provided or images list is empty');
      }

      // Log request details
      print('📋 Request fields: ${multipartRequest.fields}');
      print('📋 Request headers: ${multipartRequest.headers}');
      print('📋 Request files count: ${multipartRequest.files.length}');

      final streamedResponse = await multipartRequest.send().timeout(const Duration(seconds: 60));
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ParentReportResponse.fromJson(decoded);
      } else {
        return ParentReportResponse(
          success: false,
          message: decoded['message'] ?? 'Failed to create report',
        );
      }
    } catch (e) {
      print('❌ createReport error: $e');
      return ParentReportResponse(success: false, message: 'An error occurred: $e');
    }
  }

  /// Fetches current user's parent reports
  /// GET /api/reports/parent/my
  Future<MyParentReportsResponse> getMyReports({
    Map<String, String>? headers,
    int page = 1,
    int limit = 10,
    String? status,
    String? search,
    String sortBy = 'createdAt',
    String sortOrder = 'desc',
  }) async {
    try {
      // Build query parameters
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'sortBy': sortBy,
        'sortOrder': sortOrder,
      };
      
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final uri = Uri.parse('$Base_URL$Parent_Report_My').replace(queryParameters: queryParams);
      print('📤 Fetching my parent reports: $uri');

      final response = await http.get(
        uri,
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return MyParentReportsResponse.fromJson(decoded);
      } else {
        return MyParentReportsResponse(
          success: false,
          message: decoded['message'] ?? 'Failed to fetch reports',
        );
      }
    } catch (e) {
      print('❌ getMyReports error: $e');
      return MyParentReportsResponse(
        success: false,
        message: 'An error occurred: $e',
      );
    }
  }

  /// Fetches a specific parent report by ID
  /// GET /api/reports/parent/{reportId}
  Future<ParentReportByIdResponse> getReportById({
    required String reportId,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$Base_URL$Parent_Report_By_Id/$reportId');
      print('📤 Fetching parent report by ID: $uri');

      final response = await http.get(
        uri,
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ParentReportByIdResponse.fromJson(decoded);
      } else {
        return ParentReportByIdResponse(
          success: false,
          message: decoded['message'] ?? 'Failed to fetch report details',
        );
      }
    } catch (e) {
      print('❌ getReportById error: $e');
      return ParentReportByIdResponse(
        success: false,
        message: 'An error occurred: $e',
      );
    }
  }
}
