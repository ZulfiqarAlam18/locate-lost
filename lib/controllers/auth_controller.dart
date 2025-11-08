import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/auth/login_request.dart';
import '../data/models/auth/signup_request.dart';
import '../data/models/auth/auth_response.dart';
import '../data/network/auth_helper.dart';

class AuthController extends GetxController {
  // Singleton pattern
  static AuthController get instance => Get.find<AuthController>();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Auth tokens
  final RxString accessToken = ''.obs;
  final RxString refreshToken = ''.obs;
  
  // User data
  final RxString userId = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userPhone = ''.obs;
  final RxString userRole = ''.obs;
  final RxString userProfileImage = ''.obs;
  final RxBool isVerified = false.obs;

  // Auth helper instance
  final AuthHelper _authHelper = AuthHelper();

  // SharedPreferences keys
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyAccessToken = 'accessToken';
  static const String _keyRefreshToken = 'refreshToken';
  static const String _keyUserId = 'userId';
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserPhone = 'userPhone';
  static const String _keyUserRole = 'userRole';
  static const String _keyUserProfileImage = 'userProfileImage';
  static const String _keyIsVerified = 'isVerified';

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      isLoggedIn.value = prefs.getBool(_keyIsLoggedIn) ?? false;
      accessToken.value = prefs.getString(_keyAccessToken) ?? '';
      refreshToken.value = prefs.getString(_keyRefreshToken) ?? '';
      userId.value = prefs.getString(_keyUserId) ?? '';
      userName.value = prefs.getString(_keyUserName) ?? '';
      userEmail.value = prefs.getString(_keyUserEmail) ?? '';
      userPhone.value = prefs.getString(_keyUserPhone) ?? '';
      userRole.value = prefs.getString(_keyUserRole) ?? '';
      userProfileImage.value = prefs.getString(_keyUserProfileImage) ?? '';
      isVerified.value = prefs.getBool(_keyIsVerified) ?? false;

      print('✅ User data loaded from SharedPreferences');
      print('📱 Logged in: ${isLoggedIn.value}');
      print('👤 User: ${userName.value}');
    } catch (e) {
      print('❌ Error loading user data: $e');
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData(AuthData authData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyAccessToken, authData.accessToken);
      await prefs.setString(_keyRefreshToken, authData.refreshToken);
      await prefs.setString(_keyUserId, authData.user.id);
      await prefs.setString(_keyUserName, authData.user.name);
      await prefs.setString(_keyUserEmail, authData.user.email);
      await prefs.setString(_keyUserPhone, authData.user.phone);
      await prefs.setString(_keyUserRole, authData.user.role);
      await prefs.setString(_keyUserProfileImage, authData.user.profileImage ?? '');
      await prefs.setBool(_keyIsVerified, authData.user.isVerified);

      // Update observable variables
      isLoggedIn.value = true;
      accessToken.value = authData.accessToken;
      refreshToken.value = authData.refreshToken;
      userId.value = authData.user.id;
      userName.value = authData.user.name;
      userEmail.value = authData.user.email;
      userPhone.value = authData.user.phone;
      userRole.value = authData.user.role;
      userProfileImage.value = authData.user.profileImage ?? '';
      isVerified.value = authData.user.isVerified;

      print('✅ User data saved to SharedPreferences');
    } catch (e) {
      print('❌ Error saving user data: $e');
    }
  }

  // Clear user data from SharedPreferences
  Future<void> _clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.remove(_keyIsLoggedIn);
      await prefs.remove(_keyAccessToken);
      await prefs.remove(_keyRefreshToken);
      await prefs.remove(_keyUserId);
      await prefs.remove(_keyUserName);
      await prefs.remove(_keyUserEmail);
      await prefs.remove(_keyUserPhone);
      await prefs.remove(_keyUserRole);
      await prefs.remove(_keyUserProfileImage);
      await prefs.remove(_keyIsVerified);

      // Clear observable variables
      isLoggedIn.value = false;
      accessToken.value = '';
      refreshToken.value = '';
      userId.value = '';
      userName.value = '';
      userEmail.value = '';
      userPhone.value = '';
      userRole.value = '';
      userProfileImage.value = '';
      isVerified.value = false;

      print('✅ User data cleared from SharedPreferences');
    } catch (e) {
      print('❌ Error clearing user data: $e');
    }
  }

  // Login method
  Future<AuthResponse> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = LoginRequest(
        email: email,
        password: password,
      );

      final response = await _authHelper.login(request);

      if (response.success && response.data != null) {
        await _saveUserData(response.data!);
        print('✅ Login successful for: ${response.data!.user.name}');
      } else {
        errorMessage.value = response.message;
        print('❌ Login failed: ${response.message}');
      }

      isLoading.value = false;
      return response;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'An unexpected error occurred';
      print('❌ Login exception: $e');
      return AuthResponse(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  // Register method
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String role = 'PARENT',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = SignupRequest(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );

      final response = await _authHelper.signup(request);

      if (response.success && response.data != null) {
        await _saveUserData(response.data!);
        print('✅ Signup successful for: ${response.data!.user.name}');
      } else {
        errorMessage.value = response.message;
        print('❌ Signup failed: ${response.message}');
      }

      isLoading.value = false;
      return response;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'An unexpected error occurred';
      print('❌ Signup exception: $e');
      return AuthResponse(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Call logout API if needed
      if (refreshToken.value.isNotEmpty) {
        await _authHelper.logout(refreshToken.value);
      }

      // Clear local data
      await _clearUserData();
      
      print('✅ Logout successful');
      isLoading.value = false;
    } catch (e) {
      print('❌ Logout error: $e');
      isLoading.value = false;
      // Still clear local data even if API call fails
      await _clearUserData();
    }
  }

  // Check if user is authenticated
  bool get isAuthenticated => isLoggedIn.value && accessToken.value.isNotEmpty;

  // Get auth headers for API calls
  Map<String, String> get authHeaders => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${accessToken.value}',
  };
}
