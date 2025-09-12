import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_app_bar.dart';
import 'package:locate_lost/presentation/widgets/main_bottom_navigation.dart';

class MapNearbyReportsScreen extends StatefulWidget {
  final bool isInNavigation;

  const MapNearbyReportsScreen({super.key, this.isInNavigation = false});

  @override
  State<MapNearbyReportsScreen> createState() => _MapNearbyReportsScreenState();
}

class _MapNearbyReportsScreenState extends State<MapNearbyReportsScreen> {
  bool _isLoading = false;
  bool _showList = false;
  late MainNavigationController navController;

  // Dummy nearby reports data
  final List<Map<String, dynamic>> nearbyReports = [
    {
      'id': 'MP-003',
      'name': 'Michael Brown',
      'age': 15,
      'type': 'missing',
      'distance': '0.5 km',
      'lastSeen': 'Central Mall',
      'time': '3 hours ago',
      'image': 'assets/images/ali.png',
      'latitude': 24.8607,
      'longitude': 67.0011,
    },
    {
      'id': 'FP-002',
      'name': 'Lisa Garcia',
      'age': 12,
      'type': 'found',
      'distance': '1.2 km',
      'location': 'Park Avenue',
      'time': '6 hours ago',
      'image': 'assets/images/zulfiqar.png',
      'latitude': 24.8747,
      'longitude': 67.0299,
    },
    {
      'id': 'MP-004',
      'name': 'David Wilson',
      'age': 9,
      'type': 'missing',
      'distance': '2.1 km',
      'lastSeen': 'School Bus Stop',
      'time': '1 day ago',
      'image': 'assets/images/bg.png',
      'latitude': 24.8515,
      'longitude': 67.0173,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize or get the navigation controller
    try {
      navController = Get.find<MainNavigationController>();
    } catch (e) {
      navController = Get.put(MainNavigationController());
    }

    if (!widget.isInNavigation) {
      navController.setIndex(
        3,
      ); // Set Map as active only if not in navigation wrapper
    }
    _loadNearbyReports();
  }

  Future<void> _loadNearbyReports() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call and location services
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Nearby Reports',
        onPressed: () => _loadNearbyReports(),
        icon: Icons.refresh,
      ),
      backgroundColor: AppColors.surfaceVariant,
      body: Column(
        children: [
          _buildToggleButtons(),
          Expanded(child: _showList ? _buildListView() : _buildMapView()),
        ],
      ),

     
      extendBody: !widget.isInNavigation,
      bottomNavigationBar:
          widget.isInNavigation
              ? null
              : Obx(
                () => MainBottomNavigation(
                  currentIndex: navController.selectedIndex.value,
                  onTap: navController.changeIndex,
                ),
              ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showList = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !_showList ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      color:
                          !_showList ? Colors.white : AppColors.textSecondary,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Map View',
                      style: TextStyle(
                        color:
                            !_showList ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showList = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _showList ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      color: _showList ? Colors.white : AppColors.textSecondary,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'List View',
                      style: TextStyle(
                        color:
                            _showList ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    return Container(
      margin: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        widget.isInNavigation ? 200.h : 220.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder for map (you would integrate Google Maps or other map service here)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: AssetImage('assets/images/Map1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Map markers overlay
          ...nearbyReports.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> report = entry.value;

            // Calculate position based on index (dummy positioning)
            double left = 50.0 + (index * 80.0);
            double top = 100.0 + (index * 60.0);

            return Positioned(
              left: left,
              top: top,
              child: _buildMapMarker(report),
            );
          }).toList(),
          // Current location marker
          Positioned(
            left: 50.w,
            top: 50.h,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Icon(Icons.my_location, color: Colors.white, size: 20.w),
            ),
          ),
          // Map controls
          Positioned(
            right: 16.w,
            top: 16.h,
            child: Column(
              children: [
                _buildMapControlButton(Icons.zoom_in, () {}),
                SizedBox(height: 8.h),
                _buildMapControlButton(Icons.zoom_out, () {}),
                SizedBox(height: 8.h),
                _buildMapControlButton(Icons.my_location, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapMarker(Map<String, dynamic> report) {
    bool isMissing = report['type'] == 'missing';
    return GestureDetector(
      onTap: () => _showReportDetails(report),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isMissing ? AppColors.error : AppColors.success,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(
          isMissing ? Icons.person_search : Icons.person_pin,
          color: Colors.white,
          size: 16.w,
        ),
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20.w),
      ),
    );
  }

  Widget _buildListView() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (nearbyReports.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadNearbyReports,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          16.w,
          16.h,
          16.w,
          widget.isInNavigation ? 200.h : 220.h,
        ),
        itemCount: nearbyReports.length,
        itemBuilder: (context, index) {
          final report = nearbyReports[index];
          return _buildReportCard(report);
        },
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    bool isMissing = report['type'] == 'missing';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: InkWell(
          onTap: () => _showReportDetails(report),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        report['image'],
                        width: 70.w,
                        height: 70.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4.w,
                      right: 4.w,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color:
                              isMissing ? AppColors.error : AppColors.success,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          isMissing ? Icons.person_search : Icons.person_pin,
                          color: Colors.white,
                          size: 12.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            report['name'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              report['distance'],
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Age: ${report['age']} • ID: ${report['id']}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        isMissing
                            ? 'Last seen: ${report['lastSeen']}'
                            : 'Found at: ${report['location']}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        report['time'],
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
                    SizedBox(height: 8.h),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textMuted,
                      size: 16.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        widget.isInNavigation ? 200.h : 220.h,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16.h),
            Text(
              'Loading nearby reports...',
              style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          32.w,
          32.h,
          32.w,
          widget.isInNavigation ? 232.h : 252.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 80.w, color: AppColors.textMuted),
            SizedBox(height: 24.h),
            Text(
              'No Nearby Reports',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'No missing or found person reports in your area.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: _loadNearbyReports,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Refresh',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetails(Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report Details',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Add detailed report information here
                  Text(
                    'Name: ${report['name']}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    'Age: ${report['age']}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    'Distance: ${report['distance']}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  // Add more details as needed
                ],
              ),
            ),
          ),
    );
  }

  void _showReportOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Report',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                ListTile(
                  leading: Icon(Icons.person_search, color: AppColors.error),
                  title: Text('Report Missing Person'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.reportCase);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: AppColors.success),
                  title: Text('Report Found Person'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.cameraCapture);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
