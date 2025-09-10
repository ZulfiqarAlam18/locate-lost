import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'dart:async';

import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_elevated_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  
  late AnimationController _animationController;
  late AnimationController _submitController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  String _otpCode = '';
  bool _isCodeComplete = false;
  bool _hasError = false;
  String _errorMessage = '';
  
  // Timer for resend functionality
  late Timer _timer;
  int _resendCountdown = 30;
  bool _canResend = false;
  
  // Phone number (could be passed from previous screen)
  String _phoneNumber = '+92 XXX XXXXXXX';
  
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startResendTimer();
    _setupAutoFill();
  }
  
  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _submitController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _submitController, curve: Curves.elasticOut),
    );
    
    _animationController.forward();
  }
  
  void _setupAutoFill() {
    // Listen for SMS autofill (in a real app, you'd use SMS autofill packages)
    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(() => _onCodeChanged());
    }
  }
  
  void _startResendTimer() {
    _resendCountdown = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }
  
  void _onCodeChanged() {
    String code = _controllers.map((controller) => controller.text).join();
    setState(() {
      _otpCode = code;
      _isCodeComplete = code.length == 6;
      _hasError = false;
      _errorMessage = '';
    });
    
    if (_isCodeComplete) {
      _submitController.forward();
    } else {
      _submitController.reverse();
    }
  }
  
  void _onDigitChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste operation
      _handlePaste(value, index);
      return;
    }
    
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _onCodeChanged();
  }
  
  void _handlePaste(String pastedText, int startIndex) {
    // Extract only digits
    String digits = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
    
    for (int i = 0; i < 6 && i < digits.length; i++) {
      if (startIndex + i < 6) {
        _controllers[startIndex + i].text = digits[i];
      }
    }
    
    // Focus on the next empty field or unfocus if all filled
    int nextIndex = (startIndex + digits.length).clamp(0, 5);
    if (nextIndex < 6 && _controllers[nextIndex].text.isEmpty) {
      _focusNodes[nextIndex].requestFocus();
    } else {
      _focusNodes[nextIndex.clamp(0, 5)].unfocus();
    }
    
    _onCodeChanged();
  }
  
  void _verifyOtp() async {
    if (!_isCodeComplete) return;
    
    // Show loading state
    setState(() {
      _hasError = false;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate verification (replace with actual API call)
    bool isValid = _otpCode == '123456'; // Mock validation
    
    if (isValid) {
      // Success animation and navigation
      _showSuccessAndNavigate();
    } else {
      // Show error
      setState(() {
        _hasError = true;
        _errorMessage = 'Invalid code. Please try again.';
      });
      _shakeFields();
    }
  }
  
  void _showSuccessAndNavigate() {
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8.w),
            Text('Code verified successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    
    // Navigate to login screen for signup/reset password flows
    Future.delayed(Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }
  
  void _shakeFields() {
    // Add shake animation for error feedback
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }
  
  void _resendCode() {
    if (!_canResend) return;
    
    // Clear current inputs
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
    
    // Restart timer
    _startResendTimer();
    
    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code resent to $_phoneNumber'),
        backgroundColor: AppColors.primary,
      ),
    );
    
    setState(() {
      _hasError = false;
      _errorMessage = '';
    });
  }
  
  String _formatCountdown() {
    int minutes = _resendCountdown ~/ 60;
    int seconds = _resendCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _submitController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, _slideAnimation.value / 100),
              end: Offset.zero,
            ).animate(_animationController),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  
                  // Header Section
                  _buildHeader(),
                  
                  SizedBox(height: 50.h),
                  
                  // OTP Input Section
                  _buildOtpInputs(),
                  
                  if (_hasError) ...[
                    SizedBox(height: 16.h),
                    _buildErrorMessage(),
                  ],
                  
                  SizedBox(height: 40.h),
                  
                  // Resend Section
                  _buildResendSection(),
                  
                  SizedBox(height: 30.h),
                  
                  // Change Number Link
                  _buildChangeNumberLink(),
                  
                  Spacer(),
                  
                  // Submit Button
                  _buildSubmitButton(),
                  
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Column(
      children: [
        // Icon or Illustration
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.message_outlined,
            size: 40.sp,
            color: AppColors.primary,
          ),
        ),
        
        SizedBox(height: 24.h),
        
        Text(
          'Enter the 6-digit code',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 12.h),
        
        Text(
          'We sent it to $_phoneNumber',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  Widget _buildOtpInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) => _buildOtpBox(index)),
    );
  }
  
  Widget _buildOtpBox(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 50.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _hasError 
              ? Colors.red
              : _focusNodes[index].hasFocus 
                  ? AppColors.primary
                  : Colors.grey[300]!,
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) => _onDigitChanged(index, value),
        onTap: () {
          // Clear field on tap for better UX
          _controllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: _controllers[index].text.length),
          );
        },
        onSubmitted: (value) {
          if (_isCodeComplete) {
            _verifyOtp();
          }
        },
        autofillHints: [AutofillHints.oneTimeCode],
      ),
    );
  }
  
  Widget _buildErrorMessage() {
    return AnimatedOpacity(
      opacity: _hasError ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResendSection() {
    return Column(
      children: [
        if (!_canResend)
          Text(
            'Resend code in ${_formatCountdown()}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          )
        else
          GestureDetector(
            onTap: _resendCode,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildChangeNumberLink() {
    return GestureDetector(
      onTap: () {
        Get.back(); // Go back to enter phone number
      },
      child: Text(
        'Change phone number',
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
  
  Widget _buildSubmitButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedOpacity(
        opacity: _isCodeComplete ? 1.0 : 0.5,
        duration: Duration(milliseconds: 200),
        child: CustomElevatedButton(
          onPressed: () {
            if (_isCodeComplete) {
              _verifyOtp();
            }
          },
          height: 56.h,
          width: double.infinity,
          fontSize: 18.sp,
          borderRadius: 16.r,
          label: 'Verify Code',
        ),
      ),
    );
  }
}
