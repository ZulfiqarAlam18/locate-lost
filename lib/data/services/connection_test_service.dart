import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_api_service.dart';

class ConnectionTestService {
  
  // Test basic connection to backend
  static Future<Map<String, dynamic>> testConnection() async {
    try {
      print('🔍 Testing connection to: ${BaseApiService.apiBaseUrl}');
      
      // First try with a shorter timeout to fail faster
      final response = await http.get(
        Uri.parse('${BaseApiService.apiBaseUrl}/'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
      
      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');
      
      return {
        'success': response.statusCode == 200 || response.statusCode == 404,
        'statusCode': response.statusCode,
        'message': response.statusCode == 200 || response.statusCode == 404 
            ? 'Backend server is reachable' 
            : 'Server responded but with error',
        'responseBody': response.body,
        'serverReachable': true,
      };
      
    } catch (e) {
      print('❌ Connection failed: $e');
      
      // Try to get more specific error information
      String errorMessage = 'Connection failed: $e';
      if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Connection timed out. Backend server might not be accessible from this device.';
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'Network error. Check if IP address is correct and server is running.';
      }
      
      return {
        'success': false,
        'message': errorMessage,
        'serverReachable': false,
      };
    }
  }
  
  // Test specific health endpoint (if your backend has one)
  static Future<Map<String, dynamic>> testHealthEndpoint() async {
    try {
      print('🏥 Testing health endpoint: ${BaseApiService.apiBaseUrl}/health');
      
      final response = await http.get(
        Uri.parse('${BaseApiService.apiBaseUrl}/health'),  // Changed from /api/health to /health
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('🏥 Health response: ${response.statusCode} - ${response.body}');
      
      // If health endpoint doesn't exist, try other common endpoints
      if (response.statusCode == 404) {
        print('🔄 Health endpoint not found, trying alternative endpoints...');
        
        // Try root endpoint
        final rootResponse = await http.get(
          Uri.parse('${BaseApiService.apiBaseUrl}/'),
          headers: {'Content-Type': 'application/json'},
        ).timeout(const Duration(seconds: 10));
        
        if (rootResponse.statusCode == 200) {
          return {
            'success': true,
            'statusCode': rootResponse.statusCode,
            'message': 'Backend server is running (via root endpoint)',
            'responseBody': rootResponse.body,
          };
        }
      }
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
      print('🔐 Testing auth endpoint: ${BaseApiService.apiBaseUrl}/api/auth/signin');
      
      // Try to hit signin endpoint with dummy data to see if it responds (expecting 400/401, not connection error)
      final response = await http.post(
        Uri.parse('${BaseApiService.apiBaseUrl}/api/auth/signin'),
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
  
  // Test localhost as fallback
  static Future<Map<String, dynamic>> testLocalhost() async {
    try {
      print('🏠 Testing localhost fallback: http://localhost:5000/health');
      
      final response = await http.get(
        Uri.parse('http://localhost:5000/health'),  // Changed from /api/health to /health
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
      
      print('🏠 Localhost response: ${response.statusCode} - ${response.body}');
      
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'message': response.statusCode == 200 
            ? 'Localhost connection successful' 
            : 'Localhost responded with error',
        'responseBody': response.body,
      };
      
    } catch (e) {
      print('❌ Localhost test failed: $e');
      return {
        'success': false,
        'message': 'Localhost test failed: $e',
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
    
    // Test 4: Localhost fallback (try if main IP fails)
    print('\n🏠 Test 4: Localhost Fallback');
    results['localhostTest'] = await testLocalhost();
    
    // Summary
    bool anySuccess = results['basicConnection']['success'] || 
                     results['healthCheck']['success'] || 
                     results['authEndpoint']['success'] ||
                     results['localhostTest']['success'];
    
    results['overallSuccess'] = anySuccess;
    
    if (anySuccess) {
      if (results['localhostTest']['success'] && !results['basicConnection']['success']) {
        results['summary'] = '✅ Backend reachable via localhost only! Update IP to 127.0.0.1 or 192.168.x.x';
      } else {
        results['summary'] = '✅ Backend is reachable!';
      }
    } else {
      results['summary'] = '❌ Backend is not reachable. Check if server is running.';
    }
    
    print('\n📋 Connection Test Summary:');
    print('Backend URL: ${BaseApiService.apiBaseUrl}');
    print('Overall Result: ${results['summary']}');
    
    return results;
  }
}