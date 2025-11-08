import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/custom_elevated_button.dart';
import 'package:locate_lost/views/widgets/custom_text_field.dart';
import 'package:locate_lost/controllers/auth_controller.dart';
import 'package:locate_lost/views/dialogs/animated_loading_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cName = TextEditingController();
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPass = TextEditingController();
  final TextEditingController ccPass = TextEditingController();
  final TextEditingController cNum = TextEditingController();

  // Password visibility state
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  
  // Get the auth controller using lazy binding
  AuthController get authController => Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Show terms and conditions dialog when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTermsAndConditionsDialog();
    });
  }

  Future<void> _handleSignup() async {
    if (!_termsAccepted) {
      Get.snackbar(
        'Terms Required',
        'Please accept the Terms & Conditions to create an account',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }
    
    if (!_key.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields correctly',
        backgroundColor: Colors.orange[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(Icons.warning_rounded, color: Colors.white),
      );
      return;
    }
    
    // Check password match
    if (cPass.text != ccPass.text) {
      Get.snackbar(
        'Password Mismatch',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
      return;
    }
    
    // Show loading dialog
    if (mounted) {
      LoadingDialogHelper.show(
        context: context,
        message: 'Creating Account...',
        subtitle: 'Please wait while we set up your account',
        showLogo: true,
      );
    }

    try {
      // Perform signup using AuthController
      final response = await authController.register(
        name: cName.text.trim(),
        email: cEmail.text.trim(),
        phone: cNum.text.trim(),
        password: cPass.text,
      );

      // Close loading dialog
      if (mounted) {
        LoadingDialogHelper.hide(context);
      }

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          'Account created successfully! Please login to continue.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        
        // Navigate to login screen (user needs to login after signup)
        Get.offAllNamed(AppRoutes.login);
      } else {
        // Show error message from API
        Get.snackbar(
          'Signup Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          icon: Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) {
        LoadingDialogHelper.hide(context);
      }
      
      // Show error dialog
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
    }
  }

  void _showTermsAndConditionsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must accept or decline
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTermsSection(
                              'Welcome to LocateLost',
                              'Our mission is to reunite missing children with their families using advanced facial recognition technology. By creating an account, you agree to use this service responsibly.',
                            ),
                            _buildTermsSection(
                              'Your Responsibility',
                              'You must provide accurate information. Any misleading, false, or harmful use of this application will result in account suspension and possible legal action.',
                            ),
                            _buildTermsSection(
                              'Our Role',
                              'We are technology facilitators, not an official rescue or law enforcement body. We do not verify user identities or guarantee successful matches. The developers hold no legal responsibility for misuse.',
                            ),
                            _buildTermsSection(
                              'AI Technology',
                              'Our facial recognition system is automated and may not always be 100% accurate. All matches should be treated as potential leads, not confirmations.',
                            ),
                            _buildTermsSection(
                              'Privacy & Data',
                              'Your personal data and photos are processed solely for matching purposes. We never share, sell, or misuse your information. All data is securely stored and encrypted.',
                            ),
                            _buildTermsSection(
                              'Important Notice',
                              'Always report missing persons to local authorities in addition to using our app. We cannot guarantee successful matches or reunions.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Agreement Section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _termsAccepted,
                                activeColor: AppColors.primary,
                                onChanged: (value) {
                                  setState(() {
                                    _termsAccepted = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'I have read and agree to the Terms & Conditions. I understand that this app is a technology platform to assist in finding missing persons and that I should also report to local authorities.',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop(); // Go back to splash/previous screen
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  child: Text(
                                    'Decline',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _termsAccepted
                                      ? () {
                                          Navigator.of(context).pop();
                                          // User can now proceed with signup
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _termsAccepted 
                                        ? AppColors.primary 
                                        : Colors.grey,
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTermsSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
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

                Text(
                  'Create an account',
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
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
                        'Login',
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
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        controller: cName,
                        fillColor: AppColors.background,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Name is required';
                          }
                          if (value!.length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
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
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        controller: cNum,
                        fillColor: AppColors.background,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Phone number is required';
                          }
                          if (value!.length < 10) {
                            return 'Please enter a valid phone number';
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
                      CustomTextFormField(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        controller: ccPass,
                        fillColor: AppColors.background,
                        isPassword: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please confirm your password';
                          }
                          if (value != cPass.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      // Removing extra spacing between fields
                      SizedBox(
                        height: 15.h,
                      ), // Only a small gap between button and fields

                      // Terms and conditions reminder
                      TextButton(
                        onPressed: () {
                          _showTermsAndConditionsDialog();
                        },
                        child: Text(
                          'Review Terms & Conditions',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 10.h),
                      
                      // Custom Button
                      Obx(() => CustomElevatedButton(
                        onPressed: () {
                          if (!authController.isLoading.value) {
                            _handleSignup();
                          }
                        },
                        height: 60.h,
                        width: 241.w,
                        fontSize: 20.sp,
                        borderRadius: 10.r,
                        label: authController.isLoading.value ? 'Creating Account...' : 'Create Account',
                      )),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  '--------or SignUp with---------',
                  style: TextStyle(color: Colors.black45, fontSize: 14.sp),
                ),

                SizedBox(height: 20.h),

                // Social Media Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialIconButton(icon: Icons.facebook, onPressed: () {}),
                    SocialIconButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),
                    SocialIconButton(icon: Icons.apple, onPressed: () {}),
                  ],
                ),

                SizedBox(height: 30.h),

                // Temporary Skip Authentication Button for Testing
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.orange.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '🧪 TESTING MODE',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextButton(
                        onPressed: () {
                          // Show confirmation dialog
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                'Skip Authentication',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: Text(
                                'This is for testing only. Skip signup and go directly to home screen?',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back(); // Close dialog
                                    Get.offAllNamed(AppRoutes.mainNavigation);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Skip Authentication (Testing)',
                          style: TextStyle(
                            color: Colors.orange.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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
}

// Social Icon Button for consistent design
class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.teal, size: 24.sp),
      ),
    );
  }
}
