import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import  'package:locat_lost/widgets/custom_text_field.dart';
import 'package:locat_lost/utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/animated_loading_dialog.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPass = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Simulate login with error handling
  Future<bool> _performLogin() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate random failure for demo (remove in production)
      // if (Random().nextBool()) {
      //   throw Exception('Network error');
      // }
      
      return true; // Success
    } catch (e) {
      return false; // Failure
    }
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
        'Please enter a valid email and password',
        backgroundColor: Colors.orange[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(Icons.warning_rounded, color: Colors.white),
      );
      return;
    }

    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    // Show animated loading
    if (mounted) {
      LoadingDialogHelper.show(
        context: context,
        message: 'Logging in...',
        subtitle: 'Please wait while we verify your credentials',
        showLogo: true,
      );
    }

    // Perform login
    final success = await _performLogin();
    
    // Close loading dialog
    if (mounted) {
      LoadingDialogHelper.hide(context);
    }
    
    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Show location permission dialog
      _showLocationPermissionPopup();
    } else {
      // Show error dialog with retry
      _showErrorDialog('Unable to connect to server. Please check your internet connection and try again.');
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
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
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
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
                      Container(
                        padding: EdgeInsets.only(
                          left: 195.w,
                          right: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            'forgot password?',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Removing extra spacing between fields
                      SizedBox(
                        height: 15.h,
                      ), // Only a small gap between button and fields
                      
                      // Simple Login Button
                      CustomElevatedButton(
                        onPressed: () {
                          if (!_isLoading) {
                            _handleLogin();
                          }
                        },
                        height: 60.h,
                        width: 241.w,
                        fontSize: 20.sp,
                        borderRadius: 10.r,
                        label: _isLoading ? 'Please Wait...' : 'Log In',
                      ),
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
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: EdgeInsets.all(28.w),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 30.r,
                      offset: Offset(0, 10.h),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 60.r,
                      spreadRadius: 5.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated icon with glow effect
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.1),
                                  AppColors.primary.withValues(alpha: 0.05),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 20.r,
                                  spreadRadius: 2.r,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.location_on_rounded,
                              size: 40.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Title with fade-in animation
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: Text(
                            'Enable Location Services',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Description with slide-in animation
                    TweenAnimationBuilder<Offset>(
                      duration: const Duration(milliseconds: 1000),
                      tween: Tween(begin: const Offset(0, 0.3), end: Offset.zero),
                      curve: Curves.easeOut,
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(0, offset.dy * 20.h),
                          child: Text(
                            'Enable location to help match missing children in your area and notify nearby authorities quickly.',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 32.h),
                    
                    // Animated buttons
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1200),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                    // Skip location and go to home
                                    _navigateToHome();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      side: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1.5.w,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Skip for Now',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(width: 16.w),
                              
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    // Enable location and go to home
                                    _enableLocationAndContinue();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    elevation: 8,
                                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                                  ),
                                  child: Text(
                                    'Enable Location',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
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
      barrierColor: Colors.black.withValues(alpha: 0.6),
    );
  }

  // Navigate to home with fade animation
  void _navigateToHome() {
    // Add subtle delay for better UX
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }

  // Enable location and navigate to home
  void _enableLocationAndContinue() async {
    // Show success message with better styling
    Get.snackbar(
      'Location Enabled! 🎉',
      'Location services are now active. Ready to help keep children safe!',
      backgroundColor: Colors.green[600],
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.3),
          blurRadius: 20.r,
          offset: Offset(0, 8.h),
        ),
      ],
    );
    
    // Add slight delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Navigate to home
    _navigateToHome();
  }
}
