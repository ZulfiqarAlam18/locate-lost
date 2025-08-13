# 📁 Project Structure Documentation

## Overview
This document describes the reorganized directory structure for the LocateLost Flutter application, following clean architecture principles and best practices.

## 🏗️ Directory Structure

```
lib/
├── main.dart                 # App entry point
├── config/                   # App configuration
├── core/                     # Core functionalities
│   ├── constants/           # App-wide constants
│   │   ├── app_colors.dart
│   │   ├── app_constants.dart
│   │   └── constants.dart   # Barrel export
│   ├── utils/               # Utility functions
│   │   ├── dialog_utils.dart
│   │   └── utils.dart       # Barrel export
│   └── theme/               # App theme (for future use)
├── data/                     # Data layer
│   ├── models/              # Data models (for future use)
│   ├── repositories/        # Data repositories (for future use)
│   └── services/            # External services
│       ├── location_permission_service.dart
│       └── services.dart    # Barrel export
├── presentation/             # UI layer
│   ├── pages/               # All screens/pages
│   │   ├── auth_screens/    # Authentication screens
│   │   ├── drawer_screens/  # Drawer navigation screens
│   │   ├── founder_screens/ # Found person reporting screens
│   │   ├── parent_screens/  # Missing person reporting screens
│   │   ├── settings_screens/ # Settings and preferences
│   │   ├── splash_screens/  # Onboarding screens
│   │   └── *.dart          # Main screens
│   ├── widgets/             # Reusable UI components
│   │   ├── custom_*.dart    # Custom widgets
│   │   ├── *.dart          # Other widgets
│   │   └── widgets.dart     # Barrel export
│   └── dialogs/             # Dialog widgets
│       ├── animated_loading_dialog.dart
│       ├── case_submission_dialog.dart
│       ├── custom_alert_box.dart
│       ├── multi_step_progress_dialog.dart
│       └── dialogs.dart     # Barrel export
├── navigation/               # Routing
│   ├── app_routes.dart      # Route constants
│   ├── app_pages.dart       # Route configurations
│   └── navigation.dart      # Barrel export
└── examples/                 # Example code
```

## 🎯 Organization Principles

### 1. **Separation of Concerns**
- **Core**: Fundamental app utilities and constants
- **Data**: Data management and external services
- **Presentation**: All UI-related code
- **Navigation**: Route management

### 2. **Feature-Based Organization**
- Pages are grouped by feature/function
- Related screens are kept together
- Common functionality is centralized

### 3. **Barrel Exports**
Each major directory includes a barrel export file for cleaner imports:
```dart
// Instead of multiple imports:
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

// Use single barrel import:
import '../core/constants/constants.dart';
```

## 📝 Import Guidelines

### Before (Old Structure)
```dart
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../views/auth_screens/login_screen.dart';
```

### After (New Structure)
```dart
import '../core/constants/app_colors.dart';
import '../presentation/widgets/custom_button.dart';
import '../presentation/pages/auth_screens/login_screen.dart';
```

### Using Barrel Exports
```dart
import '../core/constants/constants.dart';
import '../presentation/widgets/widgets.dart';
import '../presentation/dialogs/dialogs.dart';
```

## 🚀 Benefits

### 1. **Scalability**
- Easy to add new features
- Clear separation of responsibilities
- Follows Flutter/Dart conventions

### 2. **Maintainability**
- Related files are grouped together
- Easier to locate specific functionality
- Clear import paths

### 3. **Team Collaboration**
- Consistent structure across the project
- Clear guidelines for new additions
- Reduced merge conflicts

### 4. **Clean Architecture**
- Data layer separated from presentation
- Core utilities centralized
- Navigation logic isolated

## 📋 Migration Checklist

✅ **Completed Tasks:**
- [x] Created new directory structure
- [x] Moved all files to appropriate directories
- [x] Updated all import statements
- [x] Created barrel export files
- [x] Tested main.dart compilation
- [x] Verified file organization

## 🔄 Future Additions

### Data Layer Extensions
- **Models**: Add data models in `data/models/`
- **Repositories**: Add data repositories in `data/repositories/`
- **APIs**: Add API services in `data/services/`

### Core Extensions
- **Theme**: Add theme management in `core/theme/`
- **Config**: Add app configuration in `config/`

### Presentation Extensions
- **Controllers**: Consider adding GetX controllers if needed
- **Bindings**: Add GetX bindings for dependency injection

## 🛠️ Development Workflow

1. **Adding New Screens**: Place in appropriate `presentation/pages/` subdirectory
2. **Adding New Widgets**: Place in `presentation/widgets/`
3. **Adding New Dialogs**: Place in `presentation/dialogs/`
4. **Adding New Services**: Place in `data/services/`
5. **Adding New Constants**: Place in `core/constants/`
6. **Adding New Utilities**: Place in `core/utils/`

Remember to update the corresponding barrel export files when adding new components!

## 📞 Support

If you encounter any issues with the new structure or need to add new components, refer to this documentation or the existing examples in the codebase.
