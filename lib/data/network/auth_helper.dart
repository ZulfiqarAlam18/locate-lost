import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants/endpoints.dart';
import '../models/auth/login_request.dart';
import '../models/auth/signup_request.dart';
import '../models/auth/auth_response.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();
  factory AuthHelper() => _instance;
  AuthHelper._internal();

  // Login API call
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      print('🔐 Attempting login for: ${request.email}');
      
      final url = Uri.parse('$Base_URL${Login_Endpoint}');
      print('📤 POST request to: $url');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('✅ Login successful');
        return AuthResponse.fromJson(responseData);
      } else {
        print('❌ Login failed: ${responseData['message']}');
        return AuthResponse(
          success: false,
          message: responseData['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      print('❌ Login error: $e');
      return AuthResponse(
        success: false,
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }

  // Signup API call
  Future<AuthResponse> signup(SignupRequest request) async {
    try {
      print('📝 Attempting signup for: ${request.email}');
      
      final url = Uri.parse('$Base_URL${Register_Endpoint}');
      print('📤 POST request to: $url');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('✅ Signup successful');
        return AuthResponse.fromJson(responseData);
      } else {
        print('❌ Signup failed: ${responseData['message']}');
        return AuthResponse(
          success: false,
          message: responseData['message'] ?? 'Signup failed',
        );
      }
    } catch (e) {
      print('❌ Signup error: $e');
      return AuthResponse(
        success: false,
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }

  // Logout API call (optional - mainly for token invalidation on backend)
  Future<bool> logout(String refreshToken) async {
    try {
      print('🚪 Attempting logout');
      
      final url = Uri.parse('${Base_URL}/api/auth/logout');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'refreshToken': refreshToken}),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );

      print('📥 Logout response: ${response.statusCode}');

      return response.statusCode == 200;
    } catch (e) {
      print('❌ Logout error: $e');
      return false;
    }
  }
}
