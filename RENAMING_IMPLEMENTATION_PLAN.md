# LocateLost Project - Renaming Implementation Plan

This document provides a step-by-step plan to complete the renaming of files and directories in the LocateLost project to follow proper naming conventions.

## Progress So Far

We've already completed the following:

1. Created `lib/utils/` directory and moved:
   - `colors.dart` → `app_colors.dart`
   - `constants.dart` → `app_constants.dart`

2. Created properly named auth screen files:
   - `forget_password.dart` → `forgot_password_screen.dart`
   - `login.dart` → `login_screen.dart`
   - `signup.dart` → `signup_screen.dart`

3. Created properly named drawer screen files:
   - `about_us.dart` → `about_us_screen.dart`

4. Created properly named founder screen files:
   - `f_child_info.dart` → `found_person_details.dart`
   - `founder_info.dart` → `finder_details.dart`
   - `image.dart` → `camera_capture.dart`

5. Created properly named parent screen files:
   - `p_child_info.dart` → `missing_person_details.dart`
   - `parent_info.dart` → `reporter_details.dart`

6. Created properly named widget files:
   - `custom_appBar.dart` → `custom_app_bar.dart`
   - `custom_textField.dart` → `custom_text_field.dart`
   - `custom_alertBox.dart` → `custom_alert_box.dart`

7. Created properly named other files:
   - `record.dart` → `case_summary.dart`

## Remaining Tasks

### 1. Rename Remaining Drawer Screen Files

- [ ] `contact_us.dart` → `contact_us_screen.dart`
- [ ] `emergency.dart` → `emergency_screen.dart`
- [ ] `faqs.dart` → `faqs_screen.dart`
- [ ] `terms_and_conditions.dart` → `terms_and_conditions_screen.dart`

### 2. Rename Other View Files

- [ ] `display_info.dart` → `display_info_screen.dart`
- [ ] `profile.dart` → `profile_screen.dart`
- [ ] `report_case.dart` → `report_case_screen.dart`

### 3. Rename Splash Screen Files

- [ ] Ensure all files in `views/splash_screens/` follow naming conventions:
  - `splash.dart` → `splash_screen.dart`
  - `splash1.dart` → `splash_screen_1.dart`
  - `splash2.dart` → `splash_screen_2.dart`
  - `splash3.dart` → `splash_screen_3.dart`

### 4. Update Import Statements

- [ ] Update all import statements in the renamed files to reference the new file paths
- [ ] Update all import statements in other files that reference the renamed files

### 5. Update Class Names

- [ ] Update class names to match file names (e.g., `ContactUs` → `ContactUsScreen`)
- [ ] Update all references to these classes throughout the codebase

### 6. Remove Duplicate Files and Directories

- [ ] Remove `lib/views/SplashScreens/` directory after confirming `lib/views/splash_screens/` works correctly
- [ ] Remove `lib/Widgets/` directory after confirming `lib/widgets/` works correctly
- [ ] Remove all old files that have been replaced with properly named versions

### 7. Create Missing Directories

- [ ] Create `lib/models/` directory (if it doesn't exist)
- [ ] Create `lib/services/` directory (if it doesn't exist)

### 8. Testing

- [ ] Test the application after each set of changes to ensure everything works correctly
- [ ] Verify all navigation flows still work as expected
- [ ] Check for any broken imports or references

## Implementation Approach

For each file that needs to be renamed:

1. Create the new file with the proper name
2. Copy the content from the old file to the new file
3. Update import statements in the new file
4. Update class names in the new file
5. Update references to the class in other files
6. Test to ensure everything works correctly
7. Remove the old file

## Priority Order

Implement the changes in this order to minimize disruption:

1. Rename remaining drawer screen files
2. Rename other view files
3. Rename splash screen files
4. Update import statements
5. Update class names
6. Remove duplicate files and directories
7. Create missing directories
8. Final testing

## Command Reference

Here are some helpful commands for implementing these changes:

```bash
# Create new directories
mkdir -p lib/models lib/services

# Find files that need to be updated
grep -r "import.*old_file_name" lib/

# Find class references that need to be updated
grep -r "OldClassName" lib/
```

## Final Steps

After completing all the renaming tasks:

1. Update the main.dart file to use the new imports and class names
2. Run a final comprehensive test of the application
3. Document any issues or edge cases encountered during the process
