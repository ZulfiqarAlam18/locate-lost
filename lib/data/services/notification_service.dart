import '../models/notification_model.dart';
import '../models/api_response.dart';
import 'base_api_service.dart';

class NotificationService extends BaseApiService {
  
  // Get user notifications
  Future<ApiResponse<List<NotificationModel>>> getNotifications({
    int page = 1,
    int limit = 20,
    bool? isRead,
    String? type,
  }) async {
    try {
      Map<String, dynamic> query = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (isRead != null) query['isRead'] = isRead.toString();
      if (type != null) query['type'] = type;
      
      final response = await get('/api/notifications', query: query);
      
      final result = handleResponse(response);
      
      if (result['success']) {
        final List<dynamic> notificationsJson = result['data']['data']['notifications'];
        final notifications = notificationsJson
            .map((json) => NotificationModel.fromJson(json))
            .toList();
        
        return ApiResponse.success(notifications, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching notifications: $e');
    }
  }
  
  // Mark notification as read
  Future<ApiResponse<NotificationModel>> markAsRead(String notificationId) async {
    try {
      final response = await put('/api/notifications/$notificationId/read', {});
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          NotificationModel.fromJson(result['data']['data']), 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error marking notification as read: $e');
    }
  }
  
  // Mark all notifications as read
  Future<ApiResponse<bool>> markAllAsRead() async {
    try {
      final response = await put('/api/notifications/mark-all-read', {});
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(true, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error marking all notifications as read: $e');
    }
  }
  
  // Delete notification
  Future<ApiResponse<bool>> deleteNotification(String notificationId) async {
    try {
      final response = await delete('/api/notifications/$notificationId');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(true, result['message']);
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error deleting notification: $e');
    }
  }
  
  // Get unread count
  Future<ApiResponse<int>> getUnreadCount() async {
    try {
      final response = await get('/api/notifications/unread-count');
      
      final result = handleResponse(response);
      
      if (result['success']) {
        return ApiResponse.success(
          result['data']['data']['count'], 
          result['message'],
        );
      } else {
        return ApiResponse.error(result['message']);
      }
    } catch (e) {
      return ApiResponse.error('Error fetching unread count: $e');
    }
  }
}