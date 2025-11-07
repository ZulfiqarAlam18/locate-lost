import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/utils/utils/dialog_utils.dart';
import 'package:locate_lost/utils/utils/navigation_helper.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

// Parent Case data model
class ParentCaseData {
  final String caseId;
  final String caseType;
  final String status;
  final DateTime reportedDate;
  final String missingPersonName;
  final String fatherName;
  final String gender;
  final String lastSeenLocation;
  final String lastSeenDate;
  final String lastSeenTime;
  final String primaryPhone;
  final String secondaryPhone;
  final String additionalDetails;
  final List<String> uploadedImages;
  final DateTime lastSeenDateTime;
  final CaseStatus currentStatus;
  final CasePriority priority;

  ParentCaseData({
    required this.caseId,
    required this.caseType,
    required this.status,
    required this.reportedDate,
    required this.missingPersonName,
    required this.fatherName,
    required this.gender,
    required this.lastSeenLocation,
    required this.lastSeenDate,
    required this.lastSeenTime,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.additionalDetails,
    required this.uploadedImages,
    required this.lastSeenDateTime,
    required this.currentStatus,
    required this.priority,
  });
}

enum CaseStatus { active, investigating, resolved, cold, closed }

enum CasePriority { low, medium, high, critical }

class ParentCaseSummaryScreen extends StatefulWidget {
  final ParentCaseData? caseData;

  const ParentCaseSummaryScreen({super.key, this.caseData});

  @override
  State<ParentCaseSummaryScreen> createState() =>
      _ParentCaseSummaryScreenState();
}

class _ParentCaseSummaryScreenState extends State<ParentCaseSummaryScreen>
    with TickerProviderStateMixin {
  late ParentCaseData caseData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  // MissingPersonController removed — UI-only mode

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    // Use provided data or create data from controller
    caseData = widget.caseData ?? _getDataFromController();
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

  ParentCaseData _getDataFromController() {
    // UI-only: return default placeholder data
    return ParentCaseData(
      caseId: 'MP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      caseType: 'Missing Person Report',
      status: 'Draft - Ready to Submit',
      reportedDate: DateTime.now(),
      missingPersonName: 'Not specified',
      fatherName: 'Not specified',
      gender: 'Not specified',
      lastSeenLocation: 'Not specified',
      lastSeenDate: 'Not specified',
      lastSeenTime: 'Not specified',
      primaryPhone: 'Not specified',
      secondaryPhone: 'Not provided',
      additionalDetails: 'No additional details provided',
      uploadedImages: [],
      lastSeenDateTime: DateTime.now(),
      currentStatus: CaseStatus.active,
      priority: CasePriority.high,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getPriorityColor(CasePriority priority) {
    switch (priority) {
      case CasePriority.low:
        return Colors.green;
      case CasePriority.medium:
        return Colors.orange;
      case CasePriority.high:
        return Colors.red;
      case CasePriority.critical:
        return Colors.purple;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Missing Person Report',
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(),
              _buildMissingPersonDetailsCard(),
              _buildUploadedImagesSection(),
              _buildReporterInfoCard(),
              _buildLocationAndTimeCard(),
              _buildDescriptionCard(),
              _buildActionButtons(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.shade400, Colors.red.shade600],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 15.r,
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
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.person_search,
                  color: Colors.white,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Case ID: ${caseData.caseId}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Reported: ${_formatDateTime(caseData.reportedDate)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getPriorityColor(caseData.priority),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  caseData.priority.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissingPersonDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Missing Person Information',
        icon: Icons.person,
        child: Column(
          children: [
            _buildDetailRow('Name', caseData.missingPersonName),
            _buildDetailRow('Father\'s Name', caseData.fatherName),
            _buildDetailRow('Gender', caseData.gender),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedImagesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Uploaded Photos',
        icon: Icons.photo_library,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (caseData.uploadedImages.isNotEmpty) ...[
              _buildImageGalleryHeader(
                'Recent Photos of Missing Person',
                caseData.uploadedImages.length,
              ),
              SizedBox(height: 12.h),
              _buildImageCarousel(caseData.uploadedImages),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue.shade600, size: 16.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'These photos will be shared with law enforcement and volunteers to help locate your missing person.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 48.w,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No photos uploaded yet',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to upload screen
                      },
                      icon: Icon(Icons.camera_alt, size: 16.w),
                      label: Text('Add Photos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageGalleryHeader(String title, int count) {
    return Row(
      children: [
        Icon(Icons.photo, size: 18.w, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    return Container(
      height: 120.h,
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () => _showImagePreview(images, index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: images[index].startsWith('assets/')
                          ? Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image,
                                        size: 32.w,
                                        color: Colors.grey[500],
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Image not found',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Image.file(
                              File(images[index]),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image,
                                        size: 32.w,
                                        color: Colors.grey[500],
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Image not found',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    Positioned(
                      bottom: 4.h,
                      right: 4.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${index + 1}/${images.length}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 120.h,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          viewportFraction: 0.3,
          padEnds: false,
        ),
      ),
    );
  }

  void _showImagePreview(List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(maxHeight: 500.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uploaded Photos',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: CarouselSlider.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: images[index].startsWith('assets/')
                                  ? Image.asset(
                                      images[index],
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.broken_image,
                                                size: 64.w,
                                                color: Colors.grey[400],
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                'Image not available',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Image.file(
                                      File(images[index]),
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.broken_image,
                                                size: 64.w,
                                                color: Colors.grey[400],
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                'Image not available',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 350.h,
                          enlargeCenterPage: true,
                          initialPage: initialIndex,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.9,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      'Swipe to view all photos',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildReporterInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Contact Information',
        icon: Icons.contact_phone,
        child: Column(
          children: [
            _buildContactRow(
              'Primary Phone',
              caseData.primaryPhone,
              Icons.phone,
              () => _makePhoneCall(caseData.primaryPhone),
            ),
            if (caseData.secondaryPhone.isNotEmpty && 
                caseData.secondaryPhone != 'Not provided' && 
                caseData.secondaryPhone != 'Not specified' &&
                caseData.secondaryPhone.length >= 10) // Ensure it's a valid phone number
              _buildContactRow(
                'Secondary Phone',
                caseData.secondaryPhone,
                Icons.phone_android,
                () => _makePhoneCall(caseData.secondaryPhone),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationAndTimeCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Last Known Location & Time',
        icon: Icons.location_on,
        child: Column(
          children: [
            _buildDetailRow('Last Seen Location', caseData.lastSeenLocation),
            _buildDetailRow('Last Seen Date', caseData.lastSeenDate),
            _buildDetailRow('Last Seen Time', caseData.lastSeenTime),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: () => _openMap(caseData.lastSeenLocation),
              icon: Icon(Icons.map, size: 18.w),
              label: Text('View on Map'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                foregroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Additional Details',
        icon: Icons.description,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              caseData.additionalDetails,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20.w),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            child,
          ],
        ),
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
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Icon(icon, size: 16.w, color: AppColors.primary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _editReport(),
                  icon: Icon(Icons.edit, size: 18.w),
                  label: Text('Edit Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _submitReport(),
                  icon: Icon(Icons.send, size: 18.w),
                  label: Text('Submit Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Row(
          //   children: [
          //     Expanded(
          //       child: OutlinedButton.icon(
          //         onPressed: () => _shareReport(),
          //         icon: Icon(Icons.share, size: 18.w),
          //         label: Text('Share Missing Person'),
          //         style: OutlinedButton.styleFrom(
          //           foregroundColor: AppColors.primary,
          //           side: BorderSide(color: AppColors.primary),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12.r),
          //           ),
          //           padding: EdgeInsets.symmetric(vertical: 14.h),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 12.w),
          //     Expanded(
          //       child: OutlinedButton.icon(
          //         onPressed: () => _exportReport(),
          //         icon: Icon(Icons.print, size: 18.w),
          //         label: Text('Print Flyer'),
          //         style: OutlinedButton.styleFrom(
          //           foregroundColor: Colors.grey[700],
          //           side: BorderSide(color: Colors.grey[400]!),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12.r),
          //           ),
          //           padding: EdgeInsets.symmetric(vertical: 14.h),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 12.h),
          // Test connectivity button for debugging
          // SizedBox(
          //   width: double.infinity,
          //   child: OutlinedButton.icon(
          //     onPressed: () => _testConnectivity(),
          //     icon: Icon(Icons.wifi, size: 18.w),
          //     label: Text('Test Backend Connection'),
          //     style: OutlinedButton.styleFrom(
          //       foregroundColor: Colors.blue,
          //       side: BorderSide(color: Colors.blue),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12.r),
          //       ),
          //       padding: EdgeInsets.symmetric(vertical: 14.h),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Action methods
  void _editReport() {
    Get.toNamed(AppRoutes.missingPersonDetails);
  }

  void _submitReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text('Submit Missing Person Report'),
        content: Text(
          'Are you sure you want to submit this report? Once submitted, it will be shared with law enforcement and volunteers.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performSubmission();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Submit Report',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // // Test backend connectivity
  // void _testConnectivity() async {
  //   Get.snackbar(
  //     'Testing Connection',
  //     'Checking backend connectivity...',
  //     snackPosition: SnackPosition.TOP,
  //     backgroundColor: Colors.blue,
  //     colorText: Colors.white,
  //   );

  //   try {
  //     final baseService = BaseApiService();
      
  //     // Check authentication token first
  //     final token = baseService.getAuthToken();
  //     print('--- AUTH TOKEN CHECK ---');
  //     print('Token exists: ${token != null}');
  //     if (token != null) {
  //       print('Token preview: ${token.substring(0, 20)}...');
  //     } else {
  //       print('No authentication token found!');
  //     }

  //     final isConnected = await baseService.testConnectivity();
      
  //     if (isConnected) {
  //       Get.snackbar(
  //         'Connection Successful',
  //         'Backend server is reachable! ${token != null ? "Auth token found." : "No auth token."}',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 3),
  //       );
  //     } else {
  //       Get.snackbar(
  //         'Connection Failed',
  //         'Cannot reach backend server',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 3),
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Connection Error',
  //       'Error: $e',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       duration: Duration(seconds: 5),
  //     );
  //   }
  // }
  
  void _performSubmission() async {
    // UI-only: simulate submission with loading
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 16.h),
              Text('Submitting report to authorities...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(Duration(seconds: 1));
    Get.back();

    // Simulate success
    DialogUtils.showCaseSubmissionSuccess(
      onViewCases: () {
        NavigationHelper.goToMyCases();
      },
    );
  }

  // Sharing and export helpers removed in UI-only mode

  void _makePhoneCall(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call: $phone'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _openMap(String location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening map for: $location'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
