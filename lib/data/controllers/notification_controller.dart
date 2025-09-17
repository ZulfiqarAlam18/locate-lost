import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  
  // Observable variables
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxInt unreadCount = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadNotifications();
    loadUnreadCount();
  }
  
  // Load notifications
  Future<void> loadNotifications({
    int page = 1,
    int limit = 20,
    bool? isRead,
    String? type,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _notificationService.getNotifications(
        page: page,
        limit: limit,
        isRead: isRead,
        type: type,
      );
      
      if (result.success) {
        if (page == 1) {
          notifications.value = result.data!;
        } else {
          notifications.addAll(result.data!);
        }
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final result = await _notificationService.markAsRead(notificationId);
      
      if (result.success) {
        // Update notification in list
        final index = notifications.indexWhere((notif) => notif.id == notificationId);
        if (index != -1) {
          notifications[index] = result.data!;
        }
        
        // Update unread count
        loadUnreadCount();
      } else {
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
  
  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      final result = await _notificationService.markAllAsRead();
      
      if (result.success) {
        // Update all notifications to read
        for (int i = 0; i < notifications.length; i++) {
          notifications[i] = NotificationModel(
            id: notifications[i].id,
            userId: notifications[i].userId,
            title: notifications[i].title,
            message: notifications[i].message,
            type: notifications[i].type,
            data: notifications[i].data,
            isRead: true,
            createdAt: notifications[i].createdAt,
            updatedAt: notifications[i].updatedAt,
          );
        }
        
        unreadCount.value = 0;
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
  
  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final result = await _notificationService.deleteNotification(notificationId);
      
      if (result.success) {
        notifications.removeWhere((notif) => notif.id == notificationId);
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
  
  // Load unread count
  Future<void> loadUnreadCount() async {
    try {
      final result = await _notificationService.getUnreadCount();
      
      if (result.success) {
        unreadCount.value = result.data!;
      }
    } catch (e) {
      print('Error loading unread count: $e');
    }
  }
  
  // Refresh notifications
  Future<void> refreshNotifications() async {
    await loadNotifications(page: 1);
    await loadUnreadCount();
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}