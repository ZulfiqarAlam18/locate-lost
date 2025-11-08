import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants/app_colors.dart';
import 'splash_screen_1.dart';
import '../../../navigation/app_routes.dart';
import 'splash_screen_2.dart';
import 'splash_screen_3.dart';
import '../../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _checkFirstTimeAndNavigate();
  }

  Future<void> _checkFirstTimeAndNavigate() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // First time opening the app - show onboarding screens
      // Don't navigate, just show the PageView
      return;
    } else {
      // Not first time - check if user is logged in
      _checkAuthAndNavigate();
    }
  }

  Future<void> _checkAuthAndNavigate() async {
    try {
      // Initialize AuthController to load saved data
      final authController = Get.put(AuthController());
      
      // Wait a bit for controller to initialize
      await Future.delayed(const Duration(milliseconds: 500));

      if (authController.isLoggedIn.value) {
        // User is logged in - go to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        // User is not logged in - go to login
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print('Error checking auth: $e');
      // On error, go to login
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> _markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.secondary, AppColors.surfaceVariant],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Enhanced Header Section
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                child: Column(
                  children: [
                    // App Logo/Icon

                    // App Title with enhanced typography
                    Text(
                      'LocateLost',
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Subtitle
                    Text(
                      'Bringing families together',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Enhanced decorative line
                    Container(
                      width: 100.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.3),
                            AppColors.primary,
                            AppColors.primaryDark,
                            AppColors.primary.withOpacity(0.3),
                          ],
                          stops: [0.0, 0.3, 0.7, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(2.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // PageView content with enhanced container
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    child: PageView(
                      controller: _controller,
                      children: [
                        SplashScreen1(),
                        SplashScreen2(),
                        SplashScreen3(),
                      ],
                    ),
                  ),
                ),
              ),

              // Enhanced Bottom section
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced Page indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          dotColor: AppColors.textMuted.withOpacity(0.5),
                          dotHeight: 8.h,
                          dotWidth: 8.w,
                          activeDotColor: AppColors.primary,
                          spacing: 12.w,
                          radius: 6.r,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Enhanced Get Started button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () async {
                            // Mark onboarding as complete
                            await _markOnboardingComplete();
                            // Navigate to signup
                            Get.offAllNamed(AppRoutes.signup);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.rocket_launch_rounded,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Additional text for context
                    Text(
                      'Join our community in reuniting families',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w400,
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
