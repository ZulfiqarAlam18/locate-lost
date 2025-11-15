# LocateLost Flutter App - AI Coding Agent Instructions

## Project Overview
LocateLost is a Flutter mobile app for reporting and finding missing children using facial recognition. The app supports parent reporters, finders, and authorities with real-time matching and location-based features.

## Architecture & State Management

### GetX Pattern (Primary State Management)
- **Controllers**: Located in `lib/controllers/`. Use singleton pattern: `static get instance => Get.find<ControllerName>()`
- **Lazy Binding**: Controllers are lazily initialized via `BindingsBuilder` in `lib/navigation/app_pages.dart`, NOT in `main.dart`
  - **CRITICAL**: Any route that uses `Get.find<AuthController>()` MUST have a binding configured, or you'll get "AuthController not found" error
  - Example binding:
    ```dart
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    )
    ```
- **Observable State**: Use `.obs` for reactive variables, wrap UI with `Obx()` for automatic updates
- **Key Controllers**:
  - `AuthController` - Manages authentication, user session, tokens via SharedPreferences
  - `MainNavigationController` - Handles bottom navigation state across 4 tabs
  - `LocationService` - Geolocator wrapper with permission handling

### Directory Structure
```
lib/
├── controllers/        # GetX controllers (business logic)
├── data/
│   ├── models/        # Data models (auth/, reports with toJson/fromJson)
│   └── network/       # API helpers (singleton pattern)
├── navigation/        # AppRoutes + AppPages (GetX routing)
├── network/           # Legacy network files (being migrated to data/)
├── utils/
│   ├── constants/     # AppColors, endpoints, app_constants
│   ├── services/      # LocationService, other services
│   └── utils/         # DialogUtils, NavigationHelper
└── views/
    ├── dialogs/       # Reusable dialogs (AnimatedLoadingDialog, CaseSubmissionDialog)
    ├── pages/         # Screen implementations organized by feature
    └── widgets/       # Reusable widgets (CustomTextFormField, SkeletonShimmer, MainBottomNavigation)
```

## Backend Integration

### API Configuration
- **Base URL**: Defined in `lib/utils/constants/endpoints.dart` as `Base_URL`
- **Current**: Development tunnel URL (changes frequently)
- **Endpoints**: `Login_Endpoint`, `Register_Endpoint`, `Parent_Report_Create`

### Network Helpers
- Located in `lib/data/network/` (preferred) and `lib/network/` (legacy)
- Pattern: Singleton with `static final _instance` and factory constructor
- Use `http` package with 30-second timeout
- Return model objects (e.g., `AuthResponse`) not raw JSON
- Include extensive debug prints for request/response tracking

### Authentication Flow
1. User logs in/signs up → `AuthController` calls `AuthHelper.login()`
2. Response parsed into `AuthResponse` → `AuthData` contains `accessToken`, `refreshToken`, `User`
3. Tokens + user data saved to SharedPreferences (10 keys total)
4. `isLoggedIn.value = true` triggers UI updates via `Obx()`
5. On app restart: `SplashScreen` checks `isFirstTime` → checks `isLoggedIn` → routes to Home or Login

## Navigation & Routing

### Route Definition
- **Routes**: `lib/navigation/app_routes.dart` - String constants like `/login`, `/main-navigation`
- **Pages**: `lib/navigation/app_pages.dart` - GetPage list with transitions, bindings
- **Transitions**: Most use `Transition.fadeIn` or `Transition.rightToLeft`

### Navigation Patterns
- `Get.toNamed(AppRoutes.routeName)` - Navigate to route
- `Get.offAllNamed(AppRoutes.home)` - Clear stack and navigate
- `Get.back()` - Pop current route
- External tab switching: Use `NavigationHelper.switchTab(index)` which finds `MainNavigationController` and updates `selectedIndex`

### Bottom Navigation
- Implemented in `MainBottomNavigation` widget with 4 tabs:
  0. Home, 1. My Cases, 2. Case Details, 3. Map Nearby
- State managed by `MainNavigationController.selectedIndex.obs`
- Initialized with `Get.put()` in each bottom nav screen (not lazy)

## UI Patterns & Widgets

### Custom Components
- **CustomTextFormField**: Standard text input with validation, prefix/suffix icons
- **CustomElevatedButton**: Primary button with loading state support
- **CustomAppBar**: App bar with back button, title, and optional actions
- **SkeletonShimmer**: Loading states with shimmer animation (SkeletonCardLoader, SkeletonListLoader)
- **AnimatedLoadingDialog**: Modal loading indicator during async operations

### Loading States
- Show `AnimatedLoadingDialog` during API calls using `DialogUtils.showLoadingDialog()`
- Button loading: Wrap in `Obx()` and conditionally show "Please Wait..." text when `isLoading.value == true`
- List loading: Use `SkeletonListLoader()` or `SkeletonCardLoader()` while fetching data

### Dialog Utilities
- `DialogUtils.showCaseSubmissionSuccess()` - Success dialog for report submissions
- `DialogUtils.showError()` - Generic error dialog
- All dialogs use GetX dialog system, not Flutter's default `showDialog`

## Styling & Design

### Colors
- Primary: `AppColors.primary` (teal #31C3BD)
- Defined in `lib/utils/constants/app_colors.dart`
- Semantic colors: `success`, `error`, `warning`, `statusActive`, `statusResolved`

### Screen Responsiveness
- Uses `flutter_screenutil` package - all dimensions should use `.w`, `.h`, `.r`, `.sp`
- Design size: `Size(430, 932)` configured in `main.dart`
- Always use responsive units: `20.w` for width, `16.h` for height, `12.r` for border radius, `14.sp` for font size

## Permissions & Location

### Location Service
- `LocationService` (GetX controller) in `lib/utils/services/`
- Methods: `checkLocationPermission()`, `requestLocationPermission()`, `getCurrentLocation()`
- Returns `LocationSetupResult` with success status and error messages
- Permission states: denied, deniedForever, whileInUse, always
- Handle deniedForever by showing app settings dialog

## Development Workflow

### Running the App
```bash
flutter pub get              # Install dependencies
flutter run                  # Run on connected device/emulator
flutter run -d chrome --web-renderer html  # Web (if supported)
```

### Key Dependencies
- **State Management**: get ^4.7.2
- **Storage**: shared_preferences ^2.5.3, get_storage ^2.1.1
- **Networking**: http ^1.5.0, dio ^5.9.0
- **UI**: flutter_screenutil ^5.9.3, google_fonts ^6.3.1
- **Location**: geolocator ^13.0.1, permission_handler ^12.0.1
- **Image**: image_picker ^1.2.0, camera ^0.11.2

### Testing
- Test files go in `test/` directory
- Current test: `widget_test.dart` (basic counter test - update for actual app)
- No automated testing suite currently implemented

## Code Conventions

### Models
- All models have `toJson()` and `fromJson()` methods
- Use required named parameters in constructors
- Example: `LoginRequest`, `SignupRequest`, `AuthResponse` in `lib/data/models/auth/`

### Controllers
- Extend `GetxController`
- Use `@override void onInit()` for initialization logic
- Observable vars: `final RxBool isLoading = false.obs;`
- Methods should be public unless prefixed with `_` for private helpers

### Error Handling
- API errors: Return model with `success: false` and error message
- Show user-friendly messages via GetX snackbar: `Get.snackbar('Error', message)`
- Debug prints: Use emoji prefixes (✅ success, ❌ error, 📤 request, 📥 response)

## Important Notes

### DO
- Use GetX for state management and navigation
- Lazy load controllers via `BindingsBuilder` in route definitions - **add binding to EVERY route that uses the controller**
- Save sensitive data (tokens) to SharedPreferences, not GetStorage
- Use responsive sizing with flutter_screenutil
- Follow singleton pattern for services/helpers

### DON'T
- Don't initialize controllers in `main.dart` with `initialBinding`
- Don't create binding files (`*_binding.dart`) - use inline `BindingsBuilder`
- Don't use `Get.find()` without adding binding to the route - will cause "Controller not found" error
- Don't use `Get.put()` for auth/service controllers in routes - use `Get.lazyPut()` in bindings
- Don't hardcode dimensions - always use `.w`, `.h`, `.r`, `.sp`
- Don't use Flutter's default Navigator - use GetX routing

## Documentation References
- **API Docs**: See `API_DOCUMENTATION.md` for complete backend API reference
- **Auth Integration**: See `BACKEND_AUTH_INTEGRATION_SUMMARY.md` for auth implementation details
- **Navigation Flow**: See `COMPLETE_AUTH_NAVIGATION_IMPLEMENTATION.md` for splash/auth routing logic
