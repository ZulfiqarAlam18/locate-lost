import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';

import '../../utils/constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double fontSize;
  final double borderRadius;
  final String label;

  // Optional fields with defaults
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color foregroundColor;
  final FontWeight fontWeight;
  final bool showBorder;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.borderRadius,
    required this.label,
    this.padding,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.secondary,
    this.fontWeight = FontWeight.w500,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            side: showBorder
                ? BorderSide(color: Colors.teal)
                : BorderSide.none,
          ),
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
