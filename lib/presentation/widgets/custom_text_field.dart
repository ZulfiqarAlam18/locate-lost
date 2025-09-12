import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Widget? suffixIcon;
  final Color? fillColor; // background color
  final double? height; // height of input field

  const CustomTextFormField({
    super.key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
    this.suffixIcon,
    this.fillColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: SizedBox(
        height: height ?? 75.h, // Fixed height that includes space for error text
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
          //  labelText: labelText,
            labelText: labelText?.isNotEmpty == true ? labelText : null,
            hintText: hintText,
            filled: fillColor != null,
            fillColor: fillColor,
            prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12.r),
            ),
            errorMaxLines: 1, // Limit error text to single line
            errorStyle: TextStyle(
              fontSize: 12.sp,
              height: 1.2, // Control line height of error text
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
      ),
    );
  }
}
