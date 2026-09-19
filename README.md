# LocateLost

LocateLost is a cross-platform Flutter application for helping families and communities report, discover, and follow up on missing-person cases. Families can create missing-person reports with identifying details and photos, while someone who has found a person can submit a corresponding found-person report. Authenticated users can review their cases, open case details, and explore reports near their location.

## Core objective

The project shortens the path between a missing-person report and a useful community lead by putting essential case information in one place:

- Missing-person reports with name, gender, last-seen location, date/time, contact information, emergency contact, notes, and up to five images.
- Found-person reports with details and image capture or upload.
- Account creation, login, OTP verification, password recovery, and persisted sessions.
- A personal case list with report summaries and detailed case views.
- Nearby-report discovery using device location permissions.
- Notifications, profile/settings screens, support content, and privacy controls.

## How it works

1. Create an account or sign in.
2. Choose whether to report a missing person or a found person.
3. Add identifying information and clear images.
4. Submit the report to the LocateLost API.
5. Track submitted cases from **My Cases**, open details, and review nearby reports when location access is enabled.

## Technology

- Flutter and Dart
- GetX for routing and reactive state management
- REST API integration using `http` and `dio`
- `image_picker` and `camera` for case photos
- `geolocator` and `permission_handler` for location and runtime permissions
- `shared_preferences` for persisted authentication/session data
- Android, iOS, Web, Windows, macOS, and Linux project targets

## Project structure

```text
lib/
├── controllers/       # Authentication and report controllers
├── data/
│   ├── models/        # Request and response models
│   └── network/       # REST API helpers
├── navigation/        # Routes and page definitions
├── utils/              # Constants, services, and helpers
└── views/              # Screens, dialogs, and reusable widgets
assets/                 # Images and logos
test/                   # Flutter tests
```

## Requirements

- Flutter SDK compatible with Dart `^3.9.2`
- Android Studio/Xcode as needed for mobile targets
- A running LocateLost backend API
- A configured device or emulator; camera and location work best on a physical device

## Getting started

```bash
git clone <repository-url>
cd locate-lost
flutter pub get
flutter run
```

The API base URL is configured in `lib/utils/constants/endpoints.dart`. Update `Base_URL` before running the app. The checked-in value points to a development tunnel and may be unavailable outside the original development environment.

Validate changes with:

```bash
flutter analyze
flutter test
```

## Backend API integration

| Purpose | Endpoint |
| --- | --- |
| Sign in | `POST /api/auth/login` |
| Sign up | `POST /api/auth/signup` |
| Create missing-person report | `POST /api/reports/parent` |
| List the user's missing-person reports | `GET /api/reports/parent/my` |
| View a missing-person report | `GET /api/reports/parent/{reportId}` |
| Create found-person report | `POST /api/reports/finder` |
| List the user's found-person reports | `GET /api/reports/finder/my` |
| View a found-person report | `GET /api/reports/finder/{reportId}` |

Report creation uses multipart requests when images are attached. Authenticated requests send the access token as a Bearer token. Persistence, authentication, matching, and the API response contract are handled by the backend, which is not included in this repository.

## Permissions

Depending on the flow and target platform, LocateLost may request camera access, photo library access, and location access. Users should grant only the permissions required for the feature they are using.

## Project status

This repository contains the Flutter client application. Before publishing a release, configure a stable HTTPS API URL, review platform permission declarations, test camera/location behavior on supported devices, and replace development-only service values.

## Contributing

1. Create a feature branch.
2. Make a focused change.
3. Run `flutter analyze` and `flutter test`.
4. Open a pull request describing user-facing behavior and API changes.

## License

No license file is currently included. Add a license before distributing or accepting external contributions under defined terms.
