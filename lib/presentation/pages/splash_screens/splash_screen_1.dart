import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

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
          image: AssetImage('assets/images/Map1.png'),
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
                        'assets/images/splash1.png',
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
                          // Title with icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.family_restroom,
                                  color: AppColors.primary,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Text(
                                  'Family Reunion',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          // Main message
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Reuniting ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Loved Ones\n',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'One ',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Search ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'at a Time',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
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
