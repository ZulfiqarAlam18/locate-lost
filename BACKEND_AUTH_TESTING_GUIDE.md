# Backend Authentication Testing Guide

## Prerequisites
1. Ensure backend server is running at: `https://j03ps88p-5000.asse.devtunnels.ms/`
2. Flutter app is properly configured with all dependencies installed
3. Device/emulator has internet connectivity

## Test Scenarios

### 1. Login Flow Test

#### Test Case 1.1: Successful Login
**Steps:**
1. Open the app
2. Click on "Login" (if not on login screen)
3. Enter valid credentials:
   - Email: (use existing test account)
   - Password: (corresponding password)
4. Click "Log In" button

**Expected Results:**
- Loading dialog appears with message "Logging in..."
- Button text changes to "Please Wait..."
- Button becomes disabled during loading
- After successful login:
  - Loading dialog closes
  - Success snackbar appears (green)
  - Location permission dialog shows up
- Console logs show:
  ```
  AuthHelper - Login Request:
  {email: test@example.com, password: ******}
  AuthHelper - Login Response: {success: true, ...}
  AuthController - User data saved to SharedPreferences
  ```

#### Test Case 1.2: Invalid Credentials
**Steps:**
1. Enter invalid email or password
2. Click "Log In" button

**Expected Results:**
- Error dialog appears with message from API
- User stays on login screen
- Console shows error response

#### Test Case 1.3: Empty Fields
**Steps:**
1. Leave email or password empty
2. Click "Log In" button

**Expected Results:**
- Red snackbar appears: "Please fill all required fields correctly."
- Form validation errors show below fields
- No API call is made

#### Test Case 1.4: Invalid Email Format
**Steps:**
1. Enter invalid email format (e.g., "notanemail")
2. Enter password
3. Click "Log In" button

**Expected Results:**
- Validation error shows: "Please enter a valid email address"
- No API call is made

### 2. Signup Flow Test

#### Test Case 2.1: Successful Signup
**Steps:**
1. Open signup screen
2. Accept Terms & Conditions dialog (appears automatically)
3. Fill in all fields:
   - Name: "John Doe"
   - Email: "newuser@test.com" (must be unique)
   - Phone: "1234567890"
   - Password: "Test@123"
   - Confirm Password: "Test@123"
4. Click "Create Account" button

**Expected Results:**
- Loading dialog appears with "Creating Account..."
- Button text changes to "Creating Account..."
- After success:
  - Green snackbar: "Account created successfully!"
  - Automatically navigates to main navigation screen (user is logged in)
- Console logs show:
  ```
  AuthHelper - Signup Request:
  {name: John Doe, email: newuser@test.com, ...}
  AuthHelper - Signup Response: {success: true, ...}
  AuthController - User data saved to SharedPreferences
  ```

#### Test Case 2.2: Terms Not Accepted
**Steps:**
1. Click "Decline" on Terms dialog
2. Try to fill form and submit

**Expected Results:**
- Red snackbar: "Please accept the Terms & Conditions"
- Cannot proceed

#### Test Case 2.3: Password Mismatch
**Steps:**
1. Accept terms
2. Fill all fields
3. Enter different passwords in Password and Confirm Password
4. Click "Create Account"

**Expected Results:**
- Red snackbar: "Passwords do not match"
- User stays on signup screen

#### Test Case 2.4: Existing Email
**Steps:**
1. Try to signup with already registered email
2. Click "Create Account"

**Expected Results:**
- API returns error: "Email already exists" (or similar)
- Red snackbar with error message
- User stays on signup screen

### 3. SharedPreferences Persistence Test

#### Test Case 3.1: Data Persistence After Login
**Steps:**
1. Login successfully
2. Close the app completely (kill process)
3. Reopen the app

**Expected Results:**
- User data is loaded from SharedPreferences
- `authController.isLoggedIn` is true
- User should be redirected to home/main screen (based on routing logic)
- Console shows: "AuthController - User data loaded from SharedPreferences"

#### Test Case 3.2: Data Cleared After Logout
**Steps:**
1. Login successfully
2. Navigate to profile/settings
3. Click logout
4. Check SharedPreferences

**Expected Results:**
- All auth data cleared
- `authController.isLoggedIn` is false
- User redirected to login screen
- Console shows: "AuthController - User data cleared"

### 4. Network Error Handling Test

#### Test Case 4.1: Network Timeout
**Steps:**
1. Turn off internet/set very slow connection
2. Try to login or signup

**Expected Results:**
- After 30 seconds, timeout error occurs
- Error dialog: "An error occurred: TimeoutException..."
- Loading dialog closes

#### Test Case 4.2: Server Down
**Steps:**
1. Stop backend server
2. Try to login or signup

**Expected Results:**
- Connection error appears
- User-friendly error message displayed

### 5. UI State Management Test

#### Test Case 5.1: Button State During Loading
**Steps:**
1. Enter credentials
2. Click login button
3. Quickly try to click again

**Expected Results:**
- Button text changes to "Please Wait..."
- Button is disabled (onPressed checks `isLoading`)
- Cannot trigger multiple API calls

#### Test Case 5.2: Reactive UI Updates
**Steps:**
1. Open browser dev tools / Dart DevTools
2. Watch `authController.isLoading` value
3. Trigger login

**Expected Results:**
- `isLoading` changes to `true` when API call starts
- Button text updates reactively via `Obx()`
- `isLoading` changes to `false` when API call completes

### 6. Console Logging Verification

#### Check Console for:
1. **Login Request Logs:**
   ```
   AuthHelper - Login Request:
   {email: user@test.com, password: ******}
   ```

2. **Login Response Logs:**
   ```
   AuthHelper - Login Response: {success: true, message: "Login successful", data: {...}}
   ```

3. **SharedPreferences Logs:**
   ```
   AuthController - Saving user data to SharedPreferences
   AuthController - User data saved successfully
   ```

4. **Error Logs:**
   ```
   AuthHelper - Login Error: [error details]
   ```

### 7. Edge Cases

#### Test Case 7.1: Very Long Email/Password
**Steps:**
1. Enter very long strings in fields
2. Submit

**Expected Results:**
- Fields should handle long input
- API should validate and return appropriate error

#### Test Case 7.2: Special Characters in Fields
**Steps:**
1. Use special characters in password
2. Submit

**Expected Results:**
- Should work correctly if backend allows
- Proper JSON encoding/decoding

#### Test Case 7.3: Rapid Button Clicks
**Steps:**
1. Click login/signup button multiple times rapidly

**Expected Results:**
- Only one API call should be made
- `isLoading` check prevents duplicate calls

## Debugging Tips

### 1. Check SharedPreferences Data
```dart
// Add this temporarily in AuthController for debugging
void printAllData() {
  print('isLoggedIn: ${isLoggedIn.value}');
  print('accessToken: ${accessToken.value}');
  print('userId: ${userId.value}');
  print('userName: ${userName.value}');
  print('userEmail: ${userEmail.value}');
}
```

### 2. Check Network Requests
- Use Charles Proxy or similar tool to intercept HTTP requests
- Verify request headers, body, and responses

### 3. Check Backend Logs
- Monitor backend server console for incoming requests
- Check for errors on server side

### 4. Use Flutter DevTools
- Open DevTools: `flutter run` then press 'v'
- Check widget tree for Obx widgets
- Monitor GetX state changes

## Common Issues & Solutions

### Issue 1: "AuthController not found"
**Solution:** Ensure you're on login or signup route where lazy binding is configured

### Issue 2: Data not persisting
**Solution:** Check if SharedPreferences is properly initialized and has write permissions

### Issue 3: Loading never stops
**Solution:** Check for unhandled exceptions in try-catch blocks; ensure LoadingDialogHelper.hide() is always called

### Issue 4: Button not reactive
**Solution:** Ensure button is wrapped with `Obx(() => ...)` widget

### Issue 5: Network timeout
**Solution:** Check internet connection and backend server status

## Success Criteria Checklist
- [ ] User can login with valid credentials
- [ ] User can signup with new account
- [ ] Login errors display properly
- [ ] Signup errors display properly
- [ ] Loading states work correctly
- [ ] Buttons are disabled during loading
- [ ] Data persists across app restarts
- [ ] Logout clears all data
- [ ] Network errors handled gracefully
- [ ] Console logs show proper request/response flow
- [ ] UI is reactive and updates automatically
- [ ] Navigation works after successful auth
- [ ] Terms & Conditions dialog appears on signup
- [ ] Password validation works
- [ ] Email validation works

## Test Accounts (Create these on backend if not exist)
1. **Test User 1:**
   - Email: test@example.com
   - Password: Test@123

2. **Test User 2:**
   - Email: parent@test.com
   - Password: Parent@456

3. **Test User 3:**
   - Email: finder@test.com
   - Password: Finder@789

## Notes
- Always check backend server is running before testing
- Clear app data between tests to test fresh signup flows
- Use unique emails for signup tests
- Monitor both Flutter console and backend server logs simultaneously
- Test on both Android and iOS if possible
- Test on real device and emulator
