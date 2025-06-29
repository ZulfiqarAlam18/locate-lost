import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/utils/app_colors.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/Map1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 41.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/splash1.png',
                    width: 357.w,
                    height: 278.h,
                  ),
                  SizedBox(height: 67.h),
                  RichText(
                    text: TextSpan(
                      text: 'Reuniting\n',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: 'Loved Ones,\nOne ',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 30.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'Search',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 30.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' at\na time',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}












