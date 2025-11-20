import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../utils/constants/endpoints.dart';
import '../models/finder_report/finder_report_request.dart';
import '../models/finder_report/finder_report_response.dart';

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
}
