# LocateLost Project - Naming Convention Guide

This guide outlines the naming conventions that should be followed for the LocateLost project to ensure consistency, readability, and maintainability.

## Directory Structure

```
lib/
├── models/              # Data models
├── services/            # API and Firebase services
├── utils/               # Utility classes and constants
├── views/               # UI screens
│   ├── auth_screens/    # Authentication screens
│   ├── drawer_screens/  # Drawer menu screens
│   ├── founder_screens/ # Found person reporting screens
│   ├── parent_screens/  # Missing person reporting screens
│   └── splash_screens/  # Onboarding screens
└── widgets/             # Reusable UI components
```

## Naming Conventions

### Directories
- Use **snake_case** for all directory names (e.g., `auth_screens`, `drawer_screens`)
- All directory names should be lowercase
- Use plural form for directories containing multiple similar items

### Files
- Use **snake_case** for all file names (e.g., `login_screen.dart`, `custom_app_bar.dart`)
- All file names should be lowercase
- Screen files should end with `_screen.dart` (e.g., `home_screen.dart`)
- Widget files should be descriptive of their purpose (e.g., `custom_text_field.dart`)
- Utility files should be prefixed with their category (e.g., `app_colors.dart`, `app_constants.dart`)

### Classes
- Use **PascalCase** for all class names (e.g., `LoginScreen`, `CustomAppBar`)
- Screen classes should end with `Screen` (e.g., `HomeScreen`, `ProfileScreen`)
- Widget classes should be descriptive of their purpose (e.g., `CustomTextField`)
- Utility classes should be prefixed with their category (e.g., `AppColors`, `AppConstants`)

### Variables and Methods
- Use **camelCase** for all variable and method names (e.g., `userName`, `fetchUserData()`)
- Boolean variables should start with `is`, `has`, or `should` (e.g., `isLoading`, `hasError`)
- Private variables and methods should start with an underscore (e.g., `_userName`, `_fetchData()`)

## File Naming Examples

| Component Type | File Name | Class Name |
|----------------|-----------|------------|
| Screen | `home_screen.dart` | `HomeScreen` |
| Widget | `custom_text_field.dart` | `CustomTextField` |
| Model | `user_model.dart` | `UserModel` |
| Service | `auth_service.dart` | `AuthService` |
| Utility | `app_colors.dart` | `AppColors` |

## Import Organization

Organize imports in the following order:

1. Dart SDK imports
2. Flutter framework imports
3. Third-party package imports
4. Project imports (organized by directory)

Example:
```dart
// Dart SDK imports
import 'dart:async';
import 'dart:io';

// Flutter framework imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Third-party package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports - utils
import 'package:locat_lost/utils/app_colors.dart';
import 'package:locat_lost/utils/app_constants.dart';

// Project imports - widgets
import 'package:locat_lost/widgets/custom_app_bar.dart';
import 'package:locat_lost/widgets/custom_text_field.dart';

// Project imports - views
import 'package:locat_lost/views/home_screen.dart';
```

## Specific Naming Patterns for LocateLost

### Screen Types
- Authentication screens: `login_screen.dart`, `signup_screen.dart`, `forgot_password_screen.dart`
- Missing person screens: `missing_person_details_screen.dart`, `reporter_details_screen.dart`
- Found person screens: `found_person_details_screen.dart`, `finder_details_screen.dart`
- Camera screens: `camera_capture_screen.dart`
- Summary screens: `case_summary_screen.dart`

### Widget Types
- Custom UI components: `custom_app_bar.dart`, `custom_text_field.dart`, `custom_elevated_button.dart`
- Dialog components: `custom_alert_box.dart`

## Benefits of Following These Conventions

1. **Consistency**: Makes the codebase more predictable and easier to navigate
2. **Readability**: Clearly communicates the purpose and content of files and classes
3. **Maintainability**: Simplifies refactoring and code organization
4. **Collaboration**: Enables team members to work together more effectively
5. **Standards Compliance**: Aligns with Flutter and Dart community best practices

## Implementation Strategy

When implementing these naming conventions:

1. Create new files with proper names before deleting old ones
2. Update all imports after renaming
3. Test thoroughly after each set of changes
4. Remove old files only after confirming everything works correctly
