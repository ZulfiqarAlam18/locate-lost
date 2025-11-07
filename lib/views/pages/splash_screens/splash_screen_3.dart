import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/app_colors.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.surfaceVariant.withOpacity(0.3)],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/Map3.png'),
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Hero Image Section
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.55,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 30,
                          offset: Offset(0, 15),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Image.asset(
                        'assets/images/splash3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Content Section
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.35,
                    ),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Connection icon
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.connect_without_contact_rounded,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Main message with enhanced typography
                          Column(
                            children: [
                              // First row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Bridging ',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'the ',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Distance',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // Second row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Between ',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Lost',
                                      style: TextStyle(
                                        color: AppColors.error,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' and ',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Found',
                                      style: TextStyle(
                                        color: AppColors.success,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          // Subtitle
                          Text(
                            'Every search brings hope closer to home',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
