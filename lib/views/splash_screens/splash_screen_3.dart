import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/utils/app_colors.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,

      body: Stack(
        children: [
          Container(child: Image.asset('assets/images/Map3.png')),
          Positioned(
            top: 41.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash3.png',
                    width: 357.w,
                    height: 278.h,
                  ),
                  SizedBox(height: 72.h),
                  RichText(
                    text: TextSpan(
                      text: 'Bridging',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: ' the',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(text: ' Distance\n'),
                        TextSpan(
                          text: '   Between',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(text: ' Lost'),
                        TextSpan(
                          text: ' and\n',
                          style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(text: '             Found'),
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
