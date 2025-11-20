import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/parent_report/my_parent_reports_response.dart' as parent_models;
import '../data/models/parent_report/parent_report_by_id_response.dart';
import '../data/models/finder_report/my_finder_reports_response.dart' as finder_models;
import '../data/models/finder_report/finder_report_by_id_response.dart';
import '../data/network/parent_report_helper.dart';
import '../data/network/finder_report_helper.dart';

class MyCasesController extends GetxController {
  // Singleton pattern
  static MyCasesController get instance => Get.find<MyCasesController>();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Parent reports data
  final RxList<parent_models.ParentReportItem> parentReports = <parent_models.ParentReportItem>[].obs;
  final Rx<parent_models.PaginationInfo?> parentPaginationInfo = Rx<parent_models.PaginationInfo?>(null);
  
  // Finder reports data
  final RxList<finder_models.FinderReportItem> finderReports = <finder_models.FinderReportItem>[].obs;
  final Rx<finder_models.PaginationInfo?> finderPaginationInfo = Rx<finder_models.PaginationInfo?>(null);
  
  // Current selected report details
  final Rx<ParentReportDetail?> selectedParentReportDetail = Rx<ParentReportDetail?>(null);
  final Rx<FinderReportDetail?> selectedFinderReportDetail = Rx<FinderReportDetail?>(null);
  
  // Helper instances
  final ParentReportHelper _parentReportHelper = ParentReportHelper();
  final FinderReportHelper _finderReportHelper = FinderReportHelper();

  // Pagination settings for parent reports
  int parentCurrentPage = 1;
  int parentPageLimit = 10;
  String parentCurrentStatus = '';
  String parentSearchQuery = '';
  
  // Pagination settings for finder reports
  int finderCurrentPage = 1;
  int finderPageLimit = 10;
  String finderCurrentStatus = '';
  String finderSearchQuery = '';

  @override
  void onInit() {
    super.onInit();
    // Load both parent and finder reports when controller is initialized
    fetchMyParentReports();
    fetchMyFinderReports();
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
        parentCurrentPage = 1; // Reset to first page on refresh
      } else {
        isLoading.value = true;
      }
      errorMessage.value = '';

      // Update pagination/filter settings if provided
      if (page != null) parentCurrentPage = page;
      if (status != null) parentCurrentStatus = status;
      if (search != null) parentSearchQuery = search;

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

      print('🔍 Fetching parent reports - Page: $parentCurrentPage, Status: $parentCurrentStatus, Search: $parentSearchQuery');

      // Call API
      final response = await _parentReportHelper.getMyReports(
        headers: headers,
        page: parentCurrentPage,
        limit: parentPageLimit,
        status: parentCurrentStatus.isNotEmpty ? parentCurrentStatus : null,
        search: parentSearchQuery.isNotEmpty ? parentSearchQuery : null,
      );

      if (response.success && response.data != null) {
        if (isRefresh || parentCurrentPage == 1) {
          // Replace entire list on refresh or first page
          parentReports.value = response.data!.reports;
        } else {
          // Append to existing list for pagination
          parentReports.addAll(response.data!.reports);
        }
        
        parentPaginationInfo.value = response.data!.pagination;
        
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

      print('🔍 Fetching parent report details for ID: $reportId');

      final response = await _parentReportHelper.getReportById(
        reportId: reportId,
        headers: headers,
      );

      if (response.success && response.data != null) {
        selectedParentReportDetail.value = response.data!.report;
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
    if (parentPaginationInfo.value != null) {
      final pagination = parentPaginationInfo.value!;
      if (parentCurrentPage < pagination.pages) {
        await fetchMyParentReports(page: parentCurrentPage + 1);
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

  /// Clear selected report details
  void clearSelectedReport() {
    selectedParentReportDetail.value = null;
    selectedFinderReportDetail.value = null;
  }

  /// Check if more pages are available for parent reports
  bool get hasMoreParentPages {
    if (parentPaginationInfo.value == null) return false;
    return parentCurrentPage < parentPaginationInfo.value!.pages;
  }

  /// Get total count of parent reports
  int get totalParentReports {
    return parentPaginationInfo.value?.total ?? 0;
  }
  
  /// Get total count of finder reports
  int get totalFinderReports {
    return finderPaginationInfo.value?.total ?? 0;
  }

  // ============================================
  // FINDER REPORTS METHODS
  // ============================================

  /// Fetches user's finder reports from backend
  Future<void> fetchMyFinderReports({
    bool isRefresh = false,
    int? page,
    String? status,
    String? search,
  }) async {
    try {
      if (isRefresh) {
        isRefreshing.value = true;
        finderCurrentPage = 1; // Reset to first page on refresh
      } else {
        isLoading.value = true;
      }
      errorMessage.value = '';

      // Update pagination/filter settings if provided
      if (page != null) finderCurrentPage = page;
      if (status != null) finderCurrentStatus = status;
      if (search != null) finderSearchQuery = search;

      // Get auth token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        errorMessage.value = 'Authentication token not found. Please login again.';
        isLoading.value = false;
        isRefreshing.value = false;
        return;
      }

      print('🔍 Fetching finder reports - Page: $finderCurrentPage, Status: $finderCurrentStatus, Search: $finderSearchQuery');

      // Call API
      final response = await _finderReportHelper.getMyReports(
        accessToken: accessToken,
        page: finderCurrentPage,
        limit: finderPageLimit,
        status: finderCurrentStatus.isNotEmpty ? finderCurrentStatus : null,
        search: finderSearchQuery.isNotEmpty ? finderSearchQuery : null,
      );

      if (response.success && response.data != null) {
        if (isRefresh || finderCurrentPage == 1) {
          // Replace entire list on refresh or first page
          finderReports.value = response.data!.reports;
        } else {
          // Append to existing list for pagination
          finderReports.addAll(response.data!.reports);
        }
        
        finderPaginationInfo.value = response.data!.pagination;
        
        print('✅ Fetched ${response.data!.reports.length} finder reports');
        print('📊 Total: ${response.data!.pagination.total}, Pages: ${response.data!.pagination.pages}');
      } else {
        errorMessage.value = 'Failed to fetch finder reports';
        print('❌ Error fetching finder reports: ${errorMessage.value}');
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('❌ Exception in fetchMyFinderReports: $e');
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  /// Fetches detailed information about a specific finder report
  Future<bool> fetchFinderReportById(String reportId) async {
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

      print('🔍 Fetching finder report details for ID: $reportId');

      final response = await _finderReportHelper.getReportById(
        reportId: reportId,
        accessToken: accessToken,
      );

      if (response.success && response.data != null) {
        selectedFinderReportDetail.value = response.data!.report;
        print('✅ Fetched finder report details successfully');
        return true;
      } else {
        errorMessage.value = 'Failed to fetch finder report details';
        print('❌ Error fetching finder report details: ${errorMessage.value}');
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('❌ Exception in fetchFinderReportById: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh finder reports (pull to refresh)
  Future<void> refreshFinderReports() async {
    await fetchMyFinderReports(isRefresh: true);
  }

  /// Load next page of finder reports
  Future<void> loadMoreFinderReports() async {
    if (finderPaginationInfo.value != null) {
      final pagination = finderPaginationInfo.value!;
      if (finderCurrentPage < pagination.pages) {
        await fetchMyFinderReports(page: finderCurrentPage + 1);
      }
    }
  }

  /// Filter finder reports by status
  Future<void> filterFinderByStatus(String status) async {
    await fetchMyFinderReports(isRefresh: true, status: status);
  }

  /// Search finder reports
  Future<void> searchFinderReports(String query) async {
    await fetchMyFinderReports(isRefresh: true, search: query);
  }

  /// Check if more pages are available for finder reports
  bool get hasMoreFinderPages {
    if (finderPaginationInfo.value == null) return false;
    return finderCurrentPage < finderPaginationInfo.value!.pages;
  }
}
