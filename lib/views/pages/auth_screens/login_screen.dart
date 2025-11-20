import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/dialogs/animated_loading_dialog.dart';
import 'package:locate_lost/views/widgets/custom_text_field.dart';
import 'package:locate_lost/controllers/auth_controller.dart';

import '../../widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPass = TextEditingController();

  bool _obscurePassword = true;
  
  // Get the auth controller using lazy binding
  AuthController get authController => Get.find<AuthController>();
  
  @override
  void initState() {
    super.initState();
  }

  // Show error dialog with retry option
  void _showErrorDialog(String error) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: EdgeInsets.all(28.w),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.1),
                      blurRadius: 30.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Error icon
                    Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline_rounded,
                        size: 40.sp,
                        color: Colors.red[600],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      'Login Failed',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      error,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Get.back(),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              _handleLogin(); // Retry
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Handle login process with error handling
  Future<void> _handleLogin() async {
    if (!_key.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields correctly.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        icon: Icon(Icons.warning_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
      return;
    }

    // Show animated loading
    if (mounted) {
      LoadingDialogHelper.show(
        context: context,
        message: 'Logging in...',
        subtitle: 'Please wait while we verify your credentials',
        showLogo: true,
      );
    }

    try {
      // Perform login using AuthController
      final response = await authController.login(
        cEmail.text.trim(),
        cPass.text,
      );

      // Close loading dialog
      if (mounted) {
        LoadingDialogHelper.hide(context);
      }

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
        );
        
        // Show location permission dialog
        _showLocationPermissionPopup();
      } else {
        // Show error message from API
        _showErrorDialog(response.message);
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) {
        LoadingDialogHelper.hide(context);
      }
      
      // Show error dialog
      _showErrorDialog('An error occurred: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Image.asset(
                  'assets/images/login.jpg',
                  width: 355.w,
                  height: 280.h,
                ),

                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t Have an account?',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Form with input fields and custom buttons
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        controller: cEmail,
                        fillColor: AppColors.background,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Email is required';
                          }
                          // Email validation regex
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      CustomTextFormField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        controller: cPass,
                        fillColor: AppColors.background,
                        isPassword: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password is required';
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      // Forgot password button with minimal gap
                      Transform.translate(
                        offset: Offset(0, -8.h), // Pull up closer to password field
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.forgotPassword);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h), // Small space before login button

                      // Login Button
                      Obx(() => CustomElevatedButton(
                        onPressed: () {
                          if (!authController.isLoading.value) {
                            _handleLogin();
                          }
                        },
                        height: 60.h,
                        width: 241.w,
                        fontSize: 20.sp,
                        borderRadius: 10.r,
                        label: authController.isLoading.value ? 'Please Wait...' : 'Log In',
                      )),
                      
                      SizedBox(height: 10.h),
                      
               
                   
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show location permission popup with skip option
  void _showLocationPermissionPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: EdgeInsets.all(32.w),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 40.r,
                      offset: Offset(0, 20.h),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: 80.r,
                      spreadRadius: 10.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced animated icon with pulsing effect
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.15),
                                  AppColors.primary.withValues(alpha: 0.05),
                                  Colors.transparent,
                                ],
                                stops: const [0.3, 0.7, 1.0],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.25,
                                  ),
                                  blurRadius: 30.r,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Pulsing ring animation
                                TweenAnimationBuilder<double>(
                                  duration: const Duration(seconds: 2),
                                  tween: Tween(begin: 0.8, end: 1.2),
                                  curve: Curves.easeInOut,
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        width: 60.w,
                                        height: 60.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                            width: 2.w,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Main icon
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 15.r,
                                        spreadRadius: 2.r,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.my_location_rounded,
                                    size: 28.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 28.h),

                    // Enhanced title with gradient text effect
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1000),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withValues(alpha: 0.8),
                                  ],
                                ).createShader(bounds),
                            child: Text(
                              'Enable Location Services',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.3,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Enhanced subtitle
                    TweenAnimationBuilder<Offset>(
                      duration: const Duration(milliseconds: 1200),
                      tween: Tween(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ),
                      curve: Curves.easeOutCubic,
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(0, offset.dy * 30.h),
                          child: Opacity(
                            opacity: 1 - offset.dy,
                            child: Text(
                              'Help us protect children by enabling location services',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Feature highlights with icons
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1400),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                width: 1.w,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildFeatureItem(
                                  Icons.search_rounded,
                                  'Match missing children in your area',
                                ),
                                SizedBox(height: 12.h),
                                _buildFeatureItem(
                                  Icons.notifications_active_rounded,
                                  'Get instant alerts for nearby cases',
                                ),
                                SizedBox(height: 12.h),
                                _buildFeatureItem(
                                  Icons.security_rounded,
                                  'Help authorities respond faster',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Enhanced animated buttons with hover effects
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1600),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Column(
                            children: [
                              // Primary button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    _enableLocationAndContinue();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    elevation: 12,
                                    shadowColor: AppColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Enable Location',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Secondary button - with warning
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                    _showLocationSkipWarning();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      side: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1.5.w,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Maybe Later',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.65),
    );
  }

  // Helper method for feature items
  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 16.sp, color: AppColors.primary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  // Navigate to home with fade animation
  void _navigateToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  // Enable location and navigate to home
  void _enableLocationAndContinue() async {
    try {
      // Call the existing LocationPermissionService
      //await LocationPermissionService.checkLocationPermissionAfterLogin();
      
      // Navigate to home after location permission
      _navigateToHome();
    } catch (e) {
      Get.snackbar(
        'Location Error',
        'An unexpected error occurred: $e',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }
  }

  // Show warning when user tries to skip location
  void _showLocationSkipWarning() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange[600], size: 24.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Location is Important!',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location services help us:',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _buildWarningItem(Icons.search_rounded, 'Show nearby missing children'),
            _buildWarningItem(Icons.notifications_active, 'Send urgent alerts'),
            _buildWarningItem(Icons.my_location, 'Help with accurate reporting'),
            _buildWarningItem(Icons.security, 'Improve response time'),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red[600], size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Without location, the app\'s effectiveness is significantly reduced.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    _navigateToHome();
                  },
                  child: Text(
                    'Continue Without Location',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _enableLocationAndContinue();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text(
                    'Enable Location',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for warning items
  Widget _buildWarningItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: AppColors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
