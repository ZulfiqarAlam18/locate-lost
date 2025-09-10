import 'package:flutter/material.dart';
import 'package:locat_lost/presentation/pages/home_screen.dart';
import 'package:locat_lost/presentation/widgets/main_bottom_navigation.dart';
import 'my_cases_screen.dart';
import 'case_details_screen.dart';
import 'map_nearby_reports_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Store the screens to preserve state
  final List<Widget> _screens = [
    const HomeScreen(isInNavigation: true),
    const MyCasesScreen(isInNavigation: true),
    const CaseDetailsScreen(isInNavigation: true),
    const MapNearbyReportsScreen(isInNavigation: true),
  ];

  void _handleTabChange(int index) {
    print('Tab changed to: $index'); // Debug print
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: MainBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _handleTabChange,
      ),
    );
  }
}
