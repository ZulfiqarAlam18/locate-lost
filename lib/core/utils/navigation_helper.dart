import 'package:get/get.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/main_bottom_navigation.dart';

/// Navigation utility class for handling external navigation to main navigation tabs
class NavigationHelper {
  // Private constructor to prevent instantiation
  NavigationHelper._();
  
  /// Navigate to main navigation screen with specific tab
  /// 
  /// Parameters:
  /// - [tabIndex]: Index of the tab to open (0: Home, 1: My Cases, 2: Case Details, 3: Map)
  /// - [clearStack]: Whether to clear the navigation stack (default: true)
  static void navigateToTab(int tabIndex, {bool clearStack = true}) {
    if (tabIndex < 0 || tabIndex > 3) {
      throw ArgumentError('Tab index must be between 0 and 3');
    }
    
    if (clearStack) {
      Get.offAllNamed(AppRoutes.mainNavigation, arguments: tabIndex);
    } else {
      Get.toNamed(AppRoutes.mainNavigation, arguments: tabIndex);
    }
  }
  
  /// Navigate to Home tab (index 0)
  static void goToHome({bool clearStack = true}) {
    navigateToTab(0, clearStack: clearStack);
  }
  
  /// Navigate to My Cases tab (index 1)  
  static void goToMyCases({bool clearStack = true}) {
    navigateToTab(1, clearStack: clearStack);
  }
  
  /// Navigate to Case Details tab (index 2)
  static void goToCaseDetails({bool clearStack = true}) {
    navigateToTab(2, clearStack: clearStack);
  }
  
  /// Navigate to Map tab (index 3)
  static void goToMap({bool clearStack = true}) {
    navigateToTab(3, clearStack: clearStack);
  }
  
  /// Check if main navigation controller is initialized and update its state
  /// This is useful when you want to change tabs without full navigation
  static void switchTab(int tabIndex) {
    if (tabIndex < 0 || tabIndex > 3) {
      throw ArgumentError('Tab index must be between 0 and 3');
    }
    
    if (Get.isRegistered<MainNavigationController>()) {
      final controller = Get.find<MainNavigationController>();
      controller.changeIndex(tabIndex);
    } else {
      // If controller not found, perform full navigation
      navigateToTab(tabIndex);
    }
  }
  
  /// Get current tab index if controller is available
  static int? getCurrentTabIndex() {
    if (Get.isRegistered<MainNavigationController>()) {
      final controller = Get.find<MainNavigationController>();
      return controller.currentIndex;
    }
    return null;
  }
}
