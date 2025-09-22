import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseApiService extends GetConnect {
  // 🔥 BACKEND SERVER CONFIGURATION
  // LocateLost Backend Server
  static const String apiBaseUrl = 'http://192.168.2.150:5000';  // Updated to correct IP // Your backend server IP
  // static const String apiBaseUrl = 'http://10.0.2.2:5000'; // Android emulator localhost  
  // static const String apiBaseUrl = 'http://localhost:5000'; // For web/desktop development
  // static const String apiBaseUrl = 'http://192.168.1.100:5000'; // Alternative IP
  final storage = GetStorage();
  
  @override
  void onInit() {
    httpClient.baseUrl = apiBaseUrl;
    httpClient.timeout = Duration(seconds: 30);
    
    // Request interceptor
    httpClient.addRequestModifier<dynamic>((request) async {
      final token = getAuthToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      // Only set Content-Type for non-FormData requests
      // GetConnect will handle multipart/form-data automatically
      if (request.files == null || (request.files?.files.isEmpty ?? true)) {
        request.headers['Content-Type'] = 'application/json';
      }
      return request;
    });
    
    // Response interceptor
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.statusCode == 401) {
        handleUnauthorized();
      }
      return response;
    });
    
    super.onInit();
  }
  
  // Get stored auth token
  String? getAuthToken() {
    return storage.read('access_token');
  }

  // Test backend connectivity
  Future<bool> testConnectivity() async {
    try {
      print('--- TESTING BACKEND CONNECTIVITY ---');
      print('Base URL: $apiBaseUrl');
      print('Testing endpoint: /health');
      
      final response = await get('/health');  // Use /health instead of /
      
      print('Health check response:');
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      print('Headers: ${response.headers}');
      
      return response.statusCode == 200; // Health endpoint should return 200
    } catch (e) {
      print('Health check failed with error: $e');
      return false;
    }
  }

  // Get headers with auth token
  Future<Map<String, String>> getHeaders() async {
    final token = getAuthToken();
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
  
  // Store auth token
  void storeAuthToken(String token) {
    storage.write('access_token', token);
  }
  
  // Remove auth token
  void removeAuthToken() {
    storage.remove('access_token');
  }
  
  // Handle unauthorized access
  void handleUnauthorized() {
    removeAuthToken();
    Get.offAllNamed('/login'); // Navigate to login using GetX
  }
  
  // Test backend connection
  Future<bool> testConnection() async {
    try {
      final response = await get('/health');
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
  
  // Handle API response
  Map<String, dynamic> handleResponse(Response response) {
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return {
          'success': true,
          'data': response.body,
          'message': response.body['message'] ?? 'Success',
        };
      } else {
        return {
          'success': false,
          'message': response.body['message'] ?? 'Request failed',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to parse response: $e',
      };
    }
  }
}