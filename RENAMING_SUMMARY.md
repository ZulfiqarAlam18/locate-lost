# LocateLost Project - Renaming Summary

This document summarizes all the changes made to improve code maintainability and readability by renaming files and classes to follow better naming conventions.

## Directory Structure Changes

1. **Renamed Directories**:
   - `lib/Widgets` → `lib/widgets`
   - `lib/Models` → `lib/models`
   - `lib/Services` → `lib/services`
   - `lib/views/SplashScreens` → `lib/views/splash_screens`

2. **New Directories**:
   - Created `lib/utils` for utility classes and constants

## File Renaming

### Utility Files
- `lib/colors.dart` → `lib/utils/app_colors.dart`
- `lib/constants.dart` → `lib/utils/app_constants.dart`

### Auth Screen Files
- `lib/views/auth_screens/forget_password.dart` → `lib/views/auth_screens/forgot_password_screen.dart`
- `lib/views/auth_screens/login.dart` → `lib/views/auth_screens/login_screen.dart`
- `lib/views/auth_screens/signup.dart` → `lib/views/auth_screens/signup_screen.dart`

### Drawer Screen Files
- `lib/views/drawer_screens/about_us.dart` → `lib/views/drawer_screens/about_us_screen.dart`
- `lib/views/drawer_screens/contact_us.dart` → `lib/views/drawer_screens/contact_us_screen.dart`
- `lib/views/drawer_screens/emergency.dart` → `lib/views/drawer_screens/emergency_screen.dart`
- `lib/views/drawer_screens/faqs.dart` → `lib/views/drawer_screens/faqs_screen.dart`
- `lib/views/drawer_screens/terms_and_conditions.dart` → `lib/views/drawer_screens/terms_and_conditions_screen.dart`

### Founder Screen Files
- `lib/views/founder_screens/f_child_info.dart` → `lib/views/founder_screens/found_person_details.dart`
- `lib/views/founder_screens/founder_info.dart` → `lib/views/founder_screens/finder_details.dart`
- `lib/views/founder_screens/image.dart` → `lib/views/founder_screens/camera_capture.dart`

### Parent Screen Files
- `lib/views/parent_screens/p_child_info.dart` → `lib/views/parent_screens/missing_person_details.dart`
- `lib/views/parent_screens/parent_info.dart` → `lib/views/parent_screens/reporter_details.dart`

### Splash Screen Files
- `lib/views/splash_screens/splash.dart` → `lib/views/splash_screens/splash_screen.dart`
- `lib/views/splash_screens/splash1.dart` → `lib/views/splash_screens/splash_screen_1.dart`
- `lib/views/splash_screens/splash2.dart` → `lib/views/splash_screens/splash_screen_2.dart`
- `lib/views/splash_screens/splash3.dart` → `lib/views/splash_screens/splash_screen_3.dart`

### Widget Files
- `lib/widgets/custom_appBar.dart` → `lib/widgets/custom_app_bar.dart`
- `lib/widgets/custom_textField.dart` → `lib/widgets/custom_text_field.dart`
- `lib/widgets/custom_alertBox.dart` → `lib/widgets/custom_alert_box.dart`

### Other View Files
- `lib/views/display_info.dart` → `lib/views/display_info_screen.dart`
- `lib/views/profile.dart` → `lib/views/profile_screen.dart`
- `lib/views/record.dart` → `lib/views/case_summary.dart`
- `lib/views/report_case.dart` → `lib/views/report_case_screen.dart`

## Class Renaming

### Auth Screen Classes
- `ForgetPassword` → `ForgotPasswordScreen`
- `Login` → `LoginScreen`
- `Signup` → `SignupScreen`

### Drawer Screen Classes
- `AboutUs` → `AboutUsScreen`
- `ContactUs` → `ContactUsScreen`
- `EmergencyContactScreen` → `EmergencyScreen`
- `FAQsScreen` → No change (already followed convention)
- `TermsAndConditions` → `TermsAndConditionsScreen`

### Founder Screen Classes
- `ChildInfoScreen` → `FoundPersonDetailsScreen`
- `FounderDetailsScreen` → `FinderDetailsScreen`
- `FinderCameraScreen` → `CameraCaptureScreen`

### Parent Screen Classes
- `ChildDetailsScreen` → `MissingPersonDetailsScreen`
- `ParentDetailsScreen` → `ReporterDetailsScreen`

### Splash Screen Classes
- `Splash` → `SplashScreen`
- `Splash1` → `SplashScreen1`
- `Splash2` → `SplashScreen2`
- `Splash3` → `SplashScreen3`

### Widget Classes
- `CustomAppBar` → No change (just file name changed)
- `CustomTextFormField` → No change (just file name changed)
- `CustomAlertBox` → No change (just file name changed)

### Other View Classes
- `DisplayInfoScreen` → No change (already followed convention)
- `ProfileScreen` → No change (already followed convention)
- `RecordScreen` → `CaseSummaryScreen`
- `ReportCase` → `ReportCaseScreen`

## Import Updates

All import statements have been updated to reflect the new file paths. For example:

```dart
// Old import
import 'package:locat_lost/colors.dart';

// New import
import 'package:locat_lost/utils/app_colors.dart';
```

## Benefits of These Changes

1. **Consistency**: All file and folder names now follow consistent naming conventions
2. **Clarity**: Class and file names now better reflect their purpose and content
3. **Maintainability**: Easier to understand the codebase structure and relationships
4. **Standards Compliance**: Follows Dart and Flutter naming conventions

## Naming Conventions Used

1. **Directories**: snake_case (e.g., `splash_screens`)
2. **Files**: snake_case (e.g., `custom_app_bar.dart`)
3. **Classes**: PascalCase (e.g., `MissingPersonDetailsScreen`)
4. **Variables and Methods**: camelCase (unchanged)

## Next Steps

1. Continue to follow these naming conventions for all new files and classes
2. Consider further refactoring to improve code organization
3. Add proper documentation to classes and methods
