import 'package:get/get.dart';
import '../views/splash_screens/splash_screen.dart';
import '../views/splash_screens/splash_screen_1.dart';
import '../views/splash_screens/splash_screen_2.dart';
import '../views/splash_screens/splash_screen_3.dart';
import '../views/auth_screens/login_screen.dart';
import '../views/auth_screens/signup_screen.dart';
import '../views/auth_screens/forgot_password_screen.dart';
import '../views/home_screen.dart';
import '../views/profile_screen.dart';
import '../views/report_case_screen.dart';
import '../views/display_info_screen.dart';
import '../views/parent_screens/missing_person_details.dart';
import '../views/parent_screens/reporter_details.dart';
import '../views/parent_screens/upload_images.dart';
import '../views/parent_case_summary.dart';
import '../views/founder_screens/found_person_details.dart';
import '../views/founder_screens/finder_details.dart';
import '../views/founder_screens/camera_capture.dart';
import '../views/finder_case_summary.dart';
import '../views/drawer_screens/about_us_screen.dart';
import '../views/drawer_screens/emergency_screen.dart';
import '../views/drawer_screens/contact_us_screen.dart';
import '../views/drawer_screens/faqs_screen.dart';
import '../views/drawer_screens/stats_screen.dart';
import '../views/drawer_screens/terms_and_conditions_screen.dart';
import '../views/case_summary.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Splash Routes
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.splash1,
      page: () => const SplashScreen1(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.splash2,
      page: () => const SplashScreen2(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.splash3,
      page: () => const SplashScreen3(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Auth Routes
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Main Routes
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.reportCase,
      page: () => const ReportCaseScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.displayInfo,
      page: () => const DisplayInfoScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Parent Routes
    GetPage(
      name: AppRoutes.missingPersonDetails,
      page: () => const MissingPersonDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.reporterDetails,
      page: () => const ReporterDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.uploadImages,
      page: () => const UploadImagesScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.parentCaseSummary,
      page: () => const ParentCaseSummaryScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Founder Routes
    GetPage(
      name: AppRoutes.foundPersonDetails,
      page: () => const FoundPersonDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.finderDetails,
      page: () => const FinderDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.cameraCapture,
      page: () => const CameraCaptureScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.finderCaseSummary,
      page: () => const FinderCaseSummaryScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Drawer Routes
    GetPage(
      name: AppRoutes.aboutUs,
      page: () => const AboutUsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.emergency,
      page: () => const EmergencyScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => const ContactUsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.faqs,
      page: () => const FAQsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.stats,
      page: () => StatsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.termsAndConditions,
      page: () => const TermsAndConditionsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Legacy/Redirector Routes
    GetPage(
      name: AppRoutes.caseSummary,
      page: () => const CaseSummaryScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
