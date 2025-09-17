import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_api_service.dart';

class ConnectionTestService {
  
  // Test basic connection to backend
  static Future<Map<String, dynamic>> testConnection() async {
    try {
      print('🔍 Testing connection to: ${BaseApiService.apiBaseUrl}');
      
      // Test basic connectivity using health endpoint (more reliable than root)
      final response = await http.get(
        Uri.parse('${BaseApiService.apiBaseUrl}/health'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');
      
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'message': response.statusCode == 200 ? 'Backend server is reachable' : 'Server responded but with error',
        'responseBody': response.body,
        'serverReachable': true,
      };
      
    } catch (e) {
      print('❌ Connection failed: $e');
      return {
        'success': false,
        'message': 'Connection failed: $e',
        'serverReachable': false,
      };
    }
  }
  
  // Test specific health endpoint (if your backend has one)
  static Future<Map<String, dynamic>> testHealthEndpoint() async {
    try {
      print('🏥 Testing health endpoint: ${BaseApiService.apiBaseUrl}/health');
      
      final response = await http.get(
        Uri.parse('${BaseApiService.apiBaseUrl}/health'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('🏥 Health response: ${response.statusCode} - ${response.body}');
      
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'message': response.statusCode == 200 ? 'Health check passed' : 'Health check failed',
        'responseBody': response.body,
      };
      
    } catch (e) {
      print('❌ Health check failed: $e');
      return {
        'success': false,
        'message': 'Health check failed: $e',
      };
    }
  }
  
  // Test authentication endpoint
  static Future<Map<String, dynamic>> testAuthEndpoint() async {
    try {
      print('🔐 Testing auth endpoint: ${BaseApiService.apiBaseUrl}/api/auth/login');
      
      // Try to hit login endpoint with dummy data to see if it responds
      final response = await http.post(
        Uri.parse('${BaseApiService.apiBaseUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': 'test@test.com',
          'password': 'test123',
        }),
      ).timeout(const Duration(seconds: 10));
      
      print('🔐 Auth response: ${response.statusCode} - ${response.body}');
      
      // 401 is expected for dummy credentials, 200 would mean success
      final isWorking = response.statusCode == 401 || response.statusCode == 200;
      
      return {
        'success': isWorking,
        'statusCode': response.statusCode,
        'message': isWorking 
            ? 'Auth endpoint is working (${response.statusCode == 401 ? "401 expected for test data" : "login successful"})'
            : 'Auth endpoint error: ${response.statusCode}',
        'responseBody': response.body,
        'endpointExists': true,
      };
      
    } catch (e) {
      print('❌ Auth endpoint test failed: $e');
      return {
        'success': false,
        'message': 'Auth endpoint test failed: $e',
        'endpointExists': false,
      };
    }
  }
  
  // Run all connection tests
  static Future<Map<String, dynamic>> runAllTests() async {
    print('🚀 Starting backend connectivity tests...');
    
    final results = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'backendUrl': BaseApiService.apiBaseUrl,
    };
    
    // Test 1: Basic connection
    print('\n📡 Test 1: Basic Connection');
    results['basicConnection'] = await testConnection();
    
    // Test 2: Health endpoint
    print('\n🏥 Test 2: Health Endpoint');
    results['healthCheck'] = await testHealthEndpoint();
    
    // Test 3: Auth endpoint
    print('\n🔐 Test 3: Auth Endpoint');
    results['authEndpoint'] = await testAuthEndpoint();
    
    // Summary
    bool anySuccess = results['basicConnection']['success'] || 
                     results['healthCheck']['success'] || 
                     results['authEndpoint']['success'];
    
    results['overallSuccess'] = anySuccess;
    results['summary'] = anySuccess 
        ? '✅ Backend is reachable!' 
        : '❌ Backend is not reachable. Check if server is running and IP is correct.';
    
    print('\n📋 Connection Test Summary:');
    print('Backend URL: ${BaseApiService.apiBaseUrl}');
    print('Overall Result: ${results['summary']}');
    
    return results;
  }
}