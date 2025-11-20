import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../utils/constants/endpoints.dart';
import '../models/finder_report/finder_report_request.dart';
import '../models/finder_report/finder_report_response.dart';
import '../models/finder_report/my_finder_reports_response.dart';
import '../models/finder_report/finder_report_by_id_response.dart';

class FinderReportHelper {
  static final FinderReportHelper _instance = FinderReportHelper._internal();
  factory FinderReportHelper() => _instance;
  FinderReportHelper._internal();

  /// Sends finder report with optional image files (list of File paths)
  Future<FinderReportResponse> createReport({
    required FinderReportRequest request,
    List<File>? images,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$Base_URL$Finder_Report_Create');
      print('📤 Creating finder report: $uri');

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
        return FinderReportResponse.fromJson(decoded);
      } else {
        return FinderReportResponse(
          success: false,
          message: decoded['message'] ?? 'Failed to create report',
        );
      }
    } catch (e) {
      print('❌ createReport error: $e');
      return FinderReportResponse(success: false, message: 'An error occurred: $e');
    }
  }

  /// Get my finder reports with pagination and filtering
  /// 
  /// [accessToken] - JWT access token for authentication
  /// [page] - Page number (default: 1)
  /// [limit] - Items per page (default: 10)
  /// [status] - Filter by status (ACTIVE, CLOSED, RESOLVED, CANCELLED)
  /// [search] - Search in childName, fatherName, placeFound
  /// [sortBy] - Sort by field (default: "createdAt")
  /// [sortOrder] - Sort order: "asc" or "desc" (default: "desc")
  Future<MyFinderReportsResponse> getMyReports({
    required String accessToken,
    int page = 1,
    int limit = 10,
    String? status,
    String? search,
    String sortBy = 'createdAt',
    String sortOrder = 'desc',
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{
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

      final uri = Uri.parse(Base_URL + Finder_Report_My).replace(queryParameters: queryParams);

      print('📤 GET My Finder Reports Request');
      print('URL: $uri');
      print('Headers: Authorization: Bearer ${accessToken.substring(0, 20)}...');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      print('📥 Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('✅ Successfully fetched my finder reports');
        return MyFinderReportsResponse.fromJson(jsonResponse);
      } else {
        print('❌ Failed to fetch my finder reports: ${response.statusCode}');
        return MyFinderReportsResponse(
          success: false,
          data: MyFinderReportsData(
            reports: [],
            pagination: PaginationInfo(page: 1, limit: 10, total: 0, pages: 0),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('❌ Exception in getMyReports: $e');
      print('Stack trace: $stackTrace');
      return MyFinderReportsResponse(
        success: false,
        data: MyFinderReportsData(
          reports: [],
          pagination: PaginationInfo(page: 1, limit: 10, total: 0, pages: 0),
        ),
      );
    }
  }

  /// Get finder report by ID
  /// 
  /// [reportId] - UUID of the finder report
  /// [accessToken] - JWT access token for authentication
  Future<FinderReportByIdResponse> getReportById({
    required String reportId,
    required String accessToken,
  }) async {
    try {
      final uri = Uri.parse('$Base_URL$Finder_Report_By_Id/$reportId');

      print('📤 GET Finder Report By ID Request');
      print('URL: $uri');
      print('Report ID: $reportId');
      print('Headers: Authorization: Bearer ${accessToken.substring(0, 20)}...');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      print('📥 Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('✅ Successfully fetched finder report details');
        return FinderReportByIdResponse.fromJson(jsonResponse);
      } else {
        print('❌ Failed to fetch finder report: ${response.statusCode}');
        throw Exception('Failed to load finder report');
      }
    } catch (e, stackTrace) {
      print('❌ Exception in getReportById: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
