import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

class MainBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Define meaningful icons for each navigation item
  static const List<IconData> _navigationIcons = [
    Icons.home_rounded,           // Home - rounded home icon
    Icons.folder_open_rounded,    // My Cases - folder for case management
    Icons.analytics_rounded,      // Case Details - analytics/status view
    Icons.map_rounded,            // Map Nearby - map location icon
  ];

  static const List<IconData> _navigationIconsOutlined = [
    Icons.home_outlined,          // Home outline
    Icons.folder_outlined,        // My Cases outline
    Icons.analytics_outlined,     // Case Details outline
    Icons.map_outlined,           // Map Nearby outline
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) => 
            _buildNavItem(
              icon: _navigationIconsOutlined[index],
              selectedIcon: _navigationIcons[index],
              index: index,
              isSelected: currentIndex == index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 56.w,
        height: 56.h,
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Icon(
            isSelected ? selectedIcon : icon,
            key: ValueKey('${index}_${isSelected}'),
            color: isSelected ? Colors.white : AppColors.textMuted,
            size: 24.w,
          ),
        ),
      ),
    );
  }
}

class MainNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
    }
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
