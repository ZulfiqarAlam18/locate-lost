import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:locate_lost/controllers/my_cases_controller.dart';
import 'package:locate_lost/data/models/finder_report/finder_report_by_id_response.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class FinderCaseDetailScreen extends StatefulWidget {
  final String reportId;

  const FinderCaseDetailScreen({super.key, required this.reportId});

  @override
  State<FinderCaseDetailScreen> createState() => _FinderCaseDetailScreenState();
}

class _FinderCaseDetailScreenState extends State<FinderCaseDetailScreen> with TickerProviderStateMixin {
  late final MyCasesController controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MyCasesController>();
    _setupAnimations();
    _loadReportDetails();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  Future<void> _loadReportDetails() async {
    await controller.fetchFinderReportById(widget.reportId);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  String _getStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return 'Active';
      case 'CLOSED':
        return 'Closed';
      case 'RESOLVED':
        return 'Resolved';
      case 'CANCELLED':
        return 'Cancelled';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return AppColors.statusActive;
      case 'CLOSED':
        return AppColors.textSecondary;
      case 'RESOLVED':
        return AppColors.statusResolved;
      case 'CANCELLED':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Found Case Details',
        onPressed: () => Get.back(),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: Obx(() {
        if (controller.isLoading.value && controller.selectedFinderReportDetail.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.primary),
                SizedBox(height: 16.h),
                Text(
                  'Loading case details...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty && controller.selectedFinderReportDetail.value == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80.w, color: AppColors.error),
                  SizedBox(height: 16.h),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: _loadReportDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final report = controller.selectedFinderReportDetail.value;
        if (report == null) {
          return Center(child: Text('No data available'));
        }

        return _buildCaseContent(report);
      }),
    );
  }

  Widget _buildCaseContent(FinderReportDetail report) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(report),
            _buildFoundPersonDetailsCard(report),
            _buildUploadedImagesSection(report),
            _buildContactInfoCard(report),
            _buildLocationAndTimeCard(report),
            if (report.additionalDetails != null && report.additionalDetails!.isNotEmpty)
              _buildDescriptionCard(report),
            if (report.matchesAsFinder.isNotEmpty)
              _buildMatchesSection(report),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.person_pin, color: Colors.white, size: 32.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Found Person Report',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ID: ${report.id.substring(0, 8).toUpperCase()}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(report.status),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _getStatusText(report.status),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoBadge(Icons.access_time, 'Reported', _formatDateTime(report.createdAt)),
              _buildInfoBadge(Icons.location_on, 'Location', report.placeFound ?? 'Unknown'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20.w),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFoundPersonDetailsCard(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.green.shade600, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Found Person Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Name', report.childName ?? 'Unknown'),
          _buildDetailRow('Father Name', report.fatherName ?? 'Unknown'),
          _buildDetailRow('Gender', report.gender ?? 'Not specified'),
          _buildDetailRow('Found Time', _formatDateTime(report.foundTime)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedImagesSection(FinderReportDetail report) {
    if (report.images.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.photo_library, color: Colors.green.shade600, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Uploaded Images',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.h,
              enlargeCenterPage: true,
              enableInfiniteScroll: report.images.length > 1,
              autoPlay: report.images.length > 1,
              viewportFraction: 0.8,
            ),
            items: report.images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image, size: 48.w, color: Colors.grey[600]),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Failed to load image',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_phone, color: Colors.green.shade600, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Finder Name', report.finder.name),
          if (report.contactNumber != null)
            _buildDetailRow('Contact', report.contactNumber!),
          if (report.emergency != null)
            _buildDetailRow('Emergency', report.emergency!),
          if (report.finder.email != null)
            _buildDetailRow('Email', report.finder.email!),
        ],
      ),
    );
  }

  Widget _buildLocationAndTimeCard(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green.shade600, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Location & Time Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Place Found', report.placeFound ?? 'Not specified'),
          _buildDetailRow('Found Time', _formatDateTime(report.foundTime)),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: Colors.green.shade600, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Additional Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            report.additionalDetails ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesSection(FinderReportDetail report) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: Colors.amber.shade700, size: 24.w),
              SizedBox(width: 8.w),
              Text(
                'Potential Matches (${report.matchesAsFinder.length})',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...report.matchesAsFinder.map((match) => _buildMatchCard(match)),
        ],
      ),
    );
  }

  Widget _buildMatchCard(MatchInfo match) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match.parentCase.childName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(match.status),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  match.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Father: ${match.parentCase.fatherName}',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
          ),
          Text(
            'Match confidence: ${(match.matchConfidence * 100).toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          Text(
            'Lost time: ${_formatDateTime(match.parentCase.lostTime)}',
            style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
