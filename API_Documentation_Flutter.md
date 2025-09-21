# LocateLost Backend API Documentation - Flutter Integration Guide

## Quick Start for Flutter
**Base URL**: `http://10.11.73.25:5000`
**Content-Type**: `application/json`
**Authentication**: JWT Bearer Token

### Health Check
Test backend connectivity:
```
GET http://10.11.73.25:5000/api/health
```

## Flutter Project Setup

### 1. Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  get_storage: ^2.1.1
  http: ^1.1.0
  image_picker: ^1.0.4
  geolocator: ^10.1.0
  socket_io_client: ^2.0.3+1
```

### 2. API Response Model
```dart
// models/api_response.dart
class ApiResponse {
  final bool success;
  final String? message;
  final dynamic data;
  
  ApiResponse({
    required this.success,
    this.message,
    this.data,
  });
  
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
    );
  }
}
```

### 3. Base Service Class
```dart
// services/base_service.dart
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseService extends GetxService {
  static const String baseUrl = 'http://10.11.73.25:5000/api';
  final GetStorage storage = GetStorage();
  
  Map<String, String> get headers {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    
    final token = storage.read('accessToken');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
  
  Future<ApiResponse> handleResponse(http.Response response) async {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ApiResponse(
        success: true,
        message: responseData['message'],
        data: responseData['data'],
      );
    } else {
      return ApiResponse(
        success: false,
        message: responseData['message'] ?? 'Request failed',
      );
    }
  }
}
```

---

## Authentication Routes
**Base path**: `/api/auth`

### 1. Register User - POST /signup

**Request Body**:
```json
{
  "first_name": "John",
  "last_name": "Doe", 
  "email": "john.doe@example.com",
  "password": "securePassword123",
  "phone": "+1234567890",
  "address": "123 Main St, City, State",
  "userType": "parent"
}
```

**Flutter Implementation**:
```dart
// services/auth_service.dart
class AuthService extends BaseService {
  Future<ApiResponse> register(Map<String, String> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: headers,
        body: jsonEncode(userData),
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/auth_controller.dart
class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  
  void checkLoginStatus() {
    final token = GetStorage().read('accessToken');
    isLoggedIn.value = token != null;
  }
  
  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String userType,
  }) async {
    isLoading.value = true;
    
    final userData = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'userType': userType,
    };
    
    final response = await _authService.register(userData);
    
    if (response.success) {
      Get.snackbar('Success', response.message!);
      Get.offNamed('/login');
    } else {
      Get.snackbar('Error', response.message!);
    }
    
    isLoading.value = false;
  }
}
```

### 2. Login User - POST /signin

**Request Body**:
```json
{
  "email": "john.doe@example.com",
  "password": "securePassword123"
}
```

**Flutter Implementation**:
```dart
// services/auth_service.dart (continued)
Future<ApiResponse> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signin'),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    
    final result = await handleResponse(response);
    
    if (result.success && result.data != null) {
      // Store tokens and user data
      await storage.write('accessToken', result.data['accessToken']);
      await storage.write('refreshToken', result.data['refreshToken']);
      await storage.write('user', result.data['user']);
    }
    
    return result;
  } catch (e) {
    return ApiResponse(
      success: false,
      message: 'Network error: ${e.toString()}',
    );
  }
}

// controllers/auth_controller.dart (continued)
Future<void> loginUser(String email, String password) async {
  isLoading.value = true;
  
  final response = await _authService.login(email, password);
  
  if (response.success) {
    isLoggedIn.value = true;
    Get.snackbar('Success', 'Welcome back!');
    Get.offAllNamed('/dashboard');
  } else {
    Get.snackbar('Error', response.message!);
  }
  
  isLoading.value = false;
}
```

### 3. Refresh Token - POST /refresh-token

**Request Body**:
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Flutter Implementation**:
```dart
// services/auth_service.dart (continued)
Future<ApiResponse> refreshToken() async {
  try {
    final refreshToken = storage.read('refreshToken');
    
    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh-token'),
      headers: headers,
      body: jsonEncode({
        'refreshToken': refreshToken,
      }),
    );
    
    final result = await handleResponse(response);
    
    if (result.success && result.data != null) {
      await storage.write('accessToken', result.data['accessToken']);
      await storage.write('refreshToken', result.data['refreshToken']);
    }
    
    return result;
  } catch (e) {
    return ApiResponse(
      success: false,
      message: 'Network error: ${e.toString()}',
    );
  }
}
```

---

## Parent Report Routes
**Base path**: `/api/parent-reports`
**Authentication**: Required

### 1. Create Parent Report - POST /

**Content-Type**: `multipart/form-data`

**Form Data**:
- `childName` (string): Child's name
- `childAge` (number): Child's age
- `description` (string): Description of the child
- `lastSeenLocation` (string): Last seen location
- `contactInfo` (string): Contact information
- `images` (file): Child's photos (multiple files supported)

**Flutter Implementation**:
```dart
// models/parent_report.dart
class ParentReport {
  final String? id;
  final String childName;
  final int childAge;
  final String description;
  final String lastSeenLocation;
  final String contactInfo;
  final List<String>? imagePaths;
  final DateTime? createdAt;
  
  ParentReport({
    this.id,
    required this.childName,
    required this.childAge,
    required this.description,
    required this.lastSeenLocation,
    required this.contactInfo,
    this.imagePaths,
    this.createdAt,
  });
  
  factory ParentReport.fromJson(Map<String, dynamic> json) {
    return ParentReport(
      id: json['id'],
      childName: json['childName'],
      childAge: json['childAge'],
      description: json['description'],
      lastSeenLocation: json['lastSeenLocation'],
      contactInfo: json['contactInfo'],
      imagePaths: json['imagePaths']?.cast<String>(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

// services/parent_report_service.dart
class ParentReportService extends BaseService {
  Future<ApiResponse> createReport({
    required String childName,
    required int childAge,
    required String description,
    required String lastSeenLocation,
    required String contactInfo,
    required List<File> images,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/parent-reports'),
      );
      
      // Add headers
      final token = storage.read('accessToken');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      
      // Add form fields
      request.fields.addAll({
        'childName': childName,
        'childAge': childAge.toString(),
        'description': description,
        'lastSeenLocation': lastSeenLocation,
        'contactInfo': contactInfo,
      });
      
      // Add image files
      for (File image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
        ));
      }
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
  
  Future<ApiResponse> getMyReports() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/parent-reports/my-reports'),
        headers: headers,
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/parent_report_controller.dart
class ParentReportController extends GetxController {
  final ParentReportService _reportService = Get.find<ParentReportService>();
  final RxBool isLoading = false.obs;
  final RxList<ParentReport> reports = <ParentReport>[].obs;
  
  Future<void> createReport({
    required String childName,
    required int childAge,
    required String description,
    required String lastSeenLocation,
    required String contactInfo,
    required List<File> images,
  }) async {
    isLoading.value = true;
    
    final response = await _reportService.createReport(
      childName: childName,
      childAge: childAge,
      description: description,
      lastSeenLocation: lastSeenLocation,
      contactInfo: contactInfo,
      images: images,
    );
    
    if (response.success) {
      Get.snackbar('Success', 'Report created successfully');
      await fetchMyReports();
      Get.back();
    } else {
      Get.snackbar('Error', response.message!);
    }
    
    isLoading.value = false;
  }
  
  Future<void> fetchMyReports() async {
    final response = await _reportService.getMyReports();
    
    if (response.success && response.data != null) {
      final List<dynamic> reportList = response.data;
      reports.value = reportList.map((json) => ParentReport.fromJson(json)).toList();
    }
  }
}
```

### 2. Get My Reports - GET /my-reports

**Headers**:
```
Authorization: Bearer <jwt_token>
```

**Response**:
```json
{
  "success": true,
  "data": [
    {
      "id": "report_id",
      "childName": "John Doe",
      "childAge": 8,
      "description": "Wearing blue shirt and jeans",
      "lastSeenLocation": "Central Park, NYC",
      "contactInfo": "+1234567890",
      "imagePaths": ["path/to/image1.jpg", "path/to/image2.jpg"],
      "createdAt": "2024-01-15T10:30:00.000Z",
      "status": "active"
    }
  ]
}
```

---

## Finder Report Routes
**Base path**: `/api/finder-reports`
**Authentication**: Required

### 1. Create Finder Report - POST /

**Content-Type**: `multipart/form-data`

**Form Data**:
- `description` (string): Description of the found child
- `foundLocation` (string): Where the child was found
- `currentLocation` (string): Current location of the child
- `contactInfo` (string): Finder's contact information
- `images` (file): Photos of the found child

**Flutter Implementation**:
```dart
// models/finder_report.dart
class FinderReport {
  final String? id;
  final String description;
  final String foundLocation;
  final String currentLocation;
  final String contactInfo;
  final List<String>? imagePaths;
  final DateTime? createdAt;
  
  FinderReport({
    this.id,
    required this.description,
    required this.foundLocation,
    required this.currentLocation,
    required this.contactInfo,
    this.imagePaths,
    this.createdAt,
  });
  
  factory FinderReport.fromJson(Map<String, dynamic> json) {
    return FinderReport(
      id: json['id'],
      description: json['description'],
      foundLocation: json['foundLocation'],
      currentLocation: json['currentLocation'],
      contactInfo: json['contactInfo'],
      imagePaths: json['imagePaths']?.cast<String>(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

// services/finder_report_service.dart
class FinderReportService extends BaseService {
  Future<ApiResponse> createReport({
    required String description,
    required String foundLocation,
    required String currentLocation,
    required String contactInfo,
    required List<File> images,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/finder-reports'),
      );
      
      final token = storage.read('accessToken');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      
      request.fields.addAll({
        'description': description,
        'foundLocation': foundLocation,
        'currentLocation': currentLocation,
        'contactInfo': contactInfo,
      });
      
      for (File image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
        ));
      }
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/finder_report_controller.dart
class FinderReportController extends GetxController {
  final FinderReportService _finderService = Get.find<FinderReportService>();
  final RxBool isLoading = false.obs;
  
  Future<void> createFinderReport({
    required String description,
    required String foundLocation,
    required String currentLocation,
    required String contactInfo,
    required List<File> images,
  }) async {
    isLoading.value = true;
    
    final response = await _finderService.createReport(
      description: description,
      foundLocation: foundLocation,
      currentLocation: currentLocation,
      contactInfo: contactInfo,
      images: images,
    );
    
    if (response.success) {
      Get.snackbar('Success', 'Finder report submitted successfully');
      Get.back();
    } else {
      Get.snackbar('Error', response.message!);
    }
    
    isLoading.value = false;
  }
}
```

---

## Match Routes
**Base path**: `/api/matches`
**Authentication**: Required

### 1. Get All Matches - GET /

**Response**:
```json
{
  "success": true,
  "data": [
    {
      "id": "match_id",
      "parentReportId": "parent_report_id",
      "finderReportId": "finder_report_id",
      "matchScore": 0.85,
      "status": "pending",
      "createdAt": "2024-01-15T10:30:00.000Z",
      "parentReport": {
        "childName": "John Doe",
        "imagePaths": ["path/to/image.jpg"]
      },
      "finderReport": {
        "description": "Found child description",
        "imagePaths": ["path/to/found_image.jpg"]
      }
    }
  ]
}
```

**Flutter Implementation**:
```dart
// models/match.dart
class Match {
  final String id;
  final String parentReportId;
  final String finderReportId;
  final double matchScore;
  final String status;
  final DateTime createdAt;
  final ParentReport? parentReport;
  final FinderReport? finderReport;
  
  Match({
    required this.id,
    required this.parentReportId,
    required this.finderReportId,
    required this.matchScore,
    required this.status,
    required this.createdAt,
    this.parentReport,
    this.finderReport,
  });
  
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      parentReportId: json['parentReportId'],
      finderReportId: json['finderReportId'],
      matchScore: json['matchScore'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      parentReport: json['parentReport'] != null 
        ? ParentReport.fromJson(json['parentReport']) 
        : null,
      finderReport: json['finderReport'] != null 
        ? FinderReport.fromJson(json['finderReport']) 
        : null,
    );
  }
}

// services/match_service.dart
class MatchService extends BaseService {
  Future<ApiResponse> getAllMatches() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/matches'),
        headers: headers,
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
  
  Future<ApiResponse> updateMatchStatus(String matchId, String status) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/matches/$matchId/status'),
        headers: headers,
        body: jsonEncode({'status': status}),
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/match_controller.dart
class MatchController extends GetxController {
  final MatchService _matchService = Get.find<MatchService>();
  final RxList<Match> matches = <Match>[].obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }
  
  Future<void> fetchMatches() async {
    isLoading.value = true;
    
    final response = await _matchService.getAllMatches();
    
    if (response.success && response.data != null) {
      final List<dynamic> matchList = response.data;
      matches.value = matchList.map((json) => Match.fromJson(json)).toList();
    }
    
    isLoading.value = false;
  }
  
  Future<void> updateMatchStatus(String matchId, String status) async {
    final response = await _matchService.updateMatchStatus(matchId, status);
    
    if (response.success) {
      Get.snackbar('Success', 'Match status updated');
      await fetchMatches();
    } else {
      Get.snackbar('Error', response.message!);
    }
  }
}
```

---

## Dashboard Routes
**Base path**: `/api/dashboard`
**Authentication**: Required

### 1. Get Dashboard Stats - GET /stats

**Response**:
```json
{
  "success": true,
  "data": {
    "totalParentReports": 150,
    "totalFinderReports": 85,
    "totalMatches": 12,
    "successfulMatches": 8,
    "pendingMatches": 4,
    "recentActivity": [
      {
        "type": "match_found",
        "message": "New match found for John Doe",
        "timestamp": "2024-01-15T10:30:00.000Z"
      }
    ]
  }
}
```

**Flutter Implementation**:
```dart
// models/dashboard_stats.dart
class DashboardStats {
  final int totalParentReports;
  final int totalFinderReports;
  final int totalMatches;
  final int successfulMatches;
  final int pendingMatches;
  final List<Activity> recentActivity;
  
  DashboardStats({
    required this.totalParentReports,
    required this.totalFinderReports,
    required this.totalMatches,
    required this.successfulMatches,
    required this.pendingMatches,
    required this.recentActivity,
  });
  
  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalParentReports: json['totalParentReports'],
      totalFinderReports: json['totalFinderReports'],
      totalMatches: json['totalMatches'],
      successfulMatches: json['successfulMatches'],
      pendingMatches: json['pendingMatches'],
      recentActivity: (json['recentActivity'] as List)
        .map((activity) => Activity.fromJson(activity))
        .toList(),
    );
  }
}

class Activity {
  final String type;
  final String message;
  final DateTime timestamp;
  
  Activity({
    required this.type,
    required this.message,
    required this.timestamp,
  });
  
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      type: json['type'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

// services/dashboard_service.dart
class DashboardService extends BaseService {
  Future<ApiResponse> getDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard/stats'),
        headers: headers,
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/dashboard_controller.dart
class DashboardController extends GetxController {
  final DashboardService _dashboardService = Get.find<DashboardService>();
  final Rx<DashboardStats?> stats = Rx<DashboardStats?>(null);
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchDashboardStats();
  }
  
  Future<void> fetchDashboardStats() async {
    isLoading.value = true;
    
    final response = await _dashboardService.getDashboardStats();
    
    if (response.success && response.data != null) {
      stats.value = DashboardStats.fromJson(response.data);
    }
    
    isLoading.value = false;
  }
}
```

---

## Notification Routes
**Base path**: `/api/notifications`
**Authentication**: Required

### 1. Get User Notifications - GET /

**Response**:
```json
{
  "success": true,
  "data": [
    {
      "id": "notification_id",
      "title": "New Match Found",
      "message": "A potential match has been found for your report",
      "type": "match",
      "isRead": false,
      "createdAt": "2024-01-15T10:30:00.000Z"
    }
  ]
}
```

**Flutter Implementation**:
```dart
// models/notification.dart
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });
  
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

// services/notification_service.dart
class NotificationService extends BaseService {
  Future<ApiResponse> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: headers,
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
  
  Future<ApiResponse> markAsRead(String notificationId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/notifications/$notificationId/read'),
        headers: headers,
      );
      return await handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}

// controllers/notification_controller.dart
class NotificationController extends GetxController {
  final NotificationService _notificationService = Get.find<NotificationService>();
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }
  
  Future<void> fetchNotifications() async {
    isLoading.value = true;
    
    final response = await _notificationService.getNotifications();
    
    if (response.success && response.data != null) {
      final List<dynamic> notificationList = response.data;
      notifications.value = notificationList
        .map((json) => NotificationModel.fromJson(json))
        .toList();
    }
    
    isLoading.value = false;
  }
  
  Future<void> markAsRead(String notificationId) async {
    final response = await _notificationService.markAsRead(notificationId);
    
    if (response.success) {
      // Update local notification status
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        notifications[index] = NotificationModel(
          id: notifications[index].id,
          title: notifications[index].title,
          message: notifications[index].message,
          type: notifications[index].type,
          isRead: true,
          createdAt: notifications[index].createdAt,
        );
      }
    }
  }
}
```

---

## Socket.IO Integration

**Flutter Implementation**:
```dart
// services/socket_service.dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  IO.Socket? socket;
  final String serverUrl = 'http://10.11.73.25:5000';
  
  @override
  void onInit() {
    super.onInit();
    _initSocket();
  }
  
  void _initSocket() {
    final token = GetStorage().read('accessToken');
    
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': token}
    });
    
    socket!.connect();
    
    socket!.on('connect', (data) {
      print('Connected to server');
    });
    
    socket!.on('newMatch', (data) {
      // Handle new match notification
      Get.snackbar('New Match', 'A potential match has been found!');
    });
    
    socket!.on('locationUpdate', (data) {
      // Handle location updates
      print('Location update received: $data');
    });
    
    socket!.on('disconnect', (data) {
      print('Disconnected from server');
    });
  }
  
  void sendLocationUpdate(Map<String, dynamic> locationData) {
    socket?.emit('locationUpdate', locationData);
  }
  
  @override
  void onClose() {
    socket?.disconnect();
    socket?.dispose();
    super.onClose();
  }
}
```

---

## App Initialization

**main.dart**:
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // Initialize services
  Get.put(AuthService());
  Get.put(ParentReportService());
  Get.put(FinderReportService());
  Get.put(MatchService());
  Get.put(DashboardService());
  Get.put(NotificationService());
  Get.put(SocketService());
  
  // Initialize controllers
  Get.put(AuthController());
  Get.put(ParentReportController());
  Get.put(FinderReportController());
  Get.put(MatchController());
  Get.put(DashboardController());
  Get.put(NotificationController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LocateLost',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Get.find<AuthController>().isLoggedIn.value ? '/dashboard' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/create-parent-report', page: () => CreateParentReportScreen()),
        GetPage(name: '/create-finder-report', page: () => CreateFinderReportScreen()),
        GetPage(name: '/matches', page: () => MatchesScreen()),
        GetPage(name: '/notifications', page: () => NotificationsScreen()),
      ],
    );
  }
}
```

---

## Error Responses

All error responses follow this format:
```json
{
  "success": false,
  "message": "Error description",
  "errors": ["Detailed error messages"]
}
```

Common HTTP status codes:
- `200`: Success
- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `422`: Validation Error
- `500`: Internal Server Error

---

## Testing the Integration

1. **Test Backend Connectivity**:
```dart
// Test health endpoint
Future<void> testConnection() async {
  try {
    final response = await http.get(
      Uri.parse('http://10.11.73.25:5000/api/health'),
    );
    
    if (response.statusCode == 200) {
      print('Backend is reachable');
      print('Response: ${response.body}');
    } else {
      print('Backend error: ${response.statusCode}');
    }
  } catch (e) {
    print('Connection error: $e');
  }
}
```

2. **Test Authentication**:
```dart
// Test registration and login flow
final authController = Get.find<AuthController>();
await authController.registerUser(
  firstName: 'Test',
  lastName: 'User',
  email: 'test@example.com',
  password: 'password123',
  phone: '+1234567890',
  address: 'Test Address',
  userType: 'parent',
);
```

This documentation provides complete Flutter GetX integration examples for the LocateLost backend. Each endpoint includes the exact code needed for implementation in a Flutter app using GetX state management.