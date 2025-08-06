import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/widgets/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/app_colors.dart';
import '../routes/app_routes.dart';
import '../utils/dialog_utils.dart';
import 'founder_screens/found_person_details.dart';

// Finder Case data model
class FinderCaseData {
  final String caseId;
  final String caseType;
  final String status;
  final DateTime reportedDate;
  final String foundPersonDescription;
  final String estimatedAge;
  final String gender;
  final String foundLocation;
  final String finderName;
  final String finderPhone;
  final String finderEmail;
  final String circumstances;
  final List<String> capturedImages;
  final String physicalDescription;
  final String clothingDescription;
  final DateTime foundTime;
  final String currentLocation;
  final FinderCaseStatus currentStatus;
  final FinderCasePriority priority;
  final String additionalNotes;
  final bool isPersonSafe;
  final bool needsMedicalAttention;

  FinderCaseData({
    required this.caseId,
    required this.caseType,
    required this.status,
    required this.reportedDate,
    required this.foundPersonDescription,
    required this.estimatedAge,
    required this.gender,
    required this.foundLocation,
    required this.finderName,
    required this.finderPhone,
    required this.finderEmail,
    required this.circumstances,
    required this.capturedImages,
    required this.physicalDescription,
    required this.clothingDescription,
    required this.foundTime,
    required this.currentLocation,
    required this.currentStatus,
    required this.priority,
    required this.additionalNotes,
    required this.isPersonSafe,
    required this.needsMedicalAttention,
  });
}

enum FinderCaseStatus { reported, investigating, matched, reunited, closed }

enum FinderCasePriority { low, medium, high, urgent }

class FinderCaseSummaryScreen extends StatefulWidget {
  final FinderCaseData? caseData;

  const FinderCaseSummaryScreen({super.key, this.caseData});

  @override
  State<FinderCaseSummaryScreen> createState() =>
      _FinderCaseSummaryScreenState();
}

class _FinderCaseSummaryScreenState extends State<FinderCaseSummaryScreen>
    with TickerProviderStateMixin {
  late FinderCaseData caseData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    // Use provided data or create sample data
    caseData = widget.caseData ?? _getSampleFinderCaseData();
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

  FinderCaseData _getSampleFinderCaseData() {
    return FinderCaseData(
      caseId:
          'FP-2024-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      caseType: 'Found Person Report',
      status: 'Reported - Awaiting Match',
      reportedDate: DateTime.now().subtract(Duration(hours: 3)),
      foundPersonDescription:
          'Young girl found wandering alone, appears lost and confused',
      estimatedAge: '7-9 years old',
      gender: 'Female',
      foundLocation: 'Shopping Mall, Food Court Area, Main Street',
      finderName: 'Michael Rodriguez',
      finderPhone: '+1 (555) 456-7890',
      finderEmail: 'michael.rodriguez@email.com',
      circumstances:
          'Found the child crying near the food court. She seemed lost and was looking for her mother. Currently staying with security.',
      capturedImages: [
        'assets/images/Map1.png', // Photos taken by finder
        'assets/images/Map2.png',
        'assets/images/Map3.png',
      ],
      physicalDescription:
          'Approx. 4\'0" tall, Brown hair in pigtails, Brown eyes, Small build',
      clothingDescription:
          'Pink dress with white flowers, white sneakers, small purple backpack',
      foundTime: DateTime.now().subtract(Duration(hours: 3, minutes: 30)),
      currentLocation: 'Mall Security Office - Safe and supervised',
      currentStatus: FinderCaseStatus.reported,
      priority: FinderCasePriority.high,
      additionalNotes:
          'Child appears healthy and unharmed. Speaking clearly and knows her first name. Security has provided snacks and comfort.',
      isPersonSafe: true,
      needsMedicalAttention: false,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor(FinderCaseStatus status) {
    switch (status) {
      case FinderCaseStatus.reported:
        return Colors.blue;
      case FinderCaseStatus.investigating:
        return Colors.orange;
      case FinderCaseStatus.matched:
        return Colors.purple;
      case FinderCaseStatus.reunited:
        return Colors.green;
      case FinderCaseStatus.closed:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(FinderCasePriority priority) {
    switch (priority) {
      case FinderCasePriority.low:
        return Colors.green;
      case FinderCasePriority.medium:
        return Colors.orange;
      case FinderCasePriority.high:
        return Colors.red;
      case FinderCasePriority.urgent:
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
        text: 'Found Person Report',
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(),
              _buildSafetyStatusCard(),
              _buildFoundPersonDetailsCard(),
              _buildCapturedImagesSection(),
              _buildFinderInfoCard(),
              _buildLocationAndTimeCard(),
              _buildCircumstancesCard(),
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
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
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
                child: Icon(Icons.person_add, color: Colors.white, size: 24.w),
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

  Widget _buildSafetyStatusCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Safety Status',
        icon: Icons.security,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color:
                          caseData.isPersonSafe
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color:
                            caseData.isPersonSafe
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          caseData.isPersonSafe
                              ? Icons.check_circle
                              : Icons.warning,
                          color:
                              caseData.isPersonSafe ? Colors.green : Colors.red,
                          size: 32.w,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          caseData.isPersonSafe
                              ? 'Person is Safe'
                              : 'Safety Concern',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                caseData.isPersonSafe
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color:
                          !caseData.needsMedicalAttention
                              ? Colors.green.shade50
                              : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color:
                            !caseData.needsMedicalAttention
                                ? Colors.green.shade200
                                : Colors.orange.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          !caseData.needsMedicalAttention
                              ? Icons.favorite
                              : Icons.medical_services,
                          color:
                              !caseData.needsMedicalAttention
                                  ? Colors.green
                                  : Colors.orange,
                          size: 32.w,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          !caseData.needsMedicalAttention
                              ? 'No Medical Need'
                              : 'Needs Medical Care',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                !caseData.needsMedicalAttention
                                    ? Colors.green.shade700
                                    : Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: _getStatusColor(caseData.currentStatus),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          caseData.status,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(caseData.currentStatus),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      caseData.currentLocation,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoundPersonDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Found Person Description',
        icon: Icons.person,
        child: Column(
          children: [
            _buildDetailRow('Description', caseData.foundPersonDescription),
            _buildDetailRow('Estimated Age', caseData.estimatedAge),
            _buildDetailRow('Gender', caseData.gender),
            _buildDetailRow(
              'Physical Description',
              caseData.physicalDescription,
            ),
            _buildDetailRow('Clothing', caseData.clothingDescription),
          ],
        ),
      ),
    );
  }

  Widget _buildCapturedImagesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Captured Photos',
        icon: Icons.camera_alt,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (caseData.capturedImages.isNotEmpty) ...[
              _buildImageGalleryHeader(
                'Photos You Captured',
                caseData.capturedImages.length,
              ),
              SizedBox(height: 12.h),
              _buildImageCarousel(caseData.capturedImages),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.green.shade600, size: 16.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'These photos will help law enforcement and families identify the found person.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.green.shade700,
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
                      Icons.add_a_photo,
                      size: 48.w,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No photos captured yet',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to camera screen
                      },
                      icon: Icon(Icons.camera_alt, size: 16.w),
                      label: Text('Capture Photos'),
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
        Icon(Icons.photo_camera, size: 18.w, color: AppColors.primary),
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
                      child: Image.asset(
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
                          'Captured Photos',
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
                              child: Image.asset(
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

  Widget _buildFinderInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Your Information (Finder)',
        icon: Icons.person_pin,
        child: Column(
          children: [
            _buildDetailRow('Your Name', caseData.finderName),
            _buildContactRow(
              'Phone',
              caseData.finderPhone,
              Icons.phone,
              () => _makePhoneCall(caseData.finderPhone),
            ),
            _buildContactRow(
              'Email',
              caseData.finderEmail,
              Icons.email,
              () => _sendEmail(caseData.finderEmail),
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
        title: 'Location & Time Found',
        icon: Icons.location_on,
        child: Column(
          children: [
            _buildDetailRow('Found Location', caseData.foundLocation),
            _buildDetailRow('Found Time', _formatDateTime(caseData.foundTime)),
            _buildDetailRow('Current Location', caseData.currentLocation),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: () => _openMap(caseData.foundLocation),
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

  Widget _buildCircumstancesCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _buildModernCard(
        title: 'Circumstances & Notes',
        icon: Icons.description,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How You Found This Person',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              caseData.circumstances,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Additional Notes',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              caseData.additionalNotes,
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
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _contactAuthorities(),
                  icon: Icon(Icons.local_police, size: 18.w),
                  label: Text('Contact Police'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                    side: BorderSide(color: Colors.blue[700]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _shareReport(),
                  icon: Icon(Icons.share, size: 18.w),
                  label: Text('Share Report'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action methods
  void _editReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoundPersonDetailsScreen()),
    );
  }

  void _submitReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text('Submit Found Person Report'),
        content: Text(
          'Are you sure you want to submit this report? It will be shared with law enforcement and families searching for missing persons.',
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
  
  void _performSubmission() async {
    // Show loading indicator
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
              Text('Submitting report...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    // Close loading dialog
    Get.back();
    
    // Simulate success/failure (replace with actual API logic)
    bool isSuccess = DateTime.now().millisecondsSinceEpoch % 2 == 0; // Random success/failure for demo
    
    if (isSuccess) {
      DialogUtils.showCaseSubmissionSuccess(
        title: 'Found Person Report Submitted!',
        message: 'Your report has been submitted successfully. We\'ll help match this person with missing person reports.',
        onViewCases: () {
          Get.toNamed(AppRoutes.myCases);
        },
      );
    } else {
      DialogUtils.showCaseSubmissionError(
        title: 'Found Person Report Failed',
        message: 'Unable to submit your found person report. Please check your connection and try again.',
        onRetry: () {
          _performSubmission(); // Retry submission
        },
      );
    }
  }

  void _contactAuthorities() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting local authorities...'),
        backgroundColor: Colors.blue[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing found person report...'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

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

  void _sendEmail(String email) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email: $email'),
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
