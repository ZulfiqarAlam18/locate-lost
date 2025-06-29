import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/widgets/custom_elevated_button.dart';
import 'package:locat_lost/utils/app_colors.dart';
import 'package:locat_lost/views/splash_screens/splash_screen_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth_screens/signup_screen.dart';
import 'splash_screen_2.dart';
import 'splash_screen_3.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          SizedBox(height: 71.h),
          Text(
            'LocateLost',
            style: TextStyle(
              fontSize: 40.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: AppColors.primary,
            indent: 90.w,
            endIndent: 90.w,
            thickness: 2.h,
          ),

          Expanded(
            child: PageView(
              controller: _controller,
              children: [SplashScreen1(), SplashScreen2(), SplashScreen3()],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(bottom: 27.h),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,

              effect: WormEffect(
                dotColor: AppColors.myBlackColor,
                dotHeight: 12.h,
                dotWidth: 12.w,

                activeDotColor: AppColors.primary,

                spacing: 12.w,
              ),
            ),
          ),

          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            height: 60.h,
            width: 241.w,
            fontSize: 25.sp,
            borderRadius: 10.r,
            label: 'Get Started',
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
