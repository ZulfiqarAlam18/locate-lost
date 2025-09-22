class AppRoutes {
  // Auth Routes
  static const String splash = '/splash';
  static const String splash1 = '/splash1';
  static const String splash2 = '/splash2';
  static const String splash3 = '/splash3';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';

  // Main Routes
  static const String mainNavigation = '/main-navigation';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String reportCase = '/report-case';
  static const String displayInfo = '/display-info';
  static const String myCases = '/my-cases';
  static const String caseDetails = '/case-details';
  static const String mapNearbyReports = '/map-nearby-reports';

  // Notification Routes
  static const String notifications = '/notifications';

  // Parent Routes
  static const String missingPersonDetails = '/missing-person-details';
  static const String reporterDetails = '/reporter-details';
  static const String uploadImages = '/upload-images';
  static const String parentCaseSummary = '/parent-case-summary';

  // Founder Routes
  static const String foundPersonDetails = '/found-person-details';
  static const String finderDetails = '/finder-details';
  static const String cameraCapture = '/camera-capture';
  static const String finderUploadImages = '/finder-upload-images';
  static const String finderCaseSummary = '/finder-case-summary';

  // Drawer Routes
  static const String aboutUs = '/about-us';
  static const String emergency = '/emergency';
  static const String contactUs = '/contact-us';
  static const String faqs = '/faqs';
  static const String stats = '/stats';
  static const String termsAndConditions = '/terms-conditions';

  // Settings routes
  static const String settings = '/settings';
  static const String accountSettings = '/settings/account';
  static const String settingsAccount =
      '/settings/account'; // Alias for accountSettings
  static const String notificationSettings = '/settings/notifications';
  static const String settingsNotifications =
      '/settings/notifications'; // Alias for notificationSettings
  static const String appearanceSettings = '/settings/appearance';
  static const String settingsAppearance =
      '/settings/appearance'; // Alias for appearanceSettings
  static const String privacySettings = '/settings/privacy';
  static const String languageSettings = '/settings/language';
  static const String supportSettings = '/settings/support';
  static const String aboutSettings = '/settings/about';
  static const String dangerZoneSettings = '/settings/danger-zone';

  // Demo Routes
  static const String dialogDemo = '/dialog-demo';
  static const String locationPermissionTest = '/location-permission-test';
  static const String backendTest = '/backend-test';
  static const String settingsPrivacy = '/settings/privacy';
  static const String settingsLanguage = '/settings/language';
  static const String settingsSupport = '/settings/support';
  static const String settingsAbout = '/settings/about';
  static const String settingsDangerZone = '/settings/danger-zone';

  // Legacy/Redirector Routes
  static const String caseSummary = '/case-summary';
}
