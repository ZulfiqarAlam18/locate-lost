import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locate_lost/views/pages/bottom_nav_screens/case_details_screen.dart';
import 'package:locate_lost/views/pages/bottom_nav_screens/home_screen.dart';
import 'package:locate_lost/views/pages/bottom_nav_screens/map_nearby_reports_screen.dart';
import 'package:locate_lost/views/pages/bottom_nav_screens/my_cases_screen.dart';
import 'package:locate_lost/views/widgets/main_bottom_navigation.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  
  const MainNavigationScreen({
    super.key, 
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin, RouteAware {
  late int _currentIndex;
  late MainNavigationController _navController;

  // Lazy loading of screens to improve performance
  Widget? _homeScreen;
  Widget? _myCasesScreen;
  Widget? _caseDetailsScreen;
  Widget? _mapScreen;

  @override
  void initState() {
    super.initState();
    
    // Handle navigation arguments from external screens
    final arguments = Get.arguments;
    int targetIndex = widget.initialIndex;
    
    if (arguments != null) {
      // Handle direct int argument (e.g., arguments: 2)
      if (arguments is int && arguments >= 0 && arguments <= 3) {
        targetIndex = arguments;
      }
      // Handle map argument (e.g., arguments: {'initialIndex': 2})
      else if (arguments is Map) {
        if (arguments.containsKey('initialIndex')) {
          final index = arguments['initialIndex'];
          if (index is int && index >= 0 && index <= 3) {
            targetIndex = index;
          }
        } else if (arguments.containsKey('index')) {
          final index = arguments['index'];
          if (index is int && index >= 0 && index <= 3) {
            targetIndex = index;
          }
        }
      }
    }
    
    // Initialize with the target index
    _currentIndex = targetIndex;
    
    // Initialize or get existing GetX controller
    if (Get.isRegistered<MainNavigationController>()) {
      _navController = Get.find<MainNavigationController>();
      // Reset controller state to match the target index
      _navController.setIndex(_currentIndex);
    } else {
      _navController = Get.put(MainNavigationController());
      _navController.setIndex(_currentIndex);
    }
    
    // Initialize only the required screen first
    _initializeScreen(_currentIndex);
  }

  @override
  void dispose() {
    // Don't delete the controller here as it might be used by other screens
    super.dispose();
  }

  // Initialize specific screen based on index
  void _initializeScreen(int index) {
    switch (index) {
      case 0:
        _homeScreen ??= const HomeScreen(isInNavigation: true);
        break;
      case 1:
        _myCasesScreen ??= const MyCasesScreen(isInNavigation: true);
        break;
      case 2:
        _caseDetailsScreen ??= const CaseDetailsScreen(isInNavigation: true);
        break;
      case 3:
        _mapScreen ??= const MapNearbyReportsScreen(isInNavigation: true);
        break;
    }
  }

  // Lazy load screens when needed
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        _homeScreen ??= const HomeScreen(isInNavigation: true);
        return _homeScreen!;
      case 1:
        _myCasesScreen ??= const MyCasesScreen(isInNavigation: true);
        return _myCasesScreen!;
      case 2:
        _caseDetailsScreen ??= const CaseDetailsScreen(isInNavigation: true);
        return _caseDetailsScreen!;
      case 3:
        _mapScreen ??= const MapNearbyReportsScreen(isInNavigation: true);
        return _mapScreen!;
      default:
        return const HomeScreen(isInNavigation: true);
    }
  }

  void _handleTabChange(int index) {
    if (index < 0 || index > 3) {
      debugPrint('Invalid tab index: $index');
      return;
    }
    
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      // Update GetX controller as well for consistency
      _navController.changeIndex(index);
      
      // Pre-load the screen if not already loaded
      _initializeScreen(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (_currentIndex != 0) {
          _handleTabChange(0); // Go to home tab
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _currentIndex,
            children: [
              _getScreen(0), // Home
              _getScreen(1), // My Cases
              _getScreen(2), // Case Details
              _getScreen(3), // Map
            ],
          ),
        ),
        bottomNavigationBar: MainBottomNavigation(
          currentIndex: _currentIndex,
          onTap: _handleTabChange,
        ),
      ),
    );
  }
}
