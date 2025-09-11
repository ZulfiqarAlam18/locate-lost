import 'package:get/get.dart';
import '../presentation/pages/splash_screens/splash_screen.dart';
import '../presentation/pages/splash_screens/splash_screen_1.dart';
import '../presentation/pages/splash_screens/splash_screen_2.dart';
import '../presentation/pages/splash_screens/splash_screen_3.dart';
import '../presentation/pages/auth_screens/login_screen.dart';
import '../presentation/pages/auth_screens/signup_screen.dart';
import '../presentation/pages/auth_screens/forgot_password_screen.dart';
import '../presentation/pages/auth_screens/otp_verification_screen.dart';
import '../presentation/pages/main_navigation_screen.dart';
import '../presentation/pages/profile_screen.dart';
import '../presentation/pages/display_info_screen.dart';
import '../presentation/pages/my_cases_screen.dart';
import '../presentation/pages/case_details_screen.dart';
import '../presentation/pages/map_nearby_reports_screen.dart';
import '../presentation/pages/notification_screen.dart';
import '../presentation/pages/parent_screens/missing_person_details.dart';
import '../presentation/pages/parent_screens/reporter_details.dart';
import '../presentation/pages/parent_screens/upload_images.dart';
import '../presentation/pages/parent_case_summary.dart';
import '../presentation/pages/founder_screens/found_person_details.dart';
import '../presentation/pages/founder_screens/finder_details.dart';
import '../presentation/pages/founder_screens/camera_capture.dart';
import '../presentation/pages/finder_case_summary.dart';
import '../presentation/pages/drawer_screens/about_us_screen.dart';
import '../presentation/pages/drawer_screens/emergency_screen.dart';
import '../presentation/pages/drawer_screens/contact_us_screen.dart';
import '../presentation/pages/drawer_screens/faqs_screen.dart';
import '../presentation/pages/drawer_screens/stats_screen.dart';
import '../presentation/pages/drawer_screens/terms_and_conditions_screen.dart';
import '../presentation/pages/case_summary.dart';
import '../presentation/pages/settings_screens/settings_screen.dart';
import '../presentation/pages/settings_screens/account_settings_screen.dart';
import '../presentation/pages/settings_screens/notification_settings_screen.dart';
import '../presentation/pages/settings_screens/appearance_settings_screen.dart';
import '../presentation/pages/settings_screens/privacy_settings_screen.dart';
import '../presentation/pages/settings_screens/language_settings_screen.dart';
import '../presentation/pages/settings_screens/support_settings_screen.dart';
import '../presentation/pages/settings_screens/about_settings_screen.dart';
import '../presentation/pages/settings_screens/danger_zone_settings_screen.dart';
import '../presentation/pages/location_permission_test_screen.dart';
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
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Main Routes
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.home,
      page:
          () =>
              const MainNavigationScreen(), // Route home to MainNavigationScreen
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: AppRoutes.reportCase,
    //   page: () => const ReportCaseScreen(),
    //   transition: Transition.cupertino,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: AppRoutes.displayInfo,
      page: () => const DisplayInfoScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.myCases,
      page: () => const MyCasesScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.caseDetails,
      page: () => const CaseDetailsScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.mapNearbyReports,
      page: () => const MapNearbyReportsScreen(),
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

    // Settings Routes
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
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

    // Demo Routes
    // GetPage(
    //   name: AppRoutes.dialogDemo,
    //   page: () => const DialogDemoScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: AppRoutes.locationPermissionTest,
      page: () => const LocationPermissionTestScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
