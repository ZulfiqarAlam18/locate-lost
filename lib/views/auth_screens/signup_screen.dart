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
  final TextEditingController cCNIC = TextEditingController();
  final TextEditingController cMail = TextEditingController();
  final TextEditingController cPass = TextEditingController();
  final TextEditingController ccPass = TextEditingController();
  final TextEditingController cNum = TextEditingController();

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
                        labelText: 'Name',
                        hintText: 'Name',
                        controller: cName,
                        fillColor: AppColors.background,
                      ),
                      CustomTextFormField(
                        labelText: 'E-Mail Address',
                        hintText: 'E-Mail Address',
                        controller: cMail,
                        fillColor: AppColors.background,
                      ),
                      CustomTextFormField(
                        labelText: 'Phone Number',
                        hintText: 'Phone Number',
                        controller: cNum,
                        fillColor: AppColors.background,
                      ),
                      CustomTextFormField(
                        labelText: 'CNIC Number',
                        hintText: 'CNIC Number',
                        controller: cCNIC,
                        fillColor: AppColors.background,
                      ),
                      CustomTextFormField(
                        labelText: 'Password',
                        hintText: 'Password',
                        controller: cPass,
                        fillColor: AppColors.background,
                      ),
                      CustomTextFormField(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm',
                        controller: ccPass,
                        fillColor: AppColors.background,
                      ),

                      // Removing extra spacing between fields
                      SizedBox(
                        height: 15.h,
                      ), // Only a small gap between button and fields
                      // Custom Button
                      CustomElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
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
