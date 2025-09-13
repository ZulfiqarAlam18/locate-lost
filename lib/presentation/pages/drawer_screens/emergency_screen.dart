import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/presentation/widgets/custom_app_bar.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  // Emergency contacts specific to Pakistan
  final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      title: 'Police Emergency',
      number: '15',
      description: 'Report missing person immediately',
      icon: Icons.local_police,
      color: Colors.blue,
      isPrimary: true,
    ),
    EmergencyContact(
      title: 'National Helpline',
      number: '1122',
      description: 'Emergency rescue services',
      icon: Icons.medical_services,
      color: Colors.red,
      isPrimary: true,
    ),
    EmergencyContact(
      title: 'Child Protection',
      number: '1121',
      description: 'Child helpline & protection',
      icon: Icons.child_care,
      color: Colors.orange,
      isPrimary: false,
    ),
    EmergencyContact(
      title: 'Women Helpline',
      number: '1043',
      description: 'Women & child safety',
      icon: Icons.support_agent,
      color: Colors.purple,
      isPrimary: false,
    ),
    EmergencyContact(
      title: 'Edhi Foundation',
      number: '115',
      description: 'Lost & found assistance',
      icon: Icons.volunteer_activism,
      color: Colors.green,
      isPrimary: false,
    ),
  ];

  void _copyToClipboard(String number, String title) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title number copied: $number'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Emergency Contacts',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Info Card
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red.shade400, Colors.red.shade600],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emergency,
                    color: Colors.white,
                    size: 32.w,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Emergency Assistance',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Quick access to emergency services for missing person cases',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Primary Emergency Numbers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Immediate Emergency',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...emergencyContacts.where((contact) => contact.isPrimary).map(
                        (contact) => _buildEmergencyCard(contact),
                      ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Additional Support Numbers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Support',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...emergencyContacts.where((contact) => !contact.isPrimary).map(
                        (contact) => _buildEmergencyCard(contact),
                      ),
                ],
              ),
            ),

            // Important Tips Card
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20.w),
                      SizedBox(width: 8.w),
                      Text(
                        'Important Tips',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _buildTipItem('Stay calm and provide clear information'),
                  _buildTipItem('Have recent photos ready to share'),
                  _buildTipItem('Note the exact time and location last seen'),
                  _buildTipItem('Contact multiple agencies for faster response'),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(EmergencyContact contact) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
        border: Border.all(
          color: contact.color.withOpacity(0.2),
          width: 1.5.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: contact.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                contact.icon,
                color: contact.color,
                size: 24.w,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    contact.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: contact.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      contact.number,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: contact.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _copyToClipboard(contact.number, contact.title),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.copy,
                  color: AppColors.primary,
                  size: 20.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h, right: 8.w),
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.blue.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Emergency Contact Model
class EmergencyContact {
  final String title;
  final String number;
  final String description;
  final IconData icon;
  final Color color;
  final bool isPrimary;

  EmergencyContact({
    required this.title,
    required this.number,
    required this.description,
    required this.icon,
    required this.color,
    required this.isPrimary,
  });
}
