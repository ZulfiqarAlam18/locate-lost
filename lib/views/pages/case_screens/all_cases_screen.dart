import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

class AllCasesScreen extends StatefulWidget {
  const AllCasesScreen({Key? key}) : super(key: key);

  @override
  _AllCasesScreenState createState() => _AllCasesScreenState();
}

class _AllCasesScreenState extends State<AllCasesScreen> {
  // Controller removed — use local placeholder list for UI-only mode
  final List<Map<String, dynamic>> submittedCases = [];

  @override
  void initState() {
    super.initState();
    // No backend: submittedCases remains empty unless populated locally
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'My Cases',
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: submittedCases.isEmpty ? _buildEmptyState() : _buildCasesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20.h),
          Text(
            'No Cases Submitted Yet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your submitted missing person reports\nwill appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to new report
              Get.toNamed('/missing-person-details');
            },
            icon: Icon(Icons.add),
            label: Text('Report Missing Person'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCasesList() {
    return RefreshIndicator(
      onRefresh: () async {
        // No backend: nothing to refresh
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: submittedCases.length,
        itemBuilder: (context, index) {
          final caseData = submittedCases[index];
          return _buildCaseCard(caseData, index);
        },
      ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caseData['childName'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Case #${caseData['id'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(caseData['status'] ?? 'Unknown'),
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(Icons.person, 'Age', '${caseData['age'] ?? 'N/A'} years old'),
            _buildInfoRow(Icons.location_on, 'Last Seen', caseData['placeLost'] ?? 'Unknown'),
            _buildInfoRow(Icons.access_time, 'Reported', _formatDateTime(caseData['createdAt'] ?? DateTime.now())),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewCaseDetails(caseData),
                    icon: Icon(Icons.visibility, size: 16.w),
                    label: Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _shareCaseInfo(caseData),
                    icon: Icon(Icons.share, size: 16.w),
                    label: Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 16.w, color: Colors.grey.shade600),
          SizedBox(width: 8.w),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;
    
    switch (status.toLowerCase()) {
      case 'active':
      case 'investigating':
        chipColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'resolved':
        chipColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'closed':
        chipColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      default:
        chipColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  void _viewCaseDetails(Map<String, dynamic> caseData) {
    Get.snackbar(
      'Case Details',
      'Viewing details for ${caseData['childName'] ?? 'Unknown'}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
    // You can navigate to a detailed case view screen here
  }

  void _shareCaseInfo(Map<String, dynamic> caseData) {
    Get.snackbar(
      'Share Case',
      'Sharing case information for ${caseData['childName'] ?? 'Unknown'}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
    // You can implement sharing functionality here
  }
}