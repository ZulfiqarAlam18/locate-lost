import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/presentation/widgets/custom_app_bar.dart';
import 'package:locate_lost/core/constants/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        text: 'Contact Us',
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'d love to hear from you!',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Feel free to share any feedback, questions or issues you\'re facing.',
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your Message',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  // You can add logic to send message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your message has been sent!'),
                    ),
                  );
                },
                child: Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
