# Image Upload Fix - Parent Report API

## Problem Identified

The error "Only image files are allowed" was occurring because the Flutter app was not sending proper MIME types (Content-Type headers) with the uploaded image files.

### Root Cause

1. **Backend Validation**: The backend's `uploadMiddleware.js` uses this filter:
   ```javascript
   const imageFilter = (req, file, cb) => {
     if (file.mimetype.startsWith('image/')) {
       cb(null, true);
     } else {
       cb(new Error('Only image files are allowed!'), false);
     }
   };
   ```

2. **Flutter Issue**: When using `http.MultipartFile.fromPath()` without specifying `contentType`, the file is uploaded without a proper MIME type or with a generic `application/octet-stream` type, which doesn't start with `image/`.

## Solution Implemented

### 1. Added MIME Type Detection (`lib/data/network/parent_report_helper.dart`)

**Changes Made**:
- Added `import 'package:http_parser/http_parser.dart';` for MediaType support
- Implemented automatic MIME type detection based on file extension
- Added `contentType` parameter to `MultipartFile.fromPath()`

**Code Changes**:
```dart
// Determine MIME type from file extension
String mimeType = 'image/jpeg'; // default
final extension = file.path.toLowerCase().split('.').last;
switch (extension) {
  case 'jpg':
  case 'jpeg':
    mimeType = 'image/jpeg';
    break;
  case 'png':
    mimeType = 'image/png';
    break;
  case 'gif':
    mimeType = 'image/gif';
    break;
  case 'webp':
    mimeType = 'image/webp';
    break;
  case 'bmp':
    mimeType = 'image/bmp';
    break;
  default:
    mimeType = 'image/jpeg';
}

final multipartFile = await http.MultipartFile.fromPath(
  'images',
  file.path,
  filename: file.path.split(Platform.pathSeparator).last,
  contentType: MediaType.parse(mimeType), // ← THIS WAS MISSING
);
```

### 2. Enhanced Debug Logging

Added comprehensive logging to help debug issues:

**In ParentReportHelper**:
- File existence check with warning
- MIME type detection logging
- Total images attached count
- Request fields, headers, and file count before sending

**In ParentReportController**:
- Image count before upload
- Each image path and existence status

### Sample Debug Output

When submitting a report, you should now see:
```
📸 Images to upload: 3
  - /path/to/image1.jpg (exists: true)
  - /path/to/image2.png (exists: true)
  - /path/to/image3.jpg (exists: true)
📤 Creating parent report: https://j03ps88p-5000.asse.devtunnels.ms/api/reports/parent
📎 Added image 1: image1.jpg (image/jpeg)
📎 Added image 2: image2.png (image/png)
📎 Added image 3: image3.jpg (image/jpeg)
✅ Total images attached: 3
📋 Request fields: {childName: John, fatherName: Doe, ...}
📋 Request headers: {Authorization: Bearer eyJ...}
📋 Request files count: 3
📥 Response status: 201
📥 Response body: {"success":true,"message":"Parent report created successfully",...}
```

## Supported Image Formats

The fix now properly handles these image formats:
- **JPEG** (`.jpg`, `.jpeg`) → `image/jpeg`
- **PNG** (`.png`) → `image/png`
- **GIF** (`.gif`) → `image/gif`
- **WebP** (`.webp`) → `image/webp`
- **BMP** (`.bmp`) → `image/bmp`
- **Default**: Falls back to `image/jpeg` for unknown extensions

## Testing Instructions

1. **Clear App Data**: Ensure fresh state
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Run the App**:
   ```bash
   flutter run
   ```

3. **Test Image Upload Flow**:
   - Navigate to Missing Person Details
   - Fill all required fields
   - Go to Upload Images screen
   - Select 1-5 images from gallery
   - Verify images preview correctly
   - Navigate to Summary screen
   - Click Submit Report

4. **Check Console Output**:
   - Look for `📸 Images to upload:` message
   - Verify each file exists: `(exists: true)`
   - Confirm MIME types are detected: `(image/jpeg)`, `(image/png)`, etc.
   - Check response status: Should be `201` on success

5. **Backend Verification**:
   - Check backend logs for successful upload
   - Verify images are saved in `uploads/images/` directory
   - Confirm database record created with image paths

## Common Issues & Solutions

### Issue 1: File Not Found
**Symptom**: `⚠️ File not found: /path/to/image.jpg`
**Solution**: 
- Ensure camera/gallery permissions granted
- Check file picker returns valid XFile objects
- Verify file paths are accessible

### Issue 2: Wrong MIME Type
**Symptom**: Backend still rejects with "Only image files allowed"
**Solution**:
- Check file extension is recognized (jpg, png, gif, webp, bmp)
- Verify ContentType header in request (use network inspector)
- Add missing extension to switch statement if needed

### Issue 3: Token Expired (401)
**Symptom**: `📥 Response status: 401`
**Solution**:
- User needs to log in again
- Implement token refresh mechanism
- Check AuthController has valid access token

### Issue 4: File Size Too Large
**Symptom**: Backend returns "File too large. Maximum size is 5MB"
**Solution**:
- Implement image compression before upload
- Use `flutter_image_compress` package
- Show file size warning in UI

## Additional Improvements Made

1. **Better Error Messages**: More descriptive errors for debugging
2. **File Existence Check**: Skips non-existent files instead of crashing
3. **Detailed Request Logging**: Shows all request details before sending
4. **Type Safety**: Uses proper MediaType parsing

## Files Modified

- ✅ `lib/data/network/parent_report_helper.dart` - Added MIME type detection
- ✅ `lib/controllers/parent_report_controller.dart` - Added image logging

## Dependencies

The fix uses `http_parser` which is already included with the `http` package, so no additional dependencies needed.

## Next Steps

1. **Test with Real Backend**: Submit a report and verify images upload successfully
2. **Check Uploaded Images**: Verify images are stored correctly on server
3. **Verify Database Records**: Confirm image paths saved in database
4. **Test Different Image Types**: Try JPG, PNG, GIF, WebP to ensure all work
5. **Error Handling**: Test with invalid files to ensure proper error messages

---

**Fix Applied**: November 16, 2025  
**Status**: ✅ Ready for Testing  
**Impact**: Critical - Fixes primary report submission functionality
