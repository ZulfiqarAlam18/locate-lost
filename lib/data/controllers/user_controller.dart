import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();
  
  // Observable variables
  RxList<User> users = <User>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  
  // Load all users (Admin only)
  Future<void> loadUsers({
    int page = 1,
    int limit = 20,
    String? role,
    bool? isActive,
    String? search,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _userService.getAllUsers(
        page: page,
        limit: limit,
        role: role,
        isActive: isActive,
        search: search,
      );
      
      if (result.success) {
        if (page == 1) {
          users.value = result.data!;
        } else {
          users.addAll(result.data!);
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
  
  // Update user (Admin only)
  Future<bool> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      final result = await _userService.updateUser(userId, updates);
      
      if (result.success) {
        // Update user in list
        final index = users.indexWhere((user) => user.id == userId);
        if (index != -1) {
          users[index] = result.data!;
        }
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Change password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await _userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      
      if (result.success) {
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Delete account
  Future<bool> deleteAccount({
    required String password,
    required String confirmText,
  }) async {
    try {
      final result = await _userService.deleteAccount(
        password: password,
        confirmText: confirmText,
      );
      
      if (result.success) {
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}