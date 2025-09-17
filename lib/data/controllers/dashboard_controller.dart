import 'package:get/get.dart';
import '../models/dashboard_stats_model.dart';
import '../services/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _dashboardService = DashboardService();
  
  // Observable variables
  Rx<DashboardStats?> stats = Rx<DashboardStats?>(null);
  RxList<RecentActivity> recentActivities = <RecentActivity>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<Map<String, dynamic>> userSummary = Rx<Map<String, dynamic>>({});
  Rx<Map<String, dynamic>> analytics = Rx<Map<String, dynamic>>({});
  
  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }
  
  // Load all dashboard data
  Future<void> loadDashboardData() async {
    await Future.wait([
      loadStats(),
      loadRecentActivities(),
      loadUserSummary(),
      loadAnalytics(),
    ]);
  }
  
  // Load dashboard statistics
  Future<void> loadStats() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _dashboardService.getStats();
      
      if (result.success) {
        stats.value = result.data;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load recent activities
  Future<void> loadRecentActivities({int limit = 10}) async {
    try {
      final result = await _dashboardService.getRecentActivities(limit: limit);
      
      if (result.success) {
        recentActivities.value = result.data!;
      }
    } catch (e) {
      print('Error loading recent activities: $e');
    }
  }
  
  // Load user summary
  Future<void> loadUserSummary() async {
    try {
      final result = await _dashboardService.getUserSummary();
      
      if (result.success) {
        userSummary.value = result.data!;
      }
    } catch (e) {
      print('Error loading user summary: $e');
    }
  }
  
  // Load analytics data
  Future<void> loadAnalytics({String period = 'week'}) async {
    try {
      final result = await _dashboardService.getAnalytics(period: period);
      
      if (result.success) {
        analytics.value = result.data!;
      }
    } catch (e) {
      print('Error loading analytics: $e');
    }
  }
  
  // Refresh dashboard data
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}