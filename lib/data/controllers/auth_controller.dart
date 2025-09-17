import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  // Observable variables
  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  
  // Getters
  bool get isLoggedIn => user.value != null;
  
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  
  // Check if user is already logged in
  void checkLoginStatus() {
    if (_authService.isLoggedIn()) {
      // You can fetch user profile here if needed
      // For now, we'll just mark as logged in
    }
  }
  
  // Login method
  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _authService.login(email: email, password: password);
      
      if (result.success) {
        user.value = result.data;
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Login Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Register method
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String role = 'PARENT',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _authService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );
      
      if (result.success) {
        user.value = result.data;
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Registration Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Logout method
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      await _authService.logout();
      user.value = null;
      errorMessage.value = '';
      
      Get.offAllNamed('/login');
      Get.snackbar(
        'Success', 
        'Logged out successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Logout failed: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}