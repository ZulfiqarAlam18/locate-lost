# LocateLost Project - File and Class Renaming

This document outlines the changes made to improve code maintainability and readability by renaming files and classes to follow better naming conventions.

## Folder Structure Changes

1. Renamed `Widgets` folder to lowercase `widgets` (following Dart conventions)
2. Renamed `SplashScreens` folder to `splash_screens` (using snake_case for folders)

## File Renaming

### Widget Files
- `lib/Widgets/custom_appBar.dart` → `lib/widgets/custom_app_bar.dart`
- `lib/Widgets/custom_textField.dart` → `lib/widgets/custom_text_field.dart`
- `lib/Widgets/custom_alertBox.dart` → `lib/widgets/custom_alert_box.dart`

### View Files
- `lib/views/founder_screens/f_child_info.dart` → `lib/views/founder_screens/found_person_details.dart`
- `lib/views/founder_screens/founder_info.dart` → `lib/views/founder_screens/finder_details.dart`
- `lib/views/founder_screens/image.dart` → `lib/views/founder_screens/camera_capture.dart`
- `lib/views/parent_screens/p_child_info.dart` → `lib/views/parent_screens/missing_person_details.dart`
- `lib/views/parent_screens/parent_info.dart` → `lib/views/parent_screens/reporter_details.dart`
- `lib/views/record.dart` → `lib/views/case_summary.dart`

## Class Renaming

- `ChildInfoScreen` → `FoundPersonDetailsScreen`
- `FounderDetailsScreen` → `FinderDetailsScreen`
- `FinderCameraScreen` → `CameraCaptureScreen`
- `ChildDetailsScreen` → `MissingPersonDetailsScreen`
- `ParentDetailsScreen` → `ReporterDetailsScreen`
- `RecordScreen` → `CaseSummaryScreen`

## Import Path Updates

All import paths have been updated to reflect the new file locations and names. For example:

```dart
// Old import
import 'package:locat_lost/Widgets/custom_appBar.dart';

// New import
import 'package:locat_lost/widgets/custom_app_bar.dart';
```

## Benefits of These Changes

1. **Consistency**: All file and folder names now follow consistent naming conventions
2. **Clarity**: Class and file names now better reflect their purpose and content
3. **Maintainability**: Easier to understand the codebase structure and relationships
4. **Standards Compliance**: Follows Dart and Flutter naming conventions

## Naming Conventions Used

1. **Folders**: snake_case (e.g., `splash_screens`)
2. **Files**: snake_case (e.g., `custom_app_bar.dart`)
3. **Classes**: PascalCase (e.g., `MissingPersonDetailsScreen`)
4. **Variables and Methods**: camelCase (unchanged)

## Next Steps

1. Continue to follow these naming conventions for all new files and classes
2. Consider further refactoring to improve code organization
3. Add proper documentation to classes and methods
