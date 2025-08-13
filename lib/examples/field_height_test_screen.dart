import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../presentation/widgets/custom_text_field.dart';
import '../core/constants/app_colors.dart';

class FieldHeightTestScreen extends StatefulWidget {
  const FieldHeightTestScreen({super.key});

  @override
  State<FieldHeightTestScreen> createState() => _FieldHeightTestScreenState();
}

class _FieldHeightTestScreenState extends State<FieldHeightTestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _showValidation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Height Test'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          autovalidateMode: _showValidation 
            ? AutovalidateMode.always 
            : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Test consistent field height with/without errors',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24.h),
              
              // Email field
              CustomTextFormField(
                labelText: 'Email Address',
                hintText: 'Enter your email',
                controller: _emailController,
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
              
              // Password field
              CustomTextFormField(
                labelText: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                fillColor: AppColors.background,
                isPassword: true,
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
              
              // Name field
              CustomTextFormField(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                controller: _nameController,
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
              
              SizedBox(height: 24.h),
              
              // Toggle validation button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showValidation = !_showValidation;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showValidation ? Colors.red[600] : AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  _showValidation ? 'Hide Validation Errors' : 'Show Validation Errors',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Validate button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All fields are valid!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Validate Form',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Instructions
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '1. Leave fields empty and toggle "Show Validation Errors"\n'
                      '2. Notice field heights remain consistent\n'
                      '3. Fill fields correctly and validate\n'
                      '4. Test with invalid email format',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//    onTap: () => Get.toNamed(AppRoutes.missingPersonDetails),