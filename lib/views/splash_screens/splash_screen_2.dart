import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/utils/app_colors.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // Background Map Image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/Map2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          Positioned(
            top: 41.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/splash2.png',
                      width: 357.w,
                      height: 278.h,
                    ),
                    SizedBox(height: 123.h),
                    Text(
                      'Hope\nAction\nReunion',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
