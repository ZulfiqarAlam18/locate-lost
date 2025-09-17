import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class ProfileService extends BaseApiService {
  
  // Get current user profile
  Future<ApiResponse<User>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('${BaseApiService.apiBaseUrl}/api/profile'),
        headers: await getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(
          User.fromJson(data['data']['user']), 
          data['message'] ?? 'Profile fetched successfully',
        );
      } else {
        return ApiResponse.error(data['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      return ApiResponse.error('Error fetching profile: $e');
    }
  }
  
  // Update profile
  Future<ApiResponse<User>> updateProfile({
    String? name,
    String? phone,
    String? cnic,
    String? address,
    File? profileImage,
  }) async {
    try {
      final token = await getAuthToken();
      if (token == null) {
        return ApiResponse.error('Authentication required');
      }
      
      var request = http.MultipartRequest(
        'PUT', 
        Uri.parse('${BaseApiService.apiBaseUrl}/api/profile'),
      );
      
      // Add headers
      request.headers['Authorization'] = 'Bearer $token';
      
      // Add form fields
      if (name != null && name.isNotEmpty) request.fields['name'] = name;
      if (phone != null && phone.isNotEmpty) request.fields['phone'] = phone;
      if (cnic != null && cnic.isNotEmpty) request.fields['cnic'] = cnic;
      if (address != null && address.isNotEmpty) request.fields['address'] = address;
      
      // Add profile image if provided
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', profileImage.path),
        );
      }
      
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(
          User.fromJson(data['data']['user']), 
          data['message'] ?? 'Profile updated successfully',
        );
      } else {
        return ApiResponse.error(data['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      return ApiResponse.error('Error updating profile: $e');
    }
  }
  
  // Change password
  Future<ApiResponse<bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${BaseApiService.apiBaseUrl}/api/users/password'),
        headers: await getHeaders(),
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(true, data['message'] ?? 'Password changed successfully');
      } else {
        return ApiResponse.error(data['message'] ?? 'Failed to change password');
      }
    } catch (e) {
      return ApiResponse.error('Error changing password: $e');
    }
  }
}