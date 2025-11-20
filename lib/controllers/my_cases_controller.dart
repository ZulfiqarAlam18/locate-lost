import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/parent_report/my_parent_reports_response.dart';
import '../data/models/parent_report/parent_report_by_id_response.dart';
import '../data/network/parent_report_helper.dart';

class MyCasesController extends GetxController {
  // Singleton pattern
  static MyCasesController get instance => Get.find<MyCasesController>();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Parent reports data
  final RxList<ParentReportItem> parentReports = <ParentReportItem>[].obs;
  final Rx<PaginationInfo?> paginationInfo = Rx<PaginationInfo?>(null);
  
  // Current selected report detail
  final Rx<ParentReportDetail?> selectedReportDetail = Rx<ParentReportDetail?>(null);
  
  // Helper instance
  final ParentReportHelper _reportHelper = ParentReportHelper();

  // Pagination settings
  int currentPage = 1;
  int pageLimit = 10;
  String currentStatus = ''; // Empty means all statuses
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    // Load reports when controller is initialized
    fetchMyParentReports();
  }

  /// Fetches user's parent reports from backend
  Future<void> fetchMyParentReports({
    bool isRefresh = false,
    int? page,
    String? status,
    String? search,
  }) async {
    try {
      if (isRefresh) {
        isRefreshing.value = true;
        currentPage = 1; // Reset to first page on refresh
      } else {
        isLoading.value = true;
      }
      errorMessage.value = '';

      // Update pagination/filter settings if provided
      if (page != null) currentPage = page;
      if (status != null) currentStatus = status;
      if (search != null) searchQuery = search;

      // Get auth token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        errorMessage.value = 'Authentication token not found. Please login again.';
        isLoading.value = false;
        isRefreshing.value = false;
        return;
      }

      // Prepare headers with auth token
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      print('🔍 Fetching parent reports - Page: $currentPage, Status: $currentStatus, Search: $searchQuery');

      // Call API
      final response = await _reportHelper.getMyReports(
        headers: headers,
        page: currentPage,
        limit: pageLimit,
        status: currentStatus.isNotEmpty ? currentStatus : null,
        search: searchQuery.isNotEmpty ? searchQuery : null,
      );

      if (response.success && response.data != null) {
        if (isRefresh || currentPage == 1) {
          // Replace entire list on refresh or first page
          parentReports.value = response.data!.reports;
        } else {
          // Append to existing list for pagination
          parentReports.addAll(response.data!.reports);
        }
        
        paginationInfo.value = response.data!.pagination;
        
        print('✅ Fetched ${response.data!.reports.length} parent reports');
        print('📊 Total: ${response.data!.pagination.total}, Pages: ${response.data!.pagination.pages}');
      } else {
        errorMessage.value = response.message ?? 'Failed to fetch reports';
        print('❌ Error fetching reports: ${errorMessage.value}');
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('❌ Exception in fetchMyParentReports: $e');
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  /// Fetches detailed information about a specific report
  Future<bool> fetchReportById(String reportId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get auth token
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        errorMessage.value = 'Authentication token not found. Please login again.';
        isLoading.value = false;
        return false;
      }

      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      print('🔍 Fetching report details for ID: $reportId');

      final response = await _reportHelper.getReportById(
        reportId: reportId,
        headers: headers,
      );

      if (response.success && response.data != null) {
        selectedReportDetail.value = response.data!.report;
        print('✅ Fetched report details successfully');
        return true;
      } else {
        errorMessage.value = response.message ?? 'Failed to fetch report details';
        print('❌ Error fetching report details: ${errorMessage.value}');
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('❌ Exception in fetchReportById: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh reports (pull to refresh)
  Future<void> refreshReports() async {
    await fetchMyParentReports(isRefresh: true);
  }

  /// Load next page of reports
  Future<void> loadMoreReports() async {
    if (paginationInfo.value != null) {
      final pagination = paginationInfo.value!;
      if (currentPage < pagination.pages) {
        await fetchMyParentReports(page: currentPage + 1);
      }
    }
  }

  /// Filter reports by status
  Future<void> filterByStatus(String status) async {
    await fetchMyParentReports(isRefresh: true, status: status);
  }

  /// Search reports
  Future<void> searchReports(String query) async {
    await fetchMyParentReports(isRefresh: true, search: query);
  }

  /// Clear selected report detail
  void clearSelectedReport() {
    selectedReportDetail.value = null;
  }

  /// Check if more pages are available
  bool get hasMorePages {
    if (paginationInfo.value == null) return false;
    return currentPage < paginationInfo.value!.pages;
  }

  /// Get total count of reports
  int get totalReports {
    return paginationInfo.value?.total ?? 0;
  }
}
