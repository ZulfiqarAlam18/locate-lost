import 'package:get/get.dart';
import '../models/match_model.dart';
import '../services/match_service.dart';

class MatchController extends GetxController {
  final MatchService _matchService = MatchService();
  
  // Observable variables
  RxList<MatchedCase> matches = <MatchedCase>[].obs;
  RxList<MatchedCase> myMatches = <MatchedCase>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<Map<String, dynamic>> matchStats = Rx<Map<String, dynamic>>({});
  
  @override
  void onInit() {
    super.onInit();
    loadMyMatches();
    loadMatchStats();
  }
  
  // Load user's matches
  Future<void> loadMyMatches({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _matchService.getMyMatches(
        page: page,
        limit: limit,
        status: status,
      );
      
      if (result.success) {
        if (page == 1) {
          myMatches.value = result.data!;
        } else {
          myMatches.addAll(result.data!);
        }
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Error', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load all matches (admin/police only)
  Future<void> loadAllMatches({
    int page = 1,
    int limit = 20,
    String? status,
    String? matchType,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _matchService.getAllMatches(
        page: page,
        limit: limit,
        status: status,
        matchType: matchType,
      );
      
      if (result.success) {
        if (page == 1) {
          matches.value = result.data!;
        } else {
          matches.addAll(result.data!);
        }
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Confirm match
  Future<bool> confirmMatch(String matchId) async {
    try {
      final result = await _matchService.confirmMatch(matchId);
      
      if (result.success) {
        // Update the match in the list
        final index = myMatches.indexWhere((match) => match.id == matchId);
        if (index != -1) {
          myMatches[index] = result.data!;
        }
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Reject match
  Future<bool> rejectMatch(String matchId, String reason) async {
    try {
      final result = await _matchService.rejectMatch(matchId, reason);
      
      if (result.success) {
        // Update the match in the list
        final index = myMatches.indexWhere((match) => match.id == matchId);
        if (index != -1) {
          myMatches[index] = result.data!;
        }
        
        Get.snackbar(
          'Success', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        Get.snackbar(
          'Failed', 
          result.message,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
  
  // Load match statistics
  Future<void> loadMatchStats() async {
    try {
      final result = await _matchService.getMatchStats();
      
      if (result.success) {
        matchStats.value = result.data!;
      }
    } catch (e) {
      print('Error loading match stats: $e');
    }
  }
  
  // Refresh matches
  Future<void> refreshMatches() async {
    await loadMyMatches(page: 1);
  }
  
  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}