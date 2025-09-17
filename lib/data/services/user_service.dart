import '../models/user_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class UserService extends BaseApiService {
  
  // Get all users (Admin only)
  Future<ApiResponse<List<User>>> getAllUsers({
    int page = 1,
    int limit = 20,
    String? role,
    bool? isActive,
    String? search,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (role != null) query['role'] = role;
      if (isActive != null) query['isActive'] = isActive.toString();
      if (search != null && search.isNotEmpty) query['search'] = search;
      
      final response = await get('/api/users', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> usersJson = result['data']['data']['users'];
        final users = usersJson
            .map((json) => User.fromJson(json))
            .toList();
        
        return ApiResponse.success(users, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching users: $e');
    }
  }
  
  // Get user by ID
  Future<ApiResponse<User>> getUserById(String userId) async {
    try {
      final response = await get('/api/users/$userId');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          User.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching user: $e');
    }
  }
  
  // Update user (Admin only)
  Future<ApiResponse<User>> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      final response = await put('/api/users/$userId', updates);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          User.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error updating user: $e');
    }
  }
  
  // Change password
  Future<ApiResponse<bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await put('/api/users/password', {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(true, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error changing password: $e');
    }
  }
  
  // Delete account
  Future<ApiResponse<bool>> deleteAccount({
    required String password,
    required String confirmText,
  }) async {
    try {
      final response = await delete('/api/users/account');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(true, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error deleting account: $e');
    }
  }
}