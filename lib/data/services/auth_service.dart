import '../models/user_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class AuthService extends BaseApiService {
  
  // Register new user
  Future<ApiResponse<User>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String role = 'PARENT',
  }) async {
    try {
      // Use full URL to avoid baseUrl issues
      final response = await post('${BaseApiService.apiBaseUrl}/api/auth/signup', {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final userData = result['data']['data'];
        storeAuthToken(userData['accessToken']);
        
        return ApiResponse.success(
          User.fromJson(userData['user']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // Login user
  Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Use full URL to avoid baseUrl issues
      final response = await post('${BaseApiService.apiBaseUrl}/api/auth/login', {
        'email': email,
        'password': password,
      });
      
      // Debug: Print the full response
      print('🔍 Login Response Status: ${response.statusCode}');
      print('🔍 Login Response Body: ${response.body}');
      print('🔍 Login Response Type: ${response.body.runtimeType}');
      
      final result = handleResponse(response);
      print('🔍 Handled Response: $result');
      
      if (result['success']) {
        final responseData = result['data'];
        print('🔍 Response Data: $responseData');
        print('🔍 Response Data Type: ${responseData.runtimeType}');
        
        // Handle different possible response structures
        dynamic userData;
        String? accessToken;
        
        if (responseData is Map<String, dynamic>) {
          // If responseData has nested 'data' field
          if (responseData.containsKey('data')) {
            userData = responseData['data'];
            if (userData is Map<String, dynamic>) {
              accessToken = userData['accessToken'];
              userData = userData['user'];
            }
          } else if (responseData.containsKey('user')) {
            // Direct user field
            userData = responseData['user'];
            accessToken = responseData['accessToken'];
          } else {
            // Assume responseData is the user data itself
            userData = responseData;
            accessToken = responseData['accessToken'];
          }
        } else {
          userData = responseData;
        }
        
        print('🔍 User Data: $userData');
        print('🔍 Access Token: $accessToken');
        
        if (accessToken != null) {
          storeAuthToken(accessToken);
        }
        
        return ApiResponse.success(
          User.fromJson(userData), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e, stackTrace) {
      print('❌ Login Error: $e');
      print('❌ Stack Trace: $stackTrace');
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // Logout user
  Future<ApiResponse<bool>> logout() async {
    try {
      await post('/api/auth/logout', {});
      removeAuthToken();
      return ApiResponse.success(true, 'Logged out successfully');
    } catch (e) {
      removeAuthToken(); // Still remove token locally
      return ApiResponse.success(true, 'Logged out locally');
    }
  }
  
  // Check if user is logged in
  bool isLoggedIn() {
    return getAuthToken() != null;
  }
}