import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locat_lost/core/constants/app_colors.dart';
import 'package:locat_lost/navigation/app_routes.dart';
import 'package:locat_lost/presentation/widgets/custom_app_bar.dart';
import 'package:locat_lost/presentation/widgets/custom_elevated_button.dart';

class DisplayInfoScreen extends StatefulWidget {
  const DisplayInfoScreen({super.key});

  @override
  State<DisplayInfoScreen> createState() => _DisplayInfoScreenState();
}

class _DisplayInfoScreenState extends State<DisplayInfoScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy data (can be fetched dynamically from backend)
    final List<String> dummyImages = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/140',
      'https://via.placeholder.com/130',
    ];

    final Map<String, String> childDetails = {
      'Name': 'Ali Khan',
      'Age': '6',
      'Gender': 'Male',
      'Clothes': 'Blue Shirt, Black Jeans',
      'Location': 'Lahore Cantt',
    };

    final Map<String, String> parentDetails = {
      'Name': 'Mr. Khan',
      'Phone': '0300-1234567',
      'CNIC': '35201-1234567-1',
    };

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: CustomAppBar(
        text: 'Missing Child Details',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Uploaded Child Images:', style: sectionTitle()),

            SizedBox(height: 10.h),

            SizedBox(
              height: 180.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    width: 140.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.primary),
                      image: DecorationImage(
                        image: NetworkImage(dummyImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.h),

            Divider(color: AppColors.primary, thickness: 1.5.h),

            Text('Child Details:', style: sectionTitle()),

            SizedBox(height: 10.h),

            ..._buildInfoList(childDetails),

            SizedBox(height: 20.h),

            Divider(color: AppColors.primary, thickness: 1.5.h),

            Text('Parent Info:', style: sectionTitle()),

            SizedBox(height: 10.h),

            ..._buildInfoList(parentDetails),

            SizedBox(height: 30.h),

            Center(
              child: CustomElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
                height: 45.h,
                width: 130.w,
                fontSize: 15.sp,
                borderRadius: 10.r,
                label: 'Edit Details',
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoList(Map<String, String> data) {
    return data.entries.map((entry) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, size: 8.sp, color: Colors.grey),
            SizedBox(width: 8.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '${entry.key}: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: entry.value,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  TextStyle sectionTitle() {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }
}
