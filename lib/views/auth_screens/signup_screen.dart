import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/widgets/custom_text_field.dart';
import 'package:locat_lost/utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../routes/app_routes.dart';

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
                      // Custom Button
                      CustomElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            // All validation passed
                            Get.toNamed(AppRoutes.otpVerification);
                          } else {
                            // Show validation error
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
                          }
                        },
                        height: 60.h,
                        width: 241.w,
                        fontSize: 20.sp,
                        borderRadius: 10.r,
                        label: 'Create Account',
                      ),
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
