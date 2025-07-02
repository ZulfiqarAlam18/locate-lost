import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/widgets/custom_app_bar.dart';
import '../../utils/app_colors.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Emergency',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: RichText(
              text: TextSpan(
                text:
                    'If you ever find yourself in an emergency or a difficult situation,'
                    " don't hesitate to reach out for help. Below are important contact numbers for immediate assistance in Pakistan. Whether it's medical aid, law enforcement, "
                    'fire rescue, or protection services, '
                    'these helplines are available to support you. ',
                style: TextStyle(
                  color: AppColors.myBlackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Stay safe and save these numbers for quick access!',
                    style: TextStyle(color: AppColors.myRedColor),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColors.primary, endIndent: 80.w, indent: 80.w),
          ...List.generate(5, (index) => buildExpansionCard()),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              '"A strong society is one that stands together in times of need. '
              "Helping those in distress isn't just kindness—it's our"
              ' shared responsibility."',
              style: TextStyle(
                color: AppColors.myBlackColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpansionCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(width: 1.w, color: AppColors.primary),
      ),
      margin: EdgeInsets.all(10.w),
      child: ExpansionTile(
        title: Text(
          'What this app is about?',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        iconColor: AppColors.primary,
        textColor: AppColors.primary,
        collapsedTextColor: AppColors.primary,
        collapsedIconColor: AppColors.primary,
        children: [
          Container(
            width: double.infinity,
            color: Colors.teal[100],
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Smarter Solution for reuniting missing children with their parents, with advanced AI features. LoCAT helps by utilizing modern technologies for efficient and fast reunification.',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
