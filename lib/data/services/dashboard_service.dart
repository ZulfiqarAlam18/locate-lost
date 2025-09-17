import '../models/dashboard_stats_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class DashboardService extends BaseApiService {
  
  // Get dashboard statistics
  Future<ApiResponse<DashboardStats>> getStats() async {
    try {
      final response = await get('/api/dashboard/stats');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          DashboardStats.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching stats: $e');
    }
  }
  
  // Get recent activities
  Future<ApiResponse<List<RecentActivity>>> getRecentActivities({
    int limit = 10,
  }) async {
    try {
      final response = await get('/api/dashboard/activities', query: {
        'limit': limit.toString(),
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> activitiesJson = result['data']['data']['activities'];
        final activities = activitiesJson
            .map((json) => RecentActivity.fromJson(json))
            .toList();
        
        return ApiResponse.success(activities, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching activities: $e');
    }
  }
  
  // Get user summary
  Future<ApiResponse<Map<String, dynamic>>> getUserSummary() async {
    try {
      final response = await get('/api/dashboard/user-summary');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          result['data']['data'], 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching user summary: $e');
    }
  }
  
  // Get analytics data
  Future<ApiResponse<Map<String, dynamic>>> getAnalytics({
    String period = 'week', // week, month, year
  }) async {
    try {
      final response = await get('/api/dashboard/analytics', query: {
        'period': period,
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          result['data']['data'], 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching analytics: $e');
    }
  }
}