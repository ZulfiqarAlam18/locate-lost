import '../models/match_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class MatchService extends BaseApiService {
  
  // Get matches for current user
  Future<ApiResponse<List<MatchedCase>>> getMyMatches({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (status != null) query['status'] = status;
      
      final response = await get('/api/matches/my', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> matchesJson = result['data']['data']['matches'];
        final matches = matchesJson
            .map((json) => MatchedCase.fromJson(json))
            .toList();
        
        return ApiResponse.success(matches, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching matches: $e');
    }
  }
  
  // Get all matches (admin/police only)
  Future<ApiResponse<List<MatchedCase>>> getAllMatches({
    int page = 1,
    int limit = 10,
    String? status,
    String? matchType,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (status != null) query['status'] = status;
      if (matchType != null) query['matchType'] = matchType;
      
      final response = await get('/api/matches', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> matchesJson = result['data']['data']['matches'];
        final matches = matchesJson
            .map((json) => MatchedCase.fromJson(json))
            .toList();
        
        return ApiResponse.success(matches, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching matches: $e');
    }
  }
  
  // Get match by ID
  Future<ApiResponse<MatchedCase>> getMatchById(String matchId) async {
    try {
      final response = await get('/api/matches/$matchId');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          MatchedCase.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching match: $e');
    }
  }
  
  // Confirm a match
  Future<ApiResponse<MatchedCase>> confirmMatch(String matchId) async {
    try {
      final response = await post('/api/matches/$matchId/confirm', {});
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          MatchedCase.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error confirming match: $e');
    }
  }
  
  // Reject a match
  Future<ApiResponse<MatchedCase>> rejectMatch(String matchId, String reason) async {
    try {
      final response = await post('/api/matches/$matchId/reject', {
        'reason': reason,
      });
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          MatchedCase.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error rejecting match: $e');
    }
  }
  
  // Get match statistics
  Future<ApiResponse<Map<String, dynamic>>> getMatchStats() async {
    try {
      final response = await get('/api/matches/stats');
      
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
      return ApiResponse.error('Error fetching match stats: $e');
    }
  }
}