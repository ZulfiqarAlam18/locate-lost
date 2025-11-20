import 'package:get/get.dart';
import 'package:locate_lost/controllers/auth_controller.dart';
import 'package:locate_lost/controllers/parent_report_controller.dart';
import 'package:locate_lost/controllers/finder_report_controller.dart';
import 'package:locate_lost/views/pages/auth_screens/forgot_password_screen.dart';
import 'package:locate_lost/views/pages/auth_screens/login_screen.dart';
import 'package:locate_lost/views/pages/auth_screens/otp_verification_screen.dart';
import 'package:locate_lost/views/pages/auth_screens/signup_screen.dart';
import 'package:locate_lost/views/pages/bottom_nav_screens/case_details_screen.dart' show CaseDetailsScreen;
import 'package:locate_lost/views/pages/case_screens/case_summary.dart';
import 'package:locate_lost/views/pages/case_screens/finder_case_summary.dart' show FinderCaseSummaryScreen;
import 'package:locate_lost/views/pages/case_screens/parent_case_summary.dart';
import 'package:locate_lost/views/pages/drawer_screens/contact_us_screen.dart' show ContactUsScreen;
import 'package:locate_lost/views/pages/drawer_screens/faqs_screen.dart';
import 'package:locate_lost/views/pages/drawer_screens/profile_screen_old.dart';
import 'package:locate_lost/views/pages/drawer_screens/terms_and_conditions_screen.dart' show TermsAndConditionsScreen;
import 'package:locate_lost/views/pages/finder_screens/camera_capture.dart' show CameraCaptureScreen;
import 'package:locate_lost/views/pages/finder_screens/found_person_details.dart' show FoundPersonDetailsScreen;
import 'package:locate_lost/views/pages/finder_screens/finder_upload_images.dart' show FinderUploadImagesScreen;
import 'package:locate_lost/views/pages/main_navigation_screen.dart';
import 'package:locate_lost/views/pages/parent_screens/missing_person_details.dart' show MissingPersonDetailsScreen;
import 'package:locate_lost/views/pages/parent_screens/upload_images.dart' show UploadImagesScreen;
import 'package:locate_lost/views/pages/settings_screens/about_settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/account_settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/appearance_settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/danger_zone_settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/language_settings_screen.dart' show LanguageSettingsScreen;
import 'package:locate_lost/views/pages/settings_screens/notification_settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/privacy_settings_screen.dart' show PrivacySettingsScreen;
import 'package:locate_lost/views/pages/settings_screens/settings_screen.dart';
import 'package:locate_lost/views/pages/settings_screens/support_settings_screen.dart' show SupportSettingsScreen;
import 'package:locate_lost/views/pages/splash_screens/splash_screen.dart';
import 'package:locate_lost/views/pages/splash_screens/splash_screen_1.dart';
import 'package:locate_lost/views/pages/splash_screens/splash_screen_2.dart';
import 'package:locate_lost/views/pages/splash_screens/splash_screen_3.dart';


import '../views/pages/bottom_nav_screens/map_nearby_reports_screen.dart';
import '../views/pages/bottom_nav_screens/my_cases_screen.dart' show MyCasesScreen;
import '../views/pages/drawer_screens/about_us_screen_new.dart';
import '../views/pages/drawer_screens/emergency_screen.dart';
import '../views/pages/drawer_screens/stats_screen.dart' show StatsScreen;
import '../views/pages/notifications/notification_screen.dart';
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
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Main Routes
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () {
        // Handle navigation arguments to set initial tab index
        final arguments = Get.arguments;
        int initialIndex = 0; // Default to home tab
        
        if (arguments != null) {
          // Handle direct int argument (e.g., arguments: 2)
          if (arguments is int && arguments >= 0 && arguments <= 3) {
            initialIndex = arguments;
          }
          // Handle map argument (e.g., arguments: {'initialIndex': 2})
          else if (arguments is Map) {
            if (arguments.containsKey('initialIndex')) {
              final index = arguments['initialIndex'];
              if (index is int && index >= 0 && index <= 3) {
                initialIndex = index;
              }
            } else if (arguments.containsKey('index')) {
              final index = arguments['index'];
              if (index is int && index >= 0 && index <= 3) {
                initialIndex = index;
              }
            }
          }
        }
        
        return MainNavigationScreen(initialIndex: initialIndex);
      },
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.home,
      page:
          () =>
              MainNavigationScreen(), // Route home to MainNavigationScreen
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: AppRoutes.reportCase,
    //   page: () => const ReportCaseScreen(),
    //   transition: Transition.cupertino,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    // GetPage(
    //   name: AppRoutes.displayInfo,
    //   page: () => const DisplayInfoScreen(),
    //   transition: Transition.cupertino,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: AppRoutes.myCases,
      page: () =>  MyCasesScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.caseDetails,
      page: () =>  CaseDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.mapNearbyReports,
      page: () =>  MapNearbyReportsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Notification Routes
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Parent Routes
    GetPage(
      name: AppRoutes.missingPersonDetails,
      page: () => const MissingPersonDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ParentReportController>(() => ParentReportController(), fenix: true);
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
   
    GetPage(
      name: AppRoutes.uploadImages,
      page: () => const UploadImagesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ParentReportController>(() => ParentReportController(), fenix: true);
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.parentCaseSummary,
      page: () => const ParentCaseSummaryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ParentReportController>(() => ParentReportController(), fenix: true);
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Finder Routes
    GetPage(
      name: AppRoutes.cameraCapture,
      page: () => const CameraCaptureScreen(),
      binding: BindingsBuilder(() {
        // Use Get.put with permanent:true to keep controller alive across navigation
        if (!Get.isRegistered<FinderReportController>()) {
          Get.put<FinderReportController>(FinderReportController(), permanent: true);
        }
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.finderUploadImages,
      page: () => const FinderUploadImagesScreen(),
      binding: BindingsBuilder(() {
        // Use Get.put with permanent:true to keep controller alive across navigation
        if (!Get.isRegistered<FinderReportController>()) {
          Get.put<FinderReportController>(FinderReportController(), permanent: true);
        }
      }),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.foundPersonDetails,
      page: () => const FoundPersonDetailsScreen(),
      // Reuse existing FinderReportController from camera/upload screen
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.finderCaseSummary,
      page: () => const FinderCaseSummaryScreen(),
      // Reuse existing FinderReportController from camera/upload screen
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
   

    // Settings Routes
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.accountSettings,
      page: () => const AccountSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.settingsAccount,
      page: () => const AccountSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.notificationSettings,
      page: () => const NotificationSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.settingsNotifications,
      page: () => const NotificationSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.appearanceSettings,
      page: () => const AppearanceSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.settingsAppearance,
      page: () => const AppearanceSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.privacySettings,
      page: () => const PrivacySettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.languageSettings,
      page: () => const LanguageSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.supportSettings,
      page: () => const SupportSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.aboutSettings,
      page: () => const AboutSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.dangerZoneSettings,
      page: () => const DangerZoneSettingsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

   
    // GetPage(
    //   name: AppRoutes.locationPermissionTest,
    //   page: () => const LocationPermissionTestScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    // GetPage(
    //   name: AppRoutes.backendTest,
    //   page: () => const BackendTestScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
  ];
}
